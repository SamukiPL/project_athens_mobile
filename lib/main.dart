import 'package:athens_core/i18n/localization_delegate.dart';
import 'package:athens_core/injections/module_widget.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:project_athens/firebase/firebase_messages.dart';
import 'package:project_athens/injections/app_navigation_module.dart';
import 'package:splash_screen/splash_screen_widget.dart';

void main() {
  Crashlytics.instance.enableInDevMode = true;

  FlutterError.onError = Crashlytics.instance.recordFlutterError;

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final FirebaseMessages _firebaseMessages = FirebaseMessages(FirebaseMessaging());

  @override
  Widget build(BuildContext context) {
    _firebaseMessages.setupMessaging();
    Fimber.plantTree(DebugBufferTree());
    return MaterialApp(
      title: 'Project Athens',
      theme: ThemeData(
        backgroundColor: Colors.white,
        dividerColor: Color(0xffaaaaaa),
        primaryColor: Color(0xff00bfff),
        primaryColorDark: Colors.indigo,
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
    );
  }
}
