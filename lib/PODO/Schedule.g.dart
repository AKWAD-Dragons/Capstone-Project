// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Schedule _$ScheduleFromJson(Map<String, dynamic> json) {
  return Schedule(
    (json['days'] as List)
        ?.map((e) => e == null ? null : Day.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  )..querys = (json['querys'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$ScheduleToJson(Schedule instance) => <String, dynamic>{
      'days': instance.days,
      'querys': instance.querys,
    };
