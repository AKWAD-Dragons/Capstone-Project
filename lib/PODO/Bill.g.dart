// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Bill.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bill _$BillFromJson(Map<String, dynamic> json) {
  return Bill(
    json['id'] as String,
    json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    json['status'] as String,
    json['description'] as String,
    json['payment_method'] as String,
    json['document'] as String,
    json['invoice'] as String,
    json['order'] == null
        ? null
        : Order.fromJson(json['order'] as Map<String, dynamic>),
    json['price'] as String,
    json['final_bill'] as bool,
    json['paid_on'] == null ? null : DateTime.parse(json['paid_on'] as String),
  )..querys = (json['querys'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$BillToJson(Bill instance) => <String, dynamic>{
      'id': instance.id,
      'created_at': instance.created_at?.toIso8601String(),
      'status': instance.status,
      'description': instance.description,
      'payment_method': instance.payment_method,
      'document': instance.document,
      'invoice': instance.invoice,
      'order': instance.order,
      'price': instance.price,
      'final_bill': instance.final_bill,
      'paid_on': instance.paid_on?.toIso8601String(),
      'querys': instance.querys,
    };
