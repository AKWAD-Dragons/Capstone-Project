import 'package:json_annotation/json_annotation.dart';
import 'package:sercl/PODO/Category.dart';

part 'Service.g.dart';

@JsonSerializable()
class Service {
  String id;
  String name;
  String image;
  String color;
  Category category;
  factory Service.fromJson(Map<String, dynamic> json) =>
      _$ServiceFromJson(json);
  Service({this.id, this.name, this.image, this.color, this.category});
  @override
  bool operator ==(service) {
    return service.id == id;
  }

  @override
  String toString() {
    return 'id :$id , name : $name';
  }

  bool isEqual(String id){
    return this.id == id;
  }
}
