import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:rxdart/rxdart.dart';

class FCMProvider {

  FCMProvider() {
    setFCMBackgroundMessageHandler();
  }


  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final BehaviorSubject<String> fcmTokenSubject = BehaviorSubject<String>();
  final PublishSubject<Map<String, String>> notificationSubject =
      PublishSubject<Map<String, String>>();
  void setFCMBackgroundMessageHandler() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        String target = message['data']['target'];

        switch (target) {
          case 'room':
            String roomId = message['data']['room_id'];
            String tag = 'room';
            notificationSubject.add({'tag': tag, 'id': roomId});
            break;

          case 'request':
            String requestID = message['data']['request_id'];
            String tag = 'request';
            notificationSubject.add({'tag': tag, 'id': requestID});
            break;

          case 'order':
            String orderId = message['data']['order_id'];
            String tag = 'order';
            notificationSubject.add({'tag': tag, 'id': orderId});
            break;
        }
        print("onResume: $message");
      },
    );
    _firebaseMessaging.requestNotificationPermissions();
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      print('FCM NEW TOKEN : $token');
      fcmTokenSubject.add(token);
    });
  }

  void cleanTokenListener() {
    fcmTokenSubject.close();
    notificationSubject.close();
  }
}
