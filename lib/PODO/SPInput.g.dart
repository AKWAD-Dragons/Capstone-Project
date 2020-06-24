// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SPInput.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceProviderInput _$ServiceProviderInputFromJson(Map<String, dynamic> json) {
  return ServiceProviderInput(
    (json['areas'] as List)
            ?.map((e) =>
                e == null ? null : Area.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        [],
  );
}

Map<String, dynamic> _$ServiceProviderInputToJson(
        ServiceProviderInput instance) =>
    <String, dynamic>{
      'areas': instance.areas,
    };
