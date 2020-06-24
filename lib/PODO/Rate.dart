import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Rating {
  int id;
  int requester_id;
  int performer_id;
  int order_id;
  double rating;
  String review;

  Rating(this.id, this.requester_id, this.performer_id, this.order_id,
      this.rating, this.review);
}
