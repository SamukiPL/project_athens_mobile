import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/timeline_flow/domain/cloud/word_model.dart';
import 'package:project_athens/timeline_flow/domain/timeline_parameters.dart';
import 'package:project_athens/timeline_flow/domain/use_cases/get_noun_cloud_use_case.dart';
import 'package:project_athens/timeline_flow/screens/timeline/cloud/noun_cloud_state.dart';
import 'package:rxdart/rxdart.dart';
import 'package:project_athens/athens_core/domain/base_repository.dart';

class NounCloudBloc {

  StreamController<NounCloudState> _stateController = BehaviorSubject<NounCloudState>();

  Stream<NounCloudState> get state => _stateController.stream;

  final GetNounCloudUseCase _getNounCloudUseCase;

  NounCloudBloc(this._getNounCloudUseCase);

  Future<void> loadCloud(TimelineParameters params) async {
    final result = await _getNounCloudUseCase(params).safeApiCall();

    if (result is Success<List<WordModel>>) {
      final widgets = await generateWidgets(result.value);
      _stateController.add(CloudReady(widgets));
    }
  }

  Future<List<Widget>> generateWidgets(List<WordModel> nouns) async {
    List<Widget> widgets = List<Widget>();
    nouns.forEach((model) {
      widgets.add(RotatedBox(
        quarterTurns: (model.occurrence % 2).toInt(),
        child: Text(
          "#${model.word}",
          style: TextStyle(fontSize: model.occurrence, color: Colors.white),
        ),
      ));
    });

    return widgets;
  }

  void dispose() {
    _stateController.close();
  }

}