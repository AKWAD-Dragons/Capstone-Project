import 'package:json_annotation/json_annotation.dart';
part 'Day.g.dart';

@JsonSerializable()
class Day {
  String id;
  String day;
  String from;
  String to;

  Day(this.id,this.day, this.from, this.to);
  Day.empty();

  factory Day.fromJson(Map<String, dynamic> json) =>
      _$DayFromJson(json);
}