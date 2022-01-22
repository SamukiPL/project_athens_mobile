
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:project_athens/athens_core/utils/notifications/notifications_service.dart';

class FirebaseMessages {
  FirebaseMessaging get firebaseMessaging => FirebaseMessaging.instance;
  
  void setupMessaging() {
    FirebaseMessaging.onMessage.listen((event) {
      print('handling onMessage, ' + NotificationsService.instance.toString());
      NotificationsService.instance!.addNotificationFromRemoteMessage(event);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print('handling onMessageOpenedApp, ' + NotificationsService.instance.toString());
      NotificationsService.instance!.openDestinationFromRemoteMessage(event);
    });

    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true
    );
  }
}
