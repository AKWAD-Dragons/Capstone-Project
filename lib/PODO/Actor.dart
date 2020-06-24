import 'package:json_annotation/json_annotation.dart';


part 'Actor.g.dart';
@JsonSerializable()
class Actor{
  String id;
  String name;

  Actor(this.id,this.name);

  factory Actor.fromJson(Map<String, dynamic> json) => _$ActorFromJson(json);
  Map<String, dynamic> toJson() => _$ActorToJson(this);
}