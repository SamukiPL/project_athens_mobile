import 'package:rxdart/rxdart.dart';

class LifeCycleService {
  final ReplaySubject<void> _applicationResumedSource = ReplaySubject<void>();
  Stream<void> get applicationResumedStream => _applicationResumedSource.stream;

  applicationResumed() {
    _applicationResumedSource.add(null);
  }

  final ReplaySubject<void> _pausedSource = ReplaySubject<void>();
  Stream<void> get pausedStream => _pausedSource.stream;

  paused() {
    _pausedSource.add(null);
  }

  final ReplaySubject<void> _inactiveSource = ReplaySubject<void>();
  Stream<void> get inactiveStream => _inactiveSource.stream;

  inactive() {
    _inactiveSource.add(null);
  }

  final ReplaySubject<void> _detachedSource = ReplaySubject<void>();
  Stream<void> get detachedStream => _detachedSource.stream;

  detached() {
    _detachedSource.add(null);
  }

  dispose() {
    _applicationResumedSource.close();
    _pausedSource.close();
    _inactiveSource.close();
    _detachedSource.close();
  }
}