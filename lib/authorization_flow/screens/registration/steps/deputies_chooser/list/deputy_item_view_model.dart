import 'package:project_athens/athens_core/presentation/base_item_view_model.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/deputies_chooser/list/view_holders/deputy_view_holder.dart';
import 'package:project_athens/deputies_utils/domain/deputy_model.dart';
import 'package:flutter/cupertino.dart';

class DeputyItemViewModel extends BaseItemViewModel {

  final DeputyModel model;

  final String name;

  DeputyItemViewModel({required this.model, required this.name});

  late bool Function(DeputyItemViewModel) itemClick;

  bool _checked = false;
  bool get checked => _checked;

  bool _vote = false;
  bool get vote => _vote;

  bool _speech = false;
  bool get speech  => _speech;

  bool _interpolation = false;
  bool get interpolation => _interpolation;

  void setChecked(bool checked) {
    _vote = checked;
    _speech = checked;
    _interpolation = false;
    _checked = checked;
    _checked = itemClick(this) && checked;
    notifyListeners();
  }

  void setVote(bool vote) {
    _vote = checked && vote;
    notifyListeners();
  }

  void setSpeech(bool speech) {
    _speech = checked && speech;
    notifyListeners();
  }

  void setInterpolation(bool interpolation) {
    _interpolation = checked && interpolation;
    notifyListeners();
  }

  @override
  Widget buildWidget(int index, int length) {
    return DeputyViewHolder(viewModel: this);
  }

}