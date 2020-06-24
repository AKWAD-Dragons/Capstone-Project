// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Area.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Area _$AreaFromJson(Map<String, dynamic> json) {
  return Area(
    json['from'] as String,
    json['to'] as String,
    json['id'] as String,
  );
}

Map<String, dynamic> _$AreaToJson(Area instance) => <String, dynamic>{
      'from': instance.from,
      'to': instance.to,
      'id': instance.id,
    };
