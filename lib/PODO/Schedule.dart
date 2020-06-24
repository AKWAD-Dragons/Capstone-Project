import 'package:json_annotation/json_annotation.dart';
import 'package:sercl/PODO/Day.dart';
import 'package:sercl/support/Fly/fly.dart';

part 'Schedule.g.dart';

@JsonSerializable()
class Schedule implements Parser<Schedule> {
  List<Day> days;

  Schedule(this.days);

  factory Schedule.fromJson(Map<String, dynamic> json) =>
      _$ScheduleFromJson(json);

  Schedule.empty();

  Schedule parse(data) {
    return Schedule.fromJson({"schedules": data});
  }

  @override
  List<String> querys;

  @override
  dynamicParse(data) {
    // TODO: implement dynamicParse
    return null;
  }


}