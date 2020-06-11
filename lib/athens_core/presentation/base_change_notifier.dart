import 'package:flutter/foundation.dart';

abstract class BaseChangeNotifier extends ChangeNotifier {

  @protected
  bool disposed = false;

  @override
  void dispose() {
    disposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!disposed)
      super.notifyListeners();
  }

}