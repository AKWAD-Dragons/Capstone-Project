import 'package:json_annotation/json_annotation.dart';
import 'package:sercl/PODO/Technician.dart';
import 'package:sercl/support/Fly/fly.dart';

part 'Technicians.g.dart';

@JsonSerializable()
class Technicians implements Parser<Technicians> {
  List<Technician> technicians;

  Technicians(this.technicians);

  factory Technicians.fromJson(Map<String, dynamic> json) =>
      _$TechniciansFromJson(json);

  Technicians.empty();

  Technicians parse(data) {
    return Technicians.fromJson({"technicians": data});
  }

  @override
  List<String> querys;

  @override
  dynamicParse(data) {

    return null;
  }
}