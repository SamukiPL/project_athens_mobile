import 'package:flutter/widgets.dart';
import 'package:project_athens/athens_core/presentation/base_blocs/base_change_notifier.dart';

abstract class BaseFilterType extends BaseChangeNotifier {
  
  BaseFilterType copy();

  Widget buildFilter(BuildContext parentContext);

}