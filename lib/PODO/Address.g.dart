// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) {
  return Address(
    json['id'] as String,
    json['street_name'] as String,
    json['street_number'] as String,
    json['postal_code'] as String,
    json['note'] as String,
    json['type'] as String,
    json['primary'] as bool,
  )..querys = (json['querys'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'querys': instance.querys,
      'id': instance.id,
      'street_name': instance.street_name,
      'street_number': instance.street_number,
      'postal_code': instance.postal_code,
      'note': instance.note,
      'type': instance.type,
      'primary': instance.primary,
    };
