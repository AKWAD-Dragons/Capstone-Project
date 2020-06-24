// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Technician.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Technician _$TechnicianFromJson(Map<String, dynamic> json) {
  return Technician(
    id: json['id'] as String,
    name: json['name'] as String,
    email: json['email'] as String,
    schedules: (json['schedules'] as List)
        ?.map((e) => e == null ? null : Day.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    custom_schedule: json['custom_schedule'] as bool,
    visits: (json['visits'] as List)
        ?.map(
            (e) => e == null ? null : Visit.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    authUser: json['authUser'] == null
        ? null
        : AuthUser.fromJson(json['authUser'] as Map<String, dynamic>),
  )..querys = (json['querys'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$TechnicianToJson(Technician instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'schedules': instance.schedules,
      'custom_schedule': instance.custom_schedule,
      'visits': instance.visits,
      'authUser': instance.authUser,
      'querys': instance.querys,
    };
