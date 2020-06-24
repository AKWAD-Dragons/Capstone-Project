import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:rxdart/rxdart.dart';


class FCMBloc{
  static FirebaseMessaging _fcm = FirebaseMessaging();
  //static BehaviorSubject<Map<String, dynamic>> messageBS = BehaviorSubject();

  static void init() async{
//    _fcm = FirebaseMessaging();
//    if (Platform.isIOS) _iosPermit();
//    _fcm.onTokenRefresh.listen((token){
//      print(token);
//      if(UserBloc.user!=null){
//        UserBloc.updateUser(fcmToken: token);
//      }
//    });
  }

  static Future<String> getToken()async{
    String token = await _fcm.getToken();
    return token;
  }

//  static void _iosPermit() {
//    _fcm.requestNotificationPermissions(
//        IosNotificationSettings(sound: true, badge: true, alert: true)
//    );
//    _fcm.onIosSettingsRegistered
//        .listen((IosNotificationSettings settings)
//    {
//      print("Settings registered: $settings");
//    });
//  }

//  static dispose(){
//    messageBS.close();
//  }
}