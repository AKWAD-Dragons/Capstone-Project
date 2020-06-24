import 'package:json_annotation/json_annotation.dart';
import 'package:sercl/PODO/Order.dart';
import 'package:sercl/PODO/Request.dart';
import 'package:sercl/support/Fly/fly.dart';

part 'Review.g.dart';

@JsonSerializable()
class Review implements Parser<Review> {
  String id;
  String rating;
  String price_rating;
  String comment;
  Order order;
  DateTime created_at;

  Review(this.id, this.rating, this.price_rating, this.comment, this.order,
      this.created_at);
  Review.empty();

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewToJson(this);

  @override
  List<String> querys;

  @override
  dynamicParse(data) {
    return null;
  }

  @override
  Review parse(data) {
    return Review.fromJson(data);
  }
}
