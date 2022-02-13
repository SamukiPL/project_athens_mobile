import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/deputies_flow/domain/details/get_full_deputy_use_case.dart';
import 'package:project_athens/deputies_utils/cache/deputies_cache.dart';
import 'package:provider/provider.dart';

class DeputyInformationModule extends Module {

  final String _deputyId;

  DeputyInformationModule(BuildContext context, this._deputyId) : super(context);

  @override
  List<SingleChildWidget> getProviders() {
    final deputiesCache = Provider.of<DeputiesCache>(context);

    return [
      Provider<GetFullDeputyUseCase>(
        create: (_) => GetFullDeputyUseCase(deputiesCache, _deputyId),
      )
    ];
  }
}
