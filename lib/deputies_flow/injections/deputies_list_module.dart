import 'package:flutter/src/widgets/framework.dart';
import 'package:nested/nested.dart';
import 'package:project_athens/athens_core/domain/list/list_use_case.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/deputies_flow/data/deputies_list_repository_impl.dart';
import 'package:project_athens/deputies_flow/screens/list/deputies_list_bloc.dart';
import 'package:project_athens/deputies_flow/screens/list/list/deputy_item_view_model_factory.dart';
import 'package:project_athens/deputies_utils/cache/deputies_cache.dart';
import 'package:provider/provider.dart';

class DeputiesListModule extends Module {

  DeputiesListModule(BuildContext context) : super(context);

  @override
  List<SingleChildWidget> getProviders() {
    final deputiesCache = Provider.of<DeputiesCache>(context);

    final deputiesListRepository = DeputiesListRepositoryImpl(deputiesCache);
    final listUseCase = ListUseCase(deputiesListRepository);
    final itemFactory = DeputyItemViewModelFactory();

    return [
      Provider<DeputiesListBloc>(
        create: (context) => DeputiesListBloc(listUseCase, null, itemFactory),
        dispose: (context, bloc) => bloc.dispose(),
      )
    ];
  }

}