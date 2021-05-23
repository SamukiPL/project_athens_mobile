import 'package:project_athens/athens_core/presentation/base_blocs/base_change_notifier.dart';

class AuthFailedNotifier extends BaseChangeNotifier {
  set state(bool failed) {
    hasFailed = failed;
    notifyListeners();
  }

  bool hasFailed = false;
}