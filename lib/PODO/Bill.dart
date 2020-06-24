import 'package:json_annotation/json_annotation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sercl/support/Fly/fly.dart';

import 'Order.dart';

part 'Bill.g.dart';

@JsonSerializable()
class Bill implements Parser<Bill> {
  String id;
  DateTime created_at;
  String status;
  String description;
  String payment_method;
  String document;
  String invoice;
  Order order;
  String price;
  bool final_bill;
  DateTime paid_on;

  Bill.empty();

  Bill(
      this.id,
      this.created_at,
      this.status,
      this.description,
      this.payment_method,
      this.document,
      this.invoice,
      this.order,
      this.price,
      this.final_bill,
      this.paid_on);

  factory Bill.fromJson(Map<String, dynamic> json) => _$BillFromJson(json);

  Map<String, dynamic> toJson() => _$BillToJson(this);

  @override
  List<String> querys;

  @override
  dynamicParse(data) {
    // TODO: implement dynamicParse
    return null;
  }

  @override
  Bill parse(data) {
    // TODO: implement parse
    return null;
  }
}
