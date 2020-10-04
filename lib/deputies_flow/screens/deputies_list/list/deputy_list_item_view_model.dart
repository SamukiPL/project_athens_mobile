import 'package:project_athens/athens_core/presentation/base_item_view_model.dart';
import 'package:project_athens/deputies_utils/domain/deputy_model.dart';
import 'package:flutter/cupertino.dart';

class DeputyListItemViewModel extends BaseItemViewModel {

  final DeputyModel model;

  DeputyListItemViewModel({@required this.model});

}