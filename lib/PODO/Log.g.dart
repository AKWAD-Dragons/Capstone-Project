// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Log _$LogFromJson(Map<String, dynamic> json) {
  return Log(
    json['id'] as String,
    json['actor'] == null
        ? null
        : Actor.fromJson(json['actor'] as Map<String, dynamic>),
    json['action_field'] as String,
    json['action_value'] as String,
    json['actor_type'] as String,
    json['created_at'] as String,
  )..querys = (json['querys'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$LogToJson(Log instance) => <String, dynamic>{
      'id': instance.id,
      'actor': instance.actor,
      'action_field': instance.action_field,
      'action_value': instance.action_value,
      'actor_type': instance.actor_type,
      'created_at': instance.created_at,
      'querys': instance.querys,
    };
