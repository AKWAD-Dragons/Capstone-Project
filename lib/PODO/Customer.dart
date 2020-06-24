import 'package:json_annotation/json_annotation.dart';
import 'package:sercl/PODO/Address.dart';
import 'package:sercl/PODO/Request.dart';
import 'package:sercl/support/Fly/fly.dart';

part 'Customer.g.dart';

@JsonSerializable()
class Customer implements Parser<Customer> {
  String name;
  String phone;
  String address;
  String id;
  bool elevator;
  List<Address> addresses;
  List<Request> requests;
  String avg_rating;

  Customer.empty();

  Customer(
    this.name,
    this.phone,
    this.address,
    this.id,
    this.elevator,
    this.addresses,
    this.requests,
    this.avg_rating,
  );

  @override
  List<String> querys;

  factory Customer.fromJson(Map<String, dynamic> json) {
    return _$CustomerFromJson(json);
  }

  @override
  dynamicParse(data) {
    return null;
  }

  @override
  Customer parse(data) {
    return Customer.fromJson(data);
  }
}
