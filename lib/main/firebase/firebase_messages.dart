import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

class FirebaseMessages {

  final FirebaseMessaging firebaseMessaging;

  FirebaseMessages(this.firebaseMessaging);

  void setupMessaging() {
    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) {
        print('AppPushs onMessage : $message');
        return;
      },
      onBackgroundMessage: Platform.isIOS ? null : myBackgroundMessageHandler,
      onResume: (Map<String, dynamic> message) {
        print('AppPushs onResume : $message');
        return;
      },
      onLaunch: (Map<String, dynamic> message) {
        print('AppPushs onLaunch : $message');
        return;
      },
    );
    firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
  }

  static Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
    }

    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
    }

    // Or do other work.
    return Future<void>.value();
  }
}
