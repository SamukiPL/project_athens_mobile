import 'dart:async';

import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:project_athens/athens_core/domain/data_mapper.dart';
import 'package:project_athens/athens_core/domain/list/base_params.dart';
import 'package:project_athens/athens_core/domain/list/list_use_case.dart';
import 'package:project_athens/athens_core/presentation/base_list_bloc.dart';
import 'package:project_athens/deputies_flow/screens/list/list_impl/deputy_list_item_view_model.dart';
import 'package:project_athens/deputies_utils/domain/deputy_model.dart';
import 'package:rxdart/rxdart.dart';

class DeputiesListBloc extends BaseListBloc<DeputyModel, DeputyListItemViewModel, BaseParams> {
  DeputiesListBloc(ListUseCase<DeputyModel, BaseParams> listUseCase, BaseParams params, DataMapper<DeputyModel, DeputyListItemViewModel> itemMapper) : super(listUseCase, params, itemMapper);

  final StreamController<DeputyModel> _goToDetails = PublishSubject();

  Stream<DeputyModel> get goToDetails => _goToDetails.stream;

  @override
  Function(DeputyModel p1) get itemClick => (DeputyModel model) {
    _goToDetails.add(model);
  };

  @override
  Future<void> loadMore() async {}

  @override
  Future<void> refresh() async {}

  @override
  void dispose() {
    _goToDetails.close();
    super.dispose();
  }

}