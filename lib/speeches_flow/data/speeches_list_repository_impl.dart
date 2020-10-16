import 'dart:async';

import 'package:project_athens/athens_core/domain/list/base_params.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/models/timeline_model.dart';
import 'package:project_athens/speeches_flow/domain/list/speeches_list_repository.dart';
import 'package:rxdart/rxdart.dart';

class SpeechesListRepositoryImpl extends SpeechesListRepository {
  final StreamController<Result<List<SpeechModel>>> _speechesSubject =
      BehaviorSubject<Result<List<SpeechModel>>>();

  @override
  void dispose() {
    _speechesSubject.close();
  }

  @override
  Future<void> fetchItems(int limit, int offset) async {}

  @override
  Stream<Result<List<SpeechModel>>> getItems(BaseParams params) {
    List<SpeechModel> test = [SpeechModel("id", "title", "club", "desc", DateTime.now(), "thumbnailUrl", "videoUrl")];
    final result = Success(test);
    _speechesSubject.add(result);

    return _speechesSubject.stream;
  }

  @override
  Future<void> refreshItems() async {}
}
