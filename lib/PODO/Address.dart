import 'package:json_annotation/json_annotation.dart';
import 'package:sercl/support/Fly/fly.dart';

part 'Address.g.dart';

@JsonSerializable()
class Address implements Parser<Address> {
  @override
  List<String> querys;
  String id;
  String street_name;
  String street_number;
  String postal_code;
  String note;
  String type;
  bool primary;

  Address.empty();
  Address(
    this.id,
    this.street_name,
    this.street_number,
    this.postal_code,
    this.note,
    this.type,
    this.primary,
  );

  factory Address.fromJson(Map<String, dynamic> json) {
    return _$AddressFromJson(json);
  }

  @override
  dynamicParse(data) {
    return null;
  }

  @override
  Address parse(data) {
    return Address.fromJson(data);
  }
}
