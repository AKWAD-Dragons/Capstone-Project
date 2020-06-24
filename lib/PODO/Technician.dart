import 'package:json_annotation/json_annotation.dart';
import 'package:sercl/PODO/Day.dart';
import 'package:sercl/PODO/SP.dart';
import 'package:sercl/PODO/Schedule.dart';
import 'package:sercl/PODO/visit.dart';
import 'package:sercl/support/Auth/User.dart';
import 'package:sercl/support/Fly/fly.dart';

part 'Technician.g.dart';

@JsonSerializable()
class Technician implements Parser<Technician> {
  String id;
  String name;
  String email;
  List<Day> schedules;
  bool custom_schedule;
  List<Visit> visits;
  AuthUser authUser;

  // SP serviceProvider;

  Technician(
      {this.id,
      this.name,
      this.email,
      this.schedules,
      this.custom_schedule,
      this.visits,
      this.authUser}
      // this.serviceProvider,
      );

  Technician.empty();

  @override
  bool operator ==(other) {
    if (other is Technician) {
      return other.id == this.id;
    }
    return false;
  }

  factory Technician.fromJson(Map<String, dynamic> json) =>
      _$TechnicianFromJson(json);

  Map<String, dynamic> toJson() => _$TechnicianToJson(this);

  @override
  List<String> querys;

  @override
  dynamic dynamicParse(data) {
    List<Technician> parsed = List();
    if (data is List) {
      for (dynamic singleData in data) {
        parsed.add(parse(singleData));
      }
      return parsed;
    } else {
      return parse(data);
    }
  }

  @override
  Technician parse(data) {
    return Technician.fromJson(data);
  }
}
