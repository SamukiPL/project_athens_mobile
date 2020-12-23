import 'dart:async';

import 'package:project_athens/athens_core/domain/data_mapper.dart';
import 'package:project_athens/athens_core/domain/list/base_params.dart';
import 'package:project_athens/athens_core/domain/list/list_use_case.dart';
import 'package:project_athens/athens_core/navigation/bottom_navigation_bloc.dart';
import 'package:project_athens/athens_core/presentation/base_blocs/base_list_bloc.dart';
import 'package:project_athens/deputies_flow/domain/deputies_list_params.dart';
import 'package:project_athens/deputies_flow/navigation/deputies_destinations.dart';
import 'package:project_athens/deputies_flow/screens/list/list_impl/deputy_list_item_view_model.dart';
import 'package:project_athens/deputies_utils/domain/deputy_model.dart';
import 'package:rxdart/rxdart.dart';

class DeputiesListBloc extends BaseListBloc<DeputyModel, DeputyListItemViewModel, DeputiesListParams> {
  DeputiesListBloc(
      ListUseCase<DeputyModel, DeputiesListParams> listUseCase,
      DeputiesListParams params,
      DataMapper<DeputyModel, DeputyListItemViewModel> itemMapper)
      : super(listUseCase, params, itemMapper);

  @override
  Function(DeputyModel p1) get itemClick => (DeputyModel model) {
    goToDestination(DeputyDetailsDestination(model, BottomNavItem.DEPUTIES));
  };

  @override
  Future<void> loadMore() async {}

  @override
  Future<void> refresh() async {}
}
