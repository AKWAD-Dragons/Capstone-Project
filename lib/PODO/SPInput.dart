import 'package:json_annotation/json_annotation.dart';

import 'Area.dart';
part 'SPInput.g.dart';

@JsonSerializable()
class ServiceProviderInput {
  @JsonKey(defaultValue: [])
  List<Area> areas;
  factory ServiceProviderInput.fromJson(Map<String, dynamic> json) =>
      _$ServiceProviderInputFromJson(json);

  ServiceProviderInput(this.areas);
  Map<String, dynamic> toJson() => _$ServiceProviderInputToJson(this);
  Map<String, dynamic> toAreaNode() =>
      {'areas': areas.map((area) => area.toString()).toList().toString()};
}
