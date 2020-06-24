import 'package:json_annotation/json_annotation.dart';
import 'package:sercl/PODO/Customer.dart';


part 'OtherCustomer.g.dart';

@JsonSerializable()
class OtherCustomer {
  int id;
  String name;
  String postal_code;
  String phone;
  Customer customer;


  OtherCustomer(this.id, this.name, this.postal_code, this.phone,
      this.customer);

  OtherCustomer.empty();

  factory OtherCustomer.fromJson(Map<String, dynamic> json) =>
      _$OtherCustomerFromJson(json);
}
