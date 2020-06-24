import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rxdart/rxdart.dart';

import 'Models/ChatMessage.dart';
import 'Models/ChatRoom.dart';
import 'chat_strings.dart';

class ChatProvider {
  FirebaseDatabase _database;
  FirebaseApp _app;
  String _id_tag;
  String _displayName;
  DatabaseReference _chat;
  PublishSubject<List<ChatRoom>> _roomChatSubject = PublishSubject();
  String _fcmToken;
  String _db_name;
  String roomFuncId;
  List<String> _roomIds = [];
  Function roomFunction;

  // List roomNames = [];
  Map<String, ChatRoom> _rooms = {};

  ChatProvider(String db_name, String tag, List<String> roomIds,
      {String fcmToken}) {
    this._id_tag = tag;
    _fcmToken = fcmToken;
    this._db_name = db_name;
    _roomIds = roomIds;
    _chat = FirebaseDatabase.instance.reference().child(db_name);
  }

  Future<List<ChatRoom>> getRooms(List<String> names) async {
    for (String room in names) {
      await getRoom(room);
    }
    return _rooms.values.toList();
  }

  Future<void> getRoom(String name) async {
    DataSnapshot snapshot = await _chat.child(name).once().catchError((e) {
      print("error: $name: $e");
    });
    if (snapshot.value == null) return;

    ChatRoom chatRoom = parseChatRoom(name, snapshot);
    _rooms[name] = chatRoom;
  }

  Future<Observable<List<ChatRoom>>> listenToRooms() async {
    if (_rooms.isEmpty) {
      await getRooms(_roomIds);
    }
    for (ChatRoom room in _rooms.values) {
      _chat.child(room.id).onValue.listen((Event data) {
        ChatRoom chatRoom = parseChatRoom(room.id, data.snapshot);
        _rooms[chatRoom.id] = chatRoom;
        if (roomFuncId == chatRoom.id && roomFunction != null) {
          roomFunction();
        }
        List<ChatRoom> rooms = _rooms.values.toList();
        rooms.sort((a, b) => a.lastMessage.compareTo(b.lastMessage));
        _roomChatSubject.sink.add(rooms);
      }, onError: (e) {
        print("error: $room: $e");
      });
    }
    return _roomChatSubject.stream;
  }

  ChatRoom parseChatRoom(String roomID, DataSnapshot snapshot) {
    List<ChatMessage> roomBubbles = parseChatBubbles(roomID, snapshot);
    ChatRoom chatRoom =
        ChatRoom.fromJson(json.decode(json.encode(snapshot.value)));
    chatRoom.id = roomID;
    chatRoom.provider = this;
    chatRoom.chat = roomBubbles;
    return chatRoom;
  }

  List<ChatMessage> parseChatBubbles(String roomID, DataSnapshot snapshot) {
    if (snapshot == null ||
        snapshot.value == null ||
        snapshot.value["messages"] == null) return [];
    Iterable sortedKeysItr = snapshot.value["messages"].keys;
    List<String> sortedKeys = List<String>.from(sortedKeysItr);
    sortedKeys.sort();
    List<ChatMessage> roomBubbles = sortedKeys.map((String key) {
      Map<String, dynamic> bubble =
          Map<String, dynamic>.from(snapshot.value["messages"][key]);
      ChatMessage bubbleObj = ChatMessage.fromJson(bubble);
      bubbleObj.id = key;
      return bubbleObj;
    }).toList();
    return roomBubbles;
  }

  ChatRoom chat(String roomID) {
    return _rooms[roomID];
  }

  List<ChatRoom> listRooms() {
    return _rooms.values.toList();
  }

  void setFCMToken(String fcmToken) {
    _fcmToken = fcmToken;
    for (ChatRoom room in _rooms.values) {
      _chat
          .child(room.id)
          .child(ChatStrings.participants)
          .child(_id_tag)
          .update({"fcmToken": _fcmToken});
    }
  }

  Future<List<ChatMessage>> getLatest(String roomId,
      {int from, int limit}) async {
//    DataSnapshot dataSnapshot = await _chat
//        .child(roomId)
//        .orderByKey()
//        .limitToLast(from)
//        .once();
//    return parseChatBubbles(roomId, dataSnapshot);
  }

  Future<void> send(String id, Map<String, dynamic> bubble) async {
    if (bubble.containsKey("id_tag")) {
      throw "the id_tag key is reserved for chat_provider";
    }
    bubble["id-tag"] = _id_tag;
    await _chat.child(id).child(ChatStrings.messages).push().set(bubble);
  }

  Future<void> markMessageAsSeen(
      String roomId, ChatMessage message, String userId) async {
    if (message.overriden == null || !message.overriden) return;
    await _chat
        .child(roomId)
        .child(ChatStrings.messages)
        .child(message.id)
        .child(ChatStrings.seen)
        .update({userId: true});
  }

  Future<void> setActive(String id) async {
    bool chatActive = true;
    _chat
        .child(id)
        .child(ChatStrings.participants)
        .child(_id_tag)
        .update({"chat-active": chatActive});
  }

  void listen(String id, Function callBack) {
    if (callBack == null) {
      roomFuncId = null;
      roomFunction = null;
      bool chatActive = false;
      _chat
          .child(id)
          .child(ChatStrings.participants)
          .child(_id_tag)
          .update({"chat-active": chatActive});
      return;
    }
    roomFuncId = id;
    roomFunction = callBack;
  }
}
