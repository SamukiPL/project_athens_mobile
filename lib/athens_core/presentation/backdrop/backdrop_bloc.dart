import 'package:project_athens/athens_core/presentation/base_blocs/base_change_notifier.dart';

class BackdropBloc extends BaseChangeNotifier {

  bool _isBottomShowing = false;
  double _bottomChildSize;

  bool get isBottomShowing => _isBottomShowing;
  double get bottomChildSize => _bottomChildSize;

  void setBottomChildSize(double bottomChildSize) {
  }

  void closeBackdrop() {
    changeState(_bottomChildSize);
  }

  void changeState(double bottomChildSize) {
    _bottomChildSize = bottomChildSize;
    _isBottomShowing = !_isBottomShowing;
    notifyListeners();
  }

}