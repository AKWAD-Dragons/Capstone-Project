// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Review _$ReviewFromJson(Map<String, dynamic> json) {
  return Review(
    json['id'] as String,
    json['rating'] as String,
    json['price_rating'] as String,
    json['comment'] as String,
    json['order'] == null
        ? null
        : Order.fromJson(json['order'] as Map<String, dynamic>),
    json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
  )..querys = (json['querys'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
      'id': instance.id,
      'rating': instance.rating,
      'price_rating': instance.price_rating,
      'comment': instance.comment,
      'order': instance.order,
      'created_at': instance.created_at?.toIso8601String(),
      'querys': instance.querys,
    };
