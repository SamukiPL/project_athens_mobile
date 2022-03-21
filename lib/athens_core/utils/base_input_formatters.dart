import 'package:flutter/services.dart';

class BaseInputFormatters {
  BaseInputFormatters._();

  static FilteringTextInputFormatter emailLoginFormatter() =>
      FilteringTextInputFormatter.deny(new RegExp(r"\s\b|\b\s"));
}
