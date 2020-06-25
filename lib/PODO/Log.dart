import 'package:json_annotation/json_annotation.dart';
import 'package:sercl/PODO/Actor.dart';
import 'package:sercl/support/Fly/fly.dart';
part 'Log.g.dart';
@JsonSerializable()
class Log implements Parser<Log>{
  String id;
  Actor actor;
  String action_field;
  String action_value;
  String actor_type;
  String created_at;

  Log(this.id,this.actor,this.action_field,this.action_value,this.actor_type,this.created_at);



  factory Log.fromJson(Map<String, dynamic> json) => _$LogFromJson(json);
  Map<String, dynamic> toJson() => _$LogToJson(this);

  @override
  dynamicParse(data) {
    return null;
  }

  @override
  Log parse(data) {
    return Log.fromJson(data);
  }

  @override
  List<String> querys;
}
