import 'package:project_athens/athens_core/navigation/destination_manager.dart';
import 'package:project_athens/athens_core/presentation/base_blocs/base_change_notifier.dart';
import 'package:flutter/material.dart';

abstract class BaseItemViewModel extends BaseChangeNotifier {

  Widget buildWidget(int index, int length);

}