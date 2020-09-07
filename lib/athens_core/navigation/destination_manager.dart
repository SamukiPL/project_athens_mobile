import 'package:flutter/cupertino.dart';
import 'package:project_athens/athens_core/presentation/base_change_notifier.dart';

abstract class DestinationManager extends BaseChangeNotifier {

  Widget currentScreen();

  bool goBack();

}