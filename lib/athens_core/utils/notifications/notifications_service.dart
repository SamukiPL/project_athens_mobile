import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project_athens/athens_core/configuration/configuration_delegate.dart';
import 'package:project_athens/athens_core/configuration/configuration_storage_names.dart';
import 'package:project_athens/athens_core/utils/notifications/domain/notification_model.dart';
import 'data/storage/saved_notification.dart';
import 'package:project_athens/athens_core/presentation/delegates/redirection_delegate.dart';
import 'package:rxdart/rxdart.dart';
import 'package:collection/collection.dart';

class NotificationsService with ConfigurationDelegate<List<SavedNotification>, SavedNotification>, RedirectionDelegate {
  static NotificationsService? _instance;
  static NotificationsService? get instance => _instance;

  static Future<void> initialize({final bool isInitializedFromApp = false}) async {
    if (_instance != null) {
      Fimber.w('[NotificationsService]: Trying to create service that is currently created');
      return;
    }

    _instance = NotificationsService();
    return instance!.init(isInitializedFromApp: isInitializedFromApp);
  }

  NotificationsService();

  late SavedNotification? _suspendedNotification;

  ReplaySubject<void> _suspendedNavigationSource = ReplaySubject(maxSize: 1);
  Stream<void> get suspendedNavigationStream => _suspendedNavigationSource.stream;

  ReplaySubject<List<SavedNotification>> _notificationsSource = ReplaySubject<List<SavedNotification>>(maxSize: 1);
  Stream<List<SavedNotification>> get notificationsStream => _notificationsSource.stream.shareReplay(maxSize: 1);

  @override
  String get preferenceName => ConfigurationStorageNames.NOTIFICATIONS;

  @override
  List<SavedNotification> get defaultStorageValue => List.empty(growable: true);

  bool get hasSuspendedNavigation => _suspendedNotification != null;

  bool notificationsFetched = false;

  final List<SavedNotification> notifications = List.empty(growable: true);

  Future<void> init({final bool isInitializedFromApp = false}) async {
    final List<SavedNotification> _notifications = await fetchPreference((Map<String, dynamic> json) => SavedNotification.fromJson(json));

    notificationsFetched = true;
    notifications.addAll(_notifications);

    if (isInitializedFromApp) {
      _processSavedNotificationsAtHardDrive();
      await _checkForInitialMessage();

      await _saveNotifications(notifications);
    }

    _broadcastNotifications();
    await _saveNotifications(notifications);
  }

  Future<void> addNotification(SavedNotification notification) async {
    notifications.insert(0, notification);

    if (notificationsFetched) {
      _broadcastNotifications();
    }

    await updatePreference(notifications);
  }

  Future<void> addNotificationFromRemoteMessage(RemoteMessage message) async {
    if (message.notification == null) return;

    final SavedNotification flattenedMessage = _mapToSavedNotification(message);

    await addNotification(flattenedMessage);
  }

  Future<void> addNotificationFromBackgroundRemoteMessage(RemoteMessage message) async {
    final String directory = (await getApplicationDocumentsDirectory()).path;

    final SavedNotification _notification = _mapToSavedNotification(message);

    final content = jsonEncode(_notification);
    final fileName = _notification.messageId;

    final File file = File("$directory/saved_notification_$fileName.json");
    file.writeAsStringSync(content);
  }

  Future<void> openDestinationFromRemoteMessage(RemoteMessage message) async {
    if (message.notification == null) return;

    final SavedNotification notification = _mapToSavedNotification(message);

    return openDestination(notification);
  }

  Future<void> openDestinationFromNotification(NotificationModel notification) async {
     final SavedNotification savedNotification = notifications.firstWhere((element) => element.messageId == notification.messageId);

     return openDestination(savedNotification);
  }

  Future<void> openDestination(SavedNotification notification) async {
    _suspendedNotification = notification;

    notification.isRead = true;

    await _saveNotifications(notifications);

    _suspendedNavigationSource.add(null);

    _broadcastNotifications();
  }

  SavedNotification getSuspendedNavigation() {
    final SavedNotification _notification = _suspendedNotification!;

    _suspendedNotification = null;

    return _notification;
  }

  Future<void> _saveNotifications(List<SavedNotification> notificationsToSave) async {
    return await updatePreference(notificationsToSave);
  }

  SavedNotification _mapToSavedNotification(RemoteMessage message) {
    final String? imgUrl = message.notification!.android?.imageUrl ?? message.notification!.apple?.imageUrl ?? null;

    final type = message.data['type'] ?? null;
    final refId = message.data['refId'] ?? null;

    return SavedNotification(
        message.notification!.title!,
        message.notification!.body,
        imgUrl,
        message.sentTime ?? DateTime.now(),
        message.messageId!,
        message.collapseKey,
        message.data,
        type,
        refId,
        false
    );
  }

  /// returns whether some changes have been made and it's required to save it
  /// and populate chnages between comsumers
  Future<bool> _processSavedNotificationsAtHardDrive() async {
    final String directory = (await getApplicationDocumentsDirectory()).path;
    final files = Directory(directory).listSync();
    final filteredFiles = files.where((element) => element.path.contains('saved_notification'));

    final List<SavedNotification> notificationsToSave = List.empty(growable: true);

    if (filteredFiles.length > 0) {
      for (final file in filteredFiles) {
        final fileContent = File(file.path).readAsStringSync();
        final SavedNotification savedNotification = SavedNotification.fromJson(jsonDecode(fileContent));
        file.deleteSync();

        notificationsToSave.add(savedNotification);
      }

      notifications.addAll(notificationsToSave);

      if (notificationsToSave.length > 0) {
        return true;
      }
    }

    return false;
  }

  /// Message that user pressed in notification bar which caused application
  /// to start from dead.
  Future<void> _checkForInitialMessage() async {
    final RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      final SavedNotification foundNotification = notifications
          .firstWhereOrNull((notification) => notification.messageId == initialMessage.messageId!)
          ?? _mapToSavedNotification(initialMessage);

      foundNotification.isRead = true;
      _suspendedNotification = foundNotification;
      _suspendedNavigationSource.add(null);

      if (notifications.firstWhereOrNull((notification) => notification.messageId == initialMessage.messageId!) == null) {
        notifications.add(foundNotification);
      }
    }
  }

  void _broadcastNotifications() {
    notifications.sort((a,b) => b.sentTime.compareTo(a.sentTime));
    final List<SavedNotification> newInstanceList = List.of(notifications);
    _notificationsSource.add(newInstanceList);
  }

  void dispose() {
    _notificationsSource.close();
    _suspendedNavigationSource.close();
  }
}
