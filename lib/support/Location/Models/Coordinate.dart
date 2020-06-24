import 'dart:convert';

import 'package:sercl/support/Location/location_provider.dart';

class Coordinate {
  String id;
  String lat;
  String lon;

  LocationProvider provider;

  Coordinate(this.id, this.lat, this.lon);
  factory Coordinate.fromJson(Map<String, dynamic> json) => Coordinate(
        json['id'] as String,
        json['lat'] as String,
        json['lon'] as String,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': this.id,
        'lat': this.lat,
        'lon': this.lon,
      };

  void listen(Function onData) {
    //provider.listen(id, onData);
  }
}
