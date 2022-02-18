import 'package:flutter/cupertino.dart';

mixin ItemSeenStateHolder on ChangeNotifier {
  late bool _viewed = startViewedValue();
  bool get viewed => _viewed;

  bool startViewedValue();

  void itemWasSeen() {
    _viewed = true;
    notifyListeners();
  }
}
