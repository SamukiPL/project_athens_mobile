import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project_athens/athens_core/configuration/configuration_delegate.dart';
import 'package:project_athens/athens_core/configuration/configuration_storage_names.dart';
import 'package:project_athens/athens_core/models/saved_notification.dart';
import 'package:project_athens/athens_core/presentation/delegates/redirection_delegate.dart';
import 'package:project_athens/speeches_flow/navigation/speeches_destinations.dart';
import 'package:rxdart/rxdart.dart';

class NotificationsService with ConfigurationDelegate<List<SavedNotification>, SavedNotification>, RedirectionDelegate {
  static NotificationsService? _instance;
  static NotificationsService? get instance => _instance;

  static Future<void> intialize() async {
    if (_instance != null) {
      print('[NotificationsService]: Trying to create service that is currently created');
      return;
    }

    _instance = NotificationsService();
    return instance!.init();
  }

  NotificationsService();

  BuildContext? _buildContext;
  SavedNotification? _suspendedRedirection;
  bool _mainWidgetInitialized = false;

  @override
  String get preferenceName => ConfigurationStorageNames.NOTIFICATIONS;

  @override
  List<SavedNotification> get defaultStorageValue => List.empty(growable: true);

  bool notificationsFetched = false;

  final List<SavedNotification> notifications = List.empty(growable: true);

  ReplaySubject<List<SavedNotification>> notificationsSource = ReplaySubject<List<SavedNotification>>(maxSize: 1);
  Stream<List<SavedNotification>> get notificationsStream => notificationsSource.stream.shareReplay(maxSize: 1);

  Future<void> init() async {
    final List<SavedNotification> _notifications = await fetchPreference((Map<String, dynamic> json) => SavedNotification.fromJson(json));

    notificationsFetched = true;
    notifications.addAll(_notifications);

    _processSavedNotificationsAtHardDrive();

    _broadcastNotifications();
    await saveNotifications(notifications);
  }

  void updateContext(BuildContext context, bool mainWidgetInitialized) {
    _buildContext = context;
    print('update context');

    if (mainWidgetInitialized) {
      _mainWidgetInitialized = mainWidgetInitialized;
    }

    if (_suspendedRedirection != null) {
      openDestination(_suspendedRedirection!);
    }
  }

  void onApplicationResumed() async {
    print('checking notifcaitons on resumed');

    final needToSave = await _processSavedNotificationsAtHardDrive();


    if (needToSave) {
      print('some files where saved. Saving notifcations...');
      _broadcastNotifications();
      await saveNotifications(notifications);
    }
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
    final fileName = _notification.messageId!;

    final File file = File("$directory/saved_notification_$fileName.json");
    file.writeAsStringSync(content);
  }

  Future<void> openDestinationFromRemoteMessage(RemoteMessage message) async {
    if (message.notification == null) return;

    final SavedNotification notification = _mapToSavedNotification(message);

    return openDestination(notification);
  }

  Future<void> openDestination(SavedNotification notification) async {
    if (_buildContext == null || !_mainWidgetInitialized) {
      print("[NotificationsService]: Currently BuildContext is not defined. Storing current redirection and wait till data is available");
      _suspendedRedirection = notification;
      return;
    }

    notification.isRead = true;

    switch (notification.type) {
      case "SPEECH":
        goToDestination(_buildContext!, SpeechDetailsDestination(notification.refId!, false));
        _suspendedRedirection = null;
        break;
      // case NotificationType.VOTE:
        // final partialVoteModel = VoteSlimModel(id: notification.refId, title: title, type: type, voteAt: voteAt, voteNumbers: voteNumbers, votingDesc: votingDesc)
        // goToDestination(_buildContext!, VoteDetailsDestination(_voteModel));
        // break;
      // case NotificationType.DEPUTY:
        // goToDestination(_buildContext!, DeputyDetailsDestination(_deputyModel))
    }

    await saveNotifications(notifications);
    _broadcastNotifications();
  }

  Future<void> saveNotifications(List<SavedNotification> notificationsToSave) async {
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
        message.sentTime,
        message.messageId,
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

  void _broadcastNotifications() {
    notifications.sort((a,b) => b.sentTime!.compareTo(a.sentTime!));
    final List<SavedNotification> newInstanceList = List.of(notifications);
    notificationsSource.add(newInstanceList);
  }

  void dispose() {
    notificationsSource.close();
  }
}
