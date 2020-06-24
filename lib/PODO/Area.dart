import 'package:json_annotation/json_annotation.dart';
part 'Area.g.dart';

@JsonSerializable()
class Area {
  String from;
  String to;
  String id;

  // String name;
  Area(this.from, this.to, this.id);
  //Area({this.from, this.to});
  @override
  String toString() {
    return "{from: \"$from\" , to: \"$to\" }";
  }

  factory Area.fromJson(Map<String, dynamic> json) => _$AreaFromJson(json);
  Map<String, dynamic> toJson() => _$AreaToJson(this);
}
