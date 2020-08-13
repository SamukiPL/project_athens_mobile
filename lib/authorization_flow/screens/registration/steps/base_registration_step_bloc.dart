import 'dart:async';

import 'package:project_athens/athens_core/presentation/base_bloc.dart';
import 'package:rxdart/rxdart.dart';

enum StepAction { NEGATIVE, POSITIVE }

abstract class BaseRegistrationStepBloc extends BaseBloc {

  StreamController<StepAction> _stepActionController = BehaviorSubject<StepAction>();

  Stream<StepAction> get stepAction => _stepActionController.stream;

  Future<void> call();

  void invokeAction(StepAction action) {
    _stepActionController.add(action);
  }

  @override
  void dispose() {
    _stepActionController.close();
    super.dispose();
  }

}