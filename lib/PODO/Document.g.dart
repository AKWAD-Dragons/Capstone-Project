// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Document.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Document _$DocumentFromJson(Map<String, dynamic> json) {
  return Document(
    json['name'] as String,
    json['data'] as String,
    json['isBytes'] as bool,
  );
}

Map<String, dynamic> _$DocumentToJson(Document instance) => <String, dynamic>{
      'name': instance.name,
      'data': instance.data,
      'isBytes': instance.isBytes,
    };
