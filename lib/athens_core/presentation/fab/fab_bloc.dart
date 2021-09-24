import 'package:project_athens/athens_core/presentation/base_blocs/base_change_notifier.dart';

class FabBloc extends BaseChangeNotifier {

  bool visible;

  FabBloc({this.visible = true});

  void setVisible(bool visible) {
    this.visible = visible;
    notifyListeners();
  }

}