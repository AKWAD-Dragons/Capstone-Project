import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:location/location.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sercl/support/Location/Models/Coordinate.dart';
import 'package:sercl/support/Location/location_strings.dart';

class LocationProvider {
  FirebaseDatabase _database;
  FirebaseApp _app;
  DatabaseReference _locations;
  String _db_name;
  Coordinate coordinate;
  PublishSubject<Coordinate> locationChatSubject = PublishSubject();

  LocationProvider(String db_name) {
    this._db_name = db_name;
    _locations = FirebaseDatabase.instance.reference().child(db_name);
  }

  Future<void> send(String id, String lat, String lon) async {
    await _locations.child(id).update({"lat": lat, "lon": lon});
  }

  Coordinate parseLocation(String roomID, DataSnapshot snapshot) {
    Coordinate coordinate =
        Coordinate.fromJson(json.decode(json.encode(snapshot.value)));
    coordinate.provider = this;
    coordinate.id = roomID;
    return coordinate;
  }

  Future<Stream<Coordinate>> listenToLocation(String id) async {
    _locations.child(id).onValue.listen((Event data) {
      Coordinate coordinate = parseLocation(id, data.snapshot);
      locationChatSubject.sink.add(coordinate);
    }, onError: (e) {
      print("error: $e");
    });
    return locationChatSubject.stream;
  }
}
