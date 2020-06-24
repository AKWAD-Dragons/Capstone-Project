import 'dart:async';

import '../chat_provider.dart';
import 'ChatMessage.dart';
import 'Participant.dart';

class ChatRoom {
  String id;
  List<ChatMessage> chat;
  Map<String, Participant> participants;
  ChatProvider provider;
  bool blocked;
  String block_type;
  int lastMessage;

  ChatRoom(
      this.id, this.chat, this.participants, this.blocked, this.lastMessage, this.block_type);

  factory ChatRoom.fromJson(Map<String, dynamic> json) => ChatRoom(
        json['id'] as String,
        (json['chat'] as List)
            ?.map((e) => e == null
                ? null
                : ChatMessage.fromJson(e as Map<String, dynamic>))
            ?.toList(),
        (json['participants'] as Map<String, dynamic>)?.map(
          (k, e) => MapEntry(
              k,
              e == null
                  ? null
                  : Participant.fromJson(e as Map<String, dynamic>)),
        ),
        json['meta-data']['blocked'] as bool,
        json['meta-data']['latest-message-time'] as int,
        json['meta-data']['block-type'] as String,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': this.id,
        'chat': this.chat,
        'participants': this.participants,
        'blocked': this.blocked,
        'latest-message-time': this.lastMessage,
        'block-type':this.block_type
   
      };


  Future<void> send(Map<String, dynamic> bubble) async {
    return provider.send(id, bubble);
  }

  Future<void> setActive() async {
    return provider.setActive(id);
  }

  void listen(Function onData) {
    provider.listen(id, onData);
  }

  void closeChat() {
    provider.listen(id, null);
  }
}
