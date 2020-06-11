import 'package:project_athens/athens_core/presentation/base_change_notifier.dart';

class FabBloc extends BaseChangeNotifier {

  bool visible = true;

  FabBloc({this.visible});

  void setVisible(bool visible) {
    this.visible = visible;
    notifyListeners();
  }

}