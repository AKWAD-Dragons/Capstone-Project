import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sercl/PODO/Bill.dart';
import 'package:sercl/PODO/Note.dart';
import 'package:sercl/PODO/Orders.dart';
import 'package:sercl/PODO/Invitation.dart';
import 'package:sercl/PODO/Review.dart';
import 'package:sercl/PODO/Service.dart';
import 'package:sercl/PODO/Album.dart';
import 'package:sercl/PODO/Technician.dart';
import 'package:sercl/support/Auth/User.dart';
import 'package:sercl/support/Fly/fly.dart';
import 'package:sercl/support/Util.dart';

import 'Area.dart';
import 'Order.dart';

part 'SP.g.dart';

@JsonSerializable()
class SP implements Parser<SP> {
  String id;
  String name;
  String logo_link;
  String bio;
  String business_certificate;
  String insurance;
  String contract;
  AuthUser authUser;
  String avg_price;
  String avg_rating;
  @JsonKey(defaultValue: false)
  bool info_status;
  @JsonKey(defaultValue: false)
  bool areas_status;
  @JsonKey(defaultValue: false)
  bool services_status;
  @JsonKey(defaultValue: false)
  bool documents_status;
  @JsonKey(defaultValue: false)
  bool billing_status;
  bool verify;
  bool ready_for_verify;
  String authId;
  List<Technician> workers;
  List<Order> orders;
  List<Invitation> invitations;
  Technician worker;
  List<Review> ratings;
  List<Bill> bills;

  @JsonKey(defaultValue: [])
  List<Area> areas;
  @JsonKey(ignore: true)
  List<Area> deletedAreas = [];
  @JsonKey(ignore: true)
  List<Area> addedAreas = [];

  List<Album> albums;
  @JsonKey(ignore: true)
  List<Album> deletedAlbums;
  @JsonKey(ignore: true)
  List<Album> selectedAlbums;

  @JsonKey(defaultValue: [])
  List<Note> notes;
  @JsonKey(defaultValue: [])
  List<Service> services;
  @JsonKey(ignore: true)
  List<Service> selectedServices = [];
  @JsonKey(ignore: true)
  List<Service> deSelectedServices = [];

  @JsonKey(name:"street_name")
  String streetName;
  @JsonKey(name:"street_number")
  String streetNumber;
  @JsonKey(name:"postal_code")
  String postalCode;
  String city;
  String phone;
  String iban;
  String bic;
  @JsonKey(name:"tax_id")
  String taxId;

  @JsonKey(defaultValue: false)
  bool small_company;

  @JsonKey(ignore: true)
  CustomFile businessCertFile;
  @JsonKey(ignore: true)
  CustomFile insuranceFile;
  @JsonKey(ignore: true)
  CustomFile contractFile;

  @JsonKey(ignore: true)
  File logo;

  @JsonKey(ignore: true)
  List<File> images;

  @JsonKey(ignore: true)
  set insuranceAsFile(CustomFile file) {
    if (file == null) {
      insuranceFile = null;
      return;
    }
    insuranceFile = file;
    Util.stringFromFile(file.file).then((stringFile) {
      file.base64 = stringFile;
      insuranceFile = file;
    });
  }

  set businessCertAsFile(CustomFile file) {
    if (file == null) {
      businessCertFile = null;
      return;
    }
    businessCertFile = file;
    Util.stringFromFile(file.file).then((stringFile) {
      file.base64 = stringFile;
      businessCertFile = file;
    });
  }

  set contractAsFile(CustomFile file) {
    if (file == null) {
      contractFile = null;
      return;
    }
    contractFile = file;
    Util.stringFromFile(file.file).then((stringFile) {
      file.base64 = stringFile;
      contractFile = file;
    });
  }

  SP.empty();

  SP(
    this.albums,
    this.id,
    this.name,
    this.logo_link,
    this.bio,
    this.areas,
    this.business_certificate,
    this.contract,
    this.insurance,
    this.areas_status,
    this.services_status,
    this.documents_status,
    this.info_status,
    this.billing_status,
    this.verify,
    this.ready_for_verify,
    this.streetName,
    this.streetNumber,
    this.postalCode,
    this.city,
    this.phone,
    this.iban,
    this.bic,
    this.notes,
    this.services,
    this.authId,
    this.workers,
    this.orders,
    this.invitations,
    this.worker,
    this.ratings,
    this.authUser,
    this.avg_price,
    this.avg_rating,
    this.bills,
    this.small_company,
      this.taxId
  );

  factory SP.fromJson(Map<String, dynamic> json) {
    SP sp = _$SPFromJson(json);
    ValueNotifier(sp.logo_link).addListener(() {
      //  sp.logo = File()
    });
    return _$SPFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SPToJson(this);

  @override
  dynamicParse(data) {
    return null;
  }

  @override
  SP parse(data) {
    return SP.fromJson(data);
  }

  @override
  List<String> querys = ['createSP'];
}

class CustomFile {
  File file;
  String fileName;
  String base64;

  CustomFile(this.fileName, this.file);
}
