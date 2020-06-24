// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Technicians.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Technicians _$TechniciansFromJson(Map<String, dynamic> json) {
  return Technicians(
    (json['technicians'] as List)
        ?.map((e) =>
            e == null ? null : Technician.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  )..querys = (json['querys'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$TechniciansToJson(Technicians instance) =>
    <String, dynamic>{
      'technicians': instance.technicians,
      'querys': instance.querys,
    };
