// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OtherCustomer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OtherCustomer _$OtherCustomerFromJson(Map<String, dynamic> json) {
  return OtherCustomer(
    json['id'] as int,
    json['name'] as String,
    json['postal_code'] as String,
    json['phone'] as String,
    json['customer'] == null
        ? null
        : Customer.fromJson(json['customer'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$OtherCustomerToJson(OtherCustomer instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'postal_code': instance.postal_code,
      'phone': instance.phone,
      'customer': instance.customer,
    };
