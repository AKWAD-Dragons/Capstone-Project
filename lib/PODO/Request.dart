import 'package:json_annotation/json_annotation.dart';
import 'package:sercl/PODO/Address.dart';
import 'package:sercl/PODO/Album.dart';
import 'package:sercl/PODO/Category.dart';
import 'package:sercl/PODO/Customer.dart';
import 'package:sercl/PODO/Service.dart';
import 'package:sercl/PODO/Video.dart';
import 'package:sercl/support/Fly/fly.dart';

part 'Request.g.dart';

@JsonSerializable()
class Request implements Parser<Request> {
  String id;
  String description;
  String record;
  Customer customer;
  Service service;
  Category category;
  Address address;
  DateTime created_at;
  DateTime date;
  List<Album> albums;
  List<Video> videos;

  Request(
    this.id,
    this.description,
    this.record,
    this.customer,
    this.service,
    this.category,
    this.address,
    this.created_at,
    this.albums,
    this.videos,
    this.date,
  );

  Request.empty();

  factory Request.fromJson(Map<String, dynamic> json) =>
      _$RequestFromJson(json);

  Map<String, dynamic> toJson() => _$RequestToJson(this);

  @override
  List<String> querys;

  @override
  dynamicParse(data) {
    return null;
  }

  @override
  Request parse(data) {
    return Request.fromJson(data);
  }
}
