
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessages {
  FirebaseMessaging get firebaseMessaging => FirebaseMessaging.instance;
  
  void setupMessaging() {
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print('AppPushs onLaunch : ${event.notification?.body}');
    });
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true
    );
  }
}
