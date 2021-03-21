import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/presentation/base_item_view_model.dart';

class BaseProgressViewModel extends BaseItemViewModel {

  @override
  Widget buildWidget(int index, int length) => Container(
    height: 75,
    child: Center(
      widthFactor: 10,
      heightFactor: 10,
      child: CircularProgressIndicator(),
    ),
  );

  @override
  void itemClick() {
    // TODO: implement itemClick
  }

}