import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:lang_generator/annotations/lang_annotation.dart';

part 'localization.g.dart';

@LangAutomation('resources/lang/pl.json')
class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  late Map<String, dynamic> _words;

  late AppLocalizationsGenerated _generated;

  Future<bool> load() async {
    String data = await rootBundle
        .loadString('resources/lang/${this.locale.languageCode}.json');
    _words = json.decode(data);

    _generated = AppLocalizationsGenerated(_words);

    return true;
  }

  AppLocalizationsGenerated getText() {
    return _generated;
  }

  AppLocalizationsGenerated call() {
    return _generated;
  }
}
