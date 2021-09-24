import 'package:project_athens/athens_core/presentation/base_blocs/base_change_notifier.dart';

class BackdropBloc extends BaseChangeNotifier {

  bool _isBottomShowing = false;
  late double _bottomChildSize;

  bool get isBottomShowing => _isBottomShowing;
  double get bottomChildSize => _bottomChildSize;

  void setBottomChildSize(double bottomChildSize) {
  }

  void closeBackdrop() {
    changeState(_bottomChildSize);
  }

  void changeState(double? bottomChildSize) {
    if (bottomChildSize == null) return;

    _bottomChildSize = bottomChildSize;
    _isBottomShowing = !_isBottomShowing;
    notifyListeners();
  }

}