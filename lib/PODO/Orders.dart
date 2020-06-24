import 'package:json_annotation/json_annotation.dart';
import 'package:sercl/support/Fly/fly.dart';

import 'Order.dart';

part 'Orders.g.dart';

@JsonSerializable()
class Orders implements Parser<Orders> {
  List<Order> ordersList;

  Orders(this.ordersList);

  factory Orders.fromJson(Map<String, dynamic> json) =>
      _$OrdersFromJson(json);

  Orders.empty();

  Orders parse(data) {
    return Orders.fromJson({"ordersList": data});
  }

  @override
  List<String> querys;

  @override
  dynamicParse(data) {
    // TODO: implement dynamicParse
    return null;
  }
}