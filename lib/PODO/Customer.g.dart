// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Customer _$CustomerFromJson(Map<String, dynamic> json) {
  return Customer(
    json['name'] as String,
    json['phone'] as String,
    json['address'] as String,
    json['id'] as String,
    json['elevator'] as bool,
    (json['addresses'] as List)
        ?.map((e) =>
            e == null ? null : Address.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['requests'] as List)
        ?.map((e) =>
            e == null ? null : Request.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['avg_rating'] as String,
  )..querys = (json['querys'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$CustomerToJson(Customer instance) => <String, dynamic>{
      'name': instance.name,
      'phone': instance.phone,
      'address': instance.address,
      'id': instance.id,
      'elevator': instance.elevator,
      'addresses': instance.addresses,
      'requests': instance.requests,
      'avg_rating': instance.avg_rating,
      'querys': instance.querys,
    };
