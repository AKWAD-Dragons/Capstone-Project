// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) {
  return Order(
    json['id'] as String,
    json['status'] as String,
    json['email'] as String,
    json['street_no'] as String,
    json['street_name'] as String,
    json['phone'] as String,
    json['description'] as String,
    json['postcode'] as String,
    json['customer_name'] as String,
    json['service'] == null
        ? null
        : Service.fromJson(json['service'] as Map<String, dynamic>),
    json['invitation'] == null
        ? null
        : Invitation.fromJson(json['invitation'] as Map<String, dynamic>),
    json['serviceProvider'] == null
        ? null
        : SP.fromJson(json['serviceProvider'] as Map<String, dynamic>),
    json['customer'] == null
        ? null
        : Customer.fromJson(json['customer'] as Map<String, dynamic>),
    (json['workers'] as List)
        ?.map((e) =>
            e == null ? null : Technician.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['albums'] as List)
        ?.map(
            (e) => e == null ? null : Album.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['videos'] as List)
        ?.map(
            (e) => e == null ? null : Video.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['receiptLink'] as String,
    json['SPRating'] == null
        ? null
        : Review.fromJson(json['SPRating'] as Map<String, dynamic>),
    json['CustomerRating'] == null
        ? null
        : Review.fromJson(json['CustomerRating'] as Map<String, dynamic>),
    json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    json['date'] == null ? null : DateTime.parse(json['date'] as String),
    json['payment_method'] as String,
  )
    ..record = json['record'] as String
    ..category = json['category'] == null
        ? null
        : Category.fromJson(json['category'] as Map<String, dynamic>)
    ..visits = (json['visits'] as List)
        ?.map(
            (e) => e == null ? null : Visit.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'email': instance.email,
      'record': instance.record,
      'street_no': instance.street_no,
      'street_name': instance.street_name,
      'phone': instance.phone,
      'description': instance.description,
      'postcode': instance.postcode,
      'customer_name': instance.customer_name,
      'service': instance.service,
      'invitation': instance.invitation,
      'serviceProvider': instance.serviceProvider,
      'customer': instance.customer,
      'category': instance.category,
      'visits': instance.visits,
      'albums': instance.albums,
      'videos': instance.videos,
      'workers': instance.workers,
      'receiptLink': instance.receiptLink,
      'SPRating': instance.spRating,
      'CustomerRating': instance.customerRating,
      'created_at': instance.created_at?.toIso8601String(),
      'date': instance.date?.toIso8601String(),
      'payment_method': instance.payment_method,
    };
