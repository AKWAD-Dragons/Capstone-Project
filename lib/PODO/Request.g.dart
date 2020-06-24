// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Request _$RequestFromJson(Map<String, dynamic> json) {
  return Request(
    json['id'] as String,
    json['description'] as String,
    json['record'] as String,
    json['customer'] == null
        ? null
        : Customer.fromJson(json['customer'] as Map<String, dynamic>),
    json['service'] == null
        ? null
        : Service.fromJson(json['service'] as Map<String, dynamic>),
    json['category'] == null
        ? null
        : Category.fromJson(json['category'] as Map<String, dynamic>),
    json['address'] == null
        ? null
        : Address.fromJson(json['address'] as Map<String, dynamic>),
    json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    (json['albums'] as List)
        ?.map(
            (e) => e == null ? null : Album.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['videos'] as List)
        ?.map(
            (e) => e == null ? null : Video.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['date'] == null ? null : DateTime.parse(json['date'] as String),
  )..querys = (json['querys'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$RequestToJson(Request instance) => <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'record': instance.record,
      'customer': instance.customer,
      'service': instance.service,
      'category': instance.category,
      'address': instance.address,
      'created_at': instance.created_at?.toIso8601String(),
      'date': instance.date?.toIso8601String(),
      'albums': instance.albums,
      'videos': instance.videos,
      'querys': instance.querys,
    };
