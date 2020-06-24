import 'package:json_annotation/json_annotation.dart';
import 'package:sercl/PODO/Category.dart';
import 'package:sercl/PODO/Invitation.dart';
import 'package:sercl/PODO/Rate.dart';
import 'package:sercl/PODO/Review.dart';
import 'package:sercl/PODO/SP.dart';
import 'package:sercl/PODO/Service.dart';
import 'package:sercl/PODO/Technician.dart';
import 'package:sercl/PODO/Album.dart';
import 'package:sercl/PODO/visit.dart';
import 'package:sercl/PODO/Video.dart';
import 'dart:io';

import 'Customer.dart';

part 'Order.g.dart';

@JsonSerializable()
class Order {
  String id;
  String status;
  String email;
  String record;
  String street_no;
  String street_name;
  String phone;
  String description;
  String postcode;
  String customer_name;
  Service service;
  Invitation invitation;
  SP serviceProvider;
  Customer customer;
  Category category;
  List<Visit> visits;
  List<Album> albums;
  List<Video> videos;
  List<Technician> workers;
  String receiptLink;
  @JsonKey(name: "SPRating")
  Review spRating;
  @JsonKey(name: "CustomerRating")
  Review customerRating;
  DateTime created_at;
  DateTime date;
  String payment_method;

  Order(
    this.id,
    this.status,
    this.email,
    this.street_no,
    this.street_name,
    this.phone,
    this.description,
    this.postcode,
    this.customer_name,
    this.service,
    this.invitation,
    this.serviceProvider,
    this.customer,
    this.workers,
    this.albums,
    this.videos,
    this.receiptLink,
    this.spRating,
    this.customerRating,
    this.created_at,
    this.date,
    this.payment_method,
  );

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
}

class CustomFile {
  File file;
  String fileName;
  String base64;

  CustomFile(this.fileName, this.file);
}
