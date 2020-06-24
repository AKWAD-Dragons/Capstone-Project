import 'dart:convert';

class ChatMessage {
  String id;
  String id_tag;
  String type;
  bool overriden;
  Map<String, dynamic> seen;
  Map<String, dynamic> data;
  Map<String, dynamic> metadata;
  String text;

  ChatMessage(this.id, this.id_tag, this.type, this.overriden, this.seen,
      this.data, this.metadata, this.text);

  factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
      json['id'] as String,
      json['id-tag'] as String,
      json['type'] as String,
      json['overriden'] as bool,
      jsonDecode(jsonEncode(json['seen'])) as Map<String, dynamic>,
      jsonDecode(jsonEncode(json['data'])) as Map<String, dynamic>,
      jsonDecode(jsonEncode(json['meta-data'])) as Map<String, dynamic>,
      // encode and decode to reformat the map
      json['text'] as String);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': this.id,
        'id-tag': this.id_tag,
        'type': this.type,
        'seen': this.seen,
        'overriden': this.overriden,
        'data': this.data,
        'meta-data': this.metadata,
        'text': this.text,
      };
}
