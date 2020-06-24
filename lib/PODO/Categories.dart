import 'package:json_annotation/json_annotation.dart';
import 'package:sercl/PODO/Category.dart';
import 'package:sercl/support/Fly/fly.dart';

part 'Categories.g.dart';

@JsonSerializable()
class Categories implements Parser<Categories> {
  List<Category> categories;

  Categories(this.categories);

  factory Categories.fromJson(Map<String, dynamic> json) =>
      _$CategoriesFromJson(json);

  Categories.empty();

  Categories parse(data) {
    return Categories.fromJson({"categories": data});
  }

  @override
  List<String> querys;

  @override
  dynamicParse(data) {
    return parse(data);
  }
}