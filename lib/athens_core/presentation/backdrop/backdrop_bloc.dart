import 'package:project_athens/athens_core/presentation/base_change_notifier.dart';

class BackdropBloc extends BaseChangeNotifier {

  double _bottomChildSize;

  void setBottomChildSize(double bottomChildSize) {
    _bottomChildSize = bottomChildSize;
  }

}