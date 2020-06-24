// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Sps.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SPs _$SPsFromJson(Map<String, dynamic> json) {
  return SPs(
    (json['spList'] as List)
        ?.map((e) => e == null ? null : SP.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  )..querys = (json['querys'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$SPsToJson(SPs instance) => <String, dynamic>{
      'spList': instance.spList,
      'querys': instance.querys,
    };
