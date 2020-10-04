import 'package:flutter/src/widgets/framework.dart';
import 'package:nested/nested.dart';
import 'package:project_athens/athens_core/domain/list/list_use_case.dart';
import 'package:project_athens/athens_core/injections/cached_module.dart';
import 'package:project_athens/deputies_flow/data/deputies_list_repository_impl.dart';
import 'package:project_athens/deputies_flow/screens/deputies_list/deputies_list_bloc.dart';
import 'package:project_athens/deputies_flow/screens/deputies_list/list/deputy_item_view_model_factory.dart';
import 'package:project_athens/deputies_utils/cache/deputies_cache.dart';
import 'package:provider/provider.dart';

class DeputiesListModule extends CachedModule {

  final DeputiesListBloc _deputiesListBloc;

  DeputiesListModule._(this._deputiesListBloc, BuildContext context) : super(context);

  factory DeputiesListModule(BuildContext context) {
    final deputiesCache = Provider.of<DeputiesCache>(context);

    final deputiesListRepository = DeputiesListRepositoryImpl(deputiesCache);
    final listUseCase = ListUseCase(deputiesListRepository);
    final itemFactory = DeputyItemViewModelFactory();

    final deputiesListBloc = DeputiesListBloc(listUseCase, null, itemFactory);

    return DeputiesListModule._(deputiesListBloc, context);
  }

  @override
  void disposeCache() {
    _deputiesListBloc.dispose();
  }

  @override
  List<SingleChildWidget> getProviders() => [
    Provider<DeputiesListBloc>.value(value: _deputiesListBloc),
  ];

}