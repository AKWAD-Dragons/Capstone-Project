import 'package:json_annotation/json_annotation.dart';
import 'package:sercl/PODO/Order.dart';
import 'package:sercl/PODO/Request.dart';
import 'package:sercl/PODO/SP.dart';
import 'package:sercl/support/Fly/fly.dart';

part 'Invitation.g.dart';

@JsonSerializable()
class Invitation implements Parser<Invitation> {
  String id;
  String status;
  String price;
  String chat_room;
  Request request;
  Order order;
  DateTime date;

  Invitation(
      this.id,
      this.status,
      this.price,
      this.chat_room,
      this.request,
      this.order,
      this.date,
      );

  Invitation.empty();

  factory Invitation.fromJson(Map<String, dynamic> json) =>
      _$InvitationFromJson(json);

  Map<String, dynamic> toJson() => _$InvitationToJson(this);

  @override
  List<String> querys;

  @override
  dynamicParse(data) {
    return null;
  }

  @override
  Invitation parse(data) {
    return Invitation.fromJson(data);
  }
}
