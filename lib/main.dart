import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:project_athens/athens_core/ads/injections/ads_module.dart';
import 'package:project_athens/athens_core/db/database_module.dart';
import 'package:project_athens/athens_core/i18n/localization_delegate.dart';
import 'package:project_athens/athens_core/i18n/localization_module.dart';
import 'package:project_athens/athens_core/injections/module_widget.dart';
import 'package:project_athens/athens_core/utils/firebase/firebase_messaging_module.dart';
import 'package:project_athens/athens_core/utils/notifications/notifications_service.dart';
import 'package:project_athens/deputies_utils/injections/subscribed_deputy_cache_module.dart';
import 'package:project_athens/main/firebase/firebase_messages.dart';
import 'package:project_athens/main/injections/app_module.dart';
import 'package:project_athens/main/injections/app_navigation_module.dart';
import 'package:project_athens/splash_screen/splash_screen_widget.dart';

import 'athens_core/configuration/configuration_module.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  Fimber.d('Handling a background message ${message.messageId}');

  if (NotificationsService.instance == null) {
    await NotificationsService.initialize();
  }

  NotificationsService.instance!
      .addNotificationFromBackgroundRemoteMessage(message);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationsService.initialize(isInitializedFromApp: true);

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final FirebaseMessages _firebaseMessages = FirebaseMessages();

  @override
  Widget build(BuildContext context) {
    _firebaseMessages.setupMessaging();

    Fimber.plantTree(DebugBufferTree());

    return ModuleWidget(
      providers: [
        AppModule(context),
        FirebaseMessagingModule(context, _firebaseMessages),
        ConfigurationModule(context),
        DatabaseModule(context),
        AppNavigationModule(context),
        AdsModule(context)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Świadoma Demokracja',
        theme: ThemeData(
            primarySwatch: MaterialColor(
              0xff61a1f3,
              const <int, Color>{
                50: const Color(0xff61a1f3),
                100: const Color(0xff61a1f3),
                200: const Color(0xff61a1f3),
                300: const Color(0xff61a1f3),
                400: const Color(0xff61a1f3),
                500: const Color(0xff61a1f3),
                600: const Color(0xff61a1f3),
                700: const Color(0xff61a1f3),
                800: const Color(0xff61a1f3),
                900: const Color(0xff61a1f3),
              },
            ),
            backgroundColor: Colors.white,
            scaffoldBackgroundColor: Colors.white,
            dividerColor: Color(0xffaaaaaa),
            primaryColor: Color(0xff61a1f3),
            primaryColorDark: Color(0xff008ebe),
            accentColor: Colors.blueAccent),
        home: Builder(
            builder: (context) => ModuleWidget(
                  providers: [
                    SubscribedDeputyCacheModule(context, _firebaseMessages),
                    LocalizationModule(context)
                  ],
                  child: SplashScreenWidget(),
                )),
        supportedLocales: [const Locale('pl')],
        localizationsDelegates: [
          const AppLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        localeResolutionCallback:
            (Locale? locale, Iterable<Locale> supportedLocales) {
          return supportedLocales.firstWhere(
              (supportedLocale) =>
                  supportedLocale.languageCode == locale?.languageCode,
              orElse: () => supportedLocales.first);
        },
      ),
    );
  }
}
