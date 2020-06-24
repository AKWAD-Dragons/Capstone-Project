class Participant {
  String idTag;
  String fcm;
  bool chatActive;
  Map<String, dynamic> metaData;

  Participant(this.idTag, this.fcm, this.chatActive, this.metaData);

  factory Participant.fromJson(Map<String, dynamic> json) => Participant(
        json['id-tag'] as String,
        json['fcm'] as String,
        json['chat-active'] as bool,
        json['metaData'] as Map<String, dynamic>,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id-tag': this.idTag,
        'fcm': this.fcm,
        'chat-active': this.chatActive,
        'metaData': this.metaData,
      };
}
