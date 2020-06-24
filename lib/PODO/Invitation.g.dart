// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Invitation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Invitation _$InvitationFromJson(Map<String, dynamic> json) {
  return Invitation(
    json['id'] as String,
    json['status'] as String,
    json['price'] as String,
    json['chat_room'] as String,
    json['request'] == null
        ? null
        : Request.fromJson(json['request'] as Map<String, dynamic>),
    json['order'] == null
        ? null
        : Order.fromJson(json['order'] as Map<String, dynamic>),
    json['date'] == null ? null : DateTime.parse(json['date'] as String),
  )..querys = (json['querys'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$InvitationToJson(Invitation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'price': instance.price,
      'chat_room': instance.chat_room,
      'request': instance.request,
      'order': instance.order,
      'date': instance.date?.toIso8601String(),
      'querys': instance.querys,
    };
