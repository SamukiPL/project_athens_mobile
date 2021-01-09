import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/presentation/base_blocs/base_bloc.dart';
import 'package:project_athens/athens_core/presentation/data_loading/data_loading_bloc.dart';
import 'package:project_athens/athens_core/presentation/data_loading/data_loading_state.dart';
import 'package:project_athens/athens_core/presentation/widget_state.dart';
import 'package:project_athens/timeline_flow/domain/cloud/word_model.dart';
import 'package:project_athens/timeline_flow/domain/timeline_parameters.dart';
import 'package:project_athens/timeline_flow/domain/use_cases/get_noun_cloud_use_case.dart';
import 'package:rxdart/rxdart.dart';
import 'package:project_athens/athens_core/domain/base_repository.dart';

class NounCloudBloc extends BaseBloc {

  final StreamController<List<Widget>> _widgetsController = BehaviorSubject<List<Widget>>();

  Stream<List<Widget>> get widgets => _widgetsController.stream;

  final GetNounCloudUseCase _getNounCloudUseCase;

  NounCloudBloc(this._getNounCloudUseCase);

  Future<void> loadCloud(TimelineParameters params) async {
    setLoadingState(DataLoadingState.initialLoading());
    final result = await _getNounCloudUseCase(params).safeApiCall();

    manageState(result);
    if (result is Success<List<WordModel>>) {
      final widgets = await generateWidgets(result.value);
      _widgetsController.add(widgets);
      manageSuccess(widgets.length);
    }
  }

  void manageSuccess(int widgetsLength) {
    final loadingState = (widgetsLength > 0)
        ? DataLoadingState.contentLoaded()
        : DataLoadingState.noData();
    setLoadingState(loadingState);
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
    super.dispose();
    _widgetsController.close();
  }

}