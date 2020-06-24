import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sercl/PODO/Technician.dart';
import 'package:sercl/support/Fly/fly.dart';
import 'package:sercl/support/Util.dart';

import 'Log.dart';
import 'Order.dart';

part 'visit.g.dart';

//demo for visit until be specified in the backend
@JsonSerializable()
class Visit implements Parser<Visit> {
  String id;
  String status;
  @JsonKey(defaultValue: [])
  List<Technician> workers;
  DateTime time;
  Order order;
  List<Log> logs;
  String navigation_id;
  DateTime started;
  DateTime finished;

  Visit(
      {this.id,
      this.status,
      this.workers = const [],
      this.time,
      this.logs,
      this.order,
      this.navigation_id,
      this.started,
      this.finished});

  factory Visit.fromJson(Map<String, dynamic> json) => _$VisitFromJson(json);

  Map<String, dynamic> toJson() => _$VisitToJson(this);

  @override
  List<String> querys;

  @override
  dynamicParse(data) {
    // TODO: implement dynamicParse
    return Visit.fromJson(data);
  }

  @override
  Visit parse(data) {
    // TODO: implement parse
    return Visit.fromJson(data);
  }
}
