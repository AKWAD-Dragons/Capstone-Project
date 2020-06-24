import 'package:json_annotation/json_annotation.dart';
import 'package:sercl/support/Fly/fly.dart';

import 'SP.dart';
part 'Sps.g.dart';

@JsonSerializable()
class SPs {
  List<SP> spList;

  SPs(this.spList);
  factory SPs.fromJson(Map<String, dynamic> json) => _$SPsFromJson(json);

  SPs.empty();

  @override
  List<String> querys;

  SPs parse(List data) {
    return SPs.fromJson({"spList": data});
  }
}
