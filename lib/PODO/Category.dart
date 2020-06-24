import 'package:json_annotation/json_annotation.dart';

import 'Service.dart';
import 'package:flutter/material.dart';

part 'Category.g.dart';

@JsonSerializable()
class Category {
  String id;
  String name;
  String icon;
  String color;
  List<Service> services;

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Category(this.id,this.name, this.services, this.icon, this.color);
}
