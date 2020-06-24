import 'package:json_annotation/json_annotation.dart';

import 'Service.dart';
import 'package:flutter/material.dart';

part 'Document.g.dart';

@JsonSerializable()
class Document {
  String name;
  String data;
  bool isBytes;

  factory Document.fromJson(Map<String, dynamic> json) =>
      _$DocumentFromJson(json);

  Document(this.name, this.data, this.isBytes,);
}
