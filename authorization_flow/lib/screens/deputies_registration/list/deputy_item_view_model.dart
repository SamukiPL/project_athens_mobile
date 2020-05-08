import 'package:athens_core/presentation/base_item_view_model.dart';
import 'package:authorization_flow/domain/deputies_registration/deputy_model.dart';
import 'package:flutter/cupertino.dart';

class DeputyItemViewModel extends BaseItemViewModel {

  final DeputyModel model;

  final String name;

  DeputyItemViewModel({@required this.model, @required this.name});

  bool _checked = false;

  bool get checked => _checked;

  void setChecked(bool checked) {
    _checked = checked;
    _checked = itemClick() && checked;
    notifyListeners();
  }

}