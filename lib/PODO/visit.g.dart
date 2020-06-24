// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Visit _$VisitFromJson(Map<String, dynamic> json) {
  return Visit(
    id: json['id'] as String,
    status: json['status'] as String,
    workers: (json['workers'] as List)
            ?.map((e) => e == null
                ? null
                : Technician.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        [],
    time: json['time'] == null ? null : DateTime.parse(json['time'] as String),
    logs: (json['logs'] as List)
        ?.map((e) => e == null ? null : Log.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    order: json['order'] == null
        ? null
        : Order.fromJson(json['order'] as Map<String, dynamic>),
    navigation_id: json['navigation_id'] as String,
    started: json['started'] == null
        ? null
        : DateTime.parse(json['started'] as String),
    finished: json['finished'] == null
        ? null
        : DateTime.parse(json['finished'] as String),
  )..querys = (json['querys'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$VisitToJson(Visit instance) => <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'workers': instance.workers,
      'time': instance.time?.toIso8601String(),
      'order': instance.order,
      'logs': instance.logs,
      'navigation_id': instance.navigation_id,
      'started': instance.started?.toIso8601String(),
      'finished': instance.finished?.toIso8601String(),
      'querys': instance.querys,
    };
