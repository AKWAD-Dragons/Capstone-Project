import 'dart:io';
import 'dart:async';
import 'package:connectivity/connectivity.dart';

class NetworkConnectivityChecker{

  static Future<bool> isConnected() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none){
      return false;
    }
    else if (result == ConnectivityResult.mobile){
      return true;
    }
    else if (result == ConnectivityResult.wifi){
      return true;
    }
  }
}