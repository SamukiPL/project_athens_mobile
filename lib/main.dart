import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:project_athens/athens_core/i18n/localization_delegate.dart';
import 'package:project_athens/athens_core/injections/module_widget.dart';
import 'package:project_athens/athens_core/utils/firebase/firebase_messaging_module.dart';
import 'package:project_athens/main/firebase/firebase_messages.dart';
import 'package:project_athens/main/injections/app_module.dart';
import 'package:project_athens/main/injections/app_navigation_module.dart';
import 'package:project_athens/main/injections/main_widget_module.dart';
import 'package:project_athens/splash_screen/splash_screen_widget.dart';

import 'athens_core/configuration/configuration_module.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  print('Handling a background message ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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

    // we have to eagerly create auto updater due to
    // splash screen bloc could access it immediately
    // after it starts to checking direction
    Fimber.plantTree(DebugBufferTree());
    return ModuleWidget(
      providers: [
        AppModule(context),
        FirebaseMessagingModule(context, _firebaseMessages),
        ConfigurationModule(context),
        MainWidgetModule(context)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Project Athens',
        theme: ThemeData(
            primarySwatch: MaterialColor(
              0xff00bfff,
              const <int, Color>{
                50: const Color(0xff00bfff),
                100: const Color(0xff00bfff),
                200: const Color(0xff00bfff),
                300: const Color(0xff00bfff),
                400: const Color(0xff00bfff),
                500: const Color(0xff00bfff),
                600: const Color(0xff00bfff),
                700: const Color(0xff00bfff),
                800: const Color(0xff00bfff),
                900: const Color(0xff00bfff),
              },
            ),
            backgroundColor: Colors.white,
            dividerColor: Color(0xffaaaaaa),
            primaryColor: Color(0xff00bfff),
            primaryColorDark: Color(0xff008ebe),
            accentColor: Colors.blueAccent),
        home: ModuleWidget(
          providers: [AppNavigationModule(context)],
          child: SplashScreenWidget(),
        ),
        supportedLocales: [const Locale('pl')],
        localizationsDelegates: [
          const AppLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        localeResolutionCallback:
            (Locale locale, Iterable<Locale> supportedLocales) {
          return supportedLocales.firstWhere(
              (supportedLocale) =>
                  supportedLocale.languageCode == locale.languageCode,
              orElse: () => supportedLocales.first);
        },
      ),
    );
  }
}
