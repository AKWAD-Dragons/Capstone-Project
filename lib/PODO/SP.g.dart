// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SP.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SP _$SPFromJson(Map<String, dynamic> json) {
  return SP(
    (json['albums'] as List)
        ?.map(
            (e) => e == null ? null : Album.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['id'] as String,
    json['name'] as String,
    json['logo_link'] as String,
    json['bio'] as String,
    (json['areas'] as List)
            ?.map((e) =>
                e == null ? null : Area.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        [],
    json['business_certificate'] as String,
    json['contract'] as String,
    json['insurance'] as String,
    json['areas_status'] as bool ?? false,
    json['services_status'] as bool ?? false,
    json['documents_status'] as bool ?? false,
    json['info_status'] as bool ?? false,
    json['billing_status'] as bool ?? false,
    json['verify'] as bool,
    json['ready_for_verify'] as bool,
    json['street_name'] as String,
    json['street_number'] as String,
    json['postal_code'] as String,
    json['city'] as String,
    json['phone'] as String,
    json['iban'] as String,
    json['bic'] as String,
    (json['notes'] as List)
            ?.map((e) =>
                e == null ? null : Note.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        [],
    (json['services'] as List)
            ?.map((e) =>
                e == null ? null : Service.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        [],
    json['authId'] as String,
    (json['workers'] as List)
        ?.map((e) =>
            e == null ? null : Technician.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['orders'] as List)
        ?.map(
            (e) => e == null ? null : Order.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['invitations'] as List)
        ?.map((e) =>
            e == null ? null : Invitation.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['worker'] == null
        ? null
        : Technician.fromJson(json['worker'] as Map<String, dynamic>),
    (json['ratings'] as List)
        ?.map((e) =>
            e == null ? null : Review.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['authUser'] == null
        ? null
        : AuthUser.fromJson(json['authUser'] as Map<String, dynamic>),
    json['avg_price'] as String,
    json['avg_rating'] as String,
    (json['bills'] as List)
        ?.map(
            (e) => e == null ? null : Bill.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['small_company'] as bool ?? false,
    json['tax_id'] as String,
  )..querys = (json['querys'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$SPToJson(SP instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'logo_link': instance.logo_link,
      'bio': instance.bio,
      'business_certificate': instance.business_certificate,
      'insurance': instance.insurance,
      'contract': instance.contract,
      'authUser': instance.authUser,
      'avg_price': instance.avg_price,
      'avg_rating': instance.avg_rating,
      'info_status': instance.info_status,
      'areas_status': instance.areas_status,
      'services_status': instance.services_status,
      'documents_status': instance.documents_status,
      'billing_status': instance.billing_status,
      'verify': instance.verify,
      'ready_for_verify': instance.ready_for_verify,
      'authId': instance.authId,
      'workers': instance.workers,
      'orders': instance.orders,
      'invitations': instance.invitations,
      'worker': instance.worker,
      'ratings': instance.ratings,
      'bills': instance.bills,
      'areas': instance.areas,
      'albums': instance.albums,
      'notes': instance.notes,
      'services': instance.services,
      'street_name': instance.streetName,
      'street_number': instance.streetNumber,
      'postal_code': instance.postalCode,
      'city': instance.city,
      'phone': instance.phone,
      'iban': instance.iban,
      'bic': instance.bic,
      'tax_id': instance.taxId,
      'small_company': instance.small_company,
      'querys': instance.querys,
    };
