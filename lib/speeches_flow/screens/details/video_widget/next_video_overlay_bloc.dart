import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:project_athens/athens_core/models/speech_model.dart';
import 'package:rxdart/rxdart.dart';

class NextVideoOverlayBloc {

  final PublishSubject<PersonSpeechModel?> _streamController = PublishSubject();

  Stream<PersonSpeechModel?> get stream => _streamController.stream;

  final CountDownController _controller = CountDownController();

  CountDownController get controller => _controller;

  void pushOnNext(PersonSpeechModel? nextPersonSpeech) {
    _streamController.add(nextPersonSpeech);
  }

  void stopCountdown() {
    controller.pause();
    _streamController.add(null);
  }

  void dispose() {
    _streamController.close();
  }

}