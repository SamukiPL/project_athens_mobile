import 'dart:async';
import 'dart:math';

import 'package:project_athens/athens_core/presentation/base_blocs/base_bloc.dart';
import 'package:rxdart/rxdart.dart';

enum StepAction { NEGATIVE, POSITIVE }

abstract class BaseRegistrationStepBloc extends BaseBloc {

  StreamController<StepAction> _stepActionController = BehaviorSubject<StepAction>();

  Stream<StepAction> get stepAction => _stepActionController.stream;

  StreamController<String> _headingLineController = BehaviorSubject<String>();
  Stream<String> get headingLine => _headingLineController.stream;

  StreamController<int> _resetFooterButtonStateController = BehaviorSubject<int>();
  Stream<int> get resetFooterButtonState => _resetFooterButtonStateController.stream;

  Future<void> call();

  void invokeAction(StepAction action) {
    _stepActionController.add(action);
  }

  @override
  void dispose() {
    _stepActionController.close();
    _headingLineController.close();
    _resetFooterButtonStateController.close();
    super.dispose();
  }

  void updateHeaderHelperLine(String line) {
    _headingLineController.add(line);
  }

  void resetFooterButtons() {
    _resetFooterButtonStateController.add(Random(951234).nextInt(1000));
  }

}