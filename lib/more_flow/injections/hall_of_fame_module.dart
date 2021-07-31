import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/more_flow/cache/backers_cache.dart';
import 'package:project_athens/more_flow/data/more/get_bacekers_repository_impl.dart';
import 'package:project_athens/more_flow/data/network/more_api.dart';
import 'package:project_athens/more_flow/domain/more/get_backers_use_case.dart';
import 'package:project_athens/more_flow/screens/hall_of_fame/hall_of_fame_bloc.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class HallOfFameModule extends Module {
  HallOfFameModule(BuildContext context) : super(context);

  @override
  List<SingleChildWidget> getProviders() {
    final client = Provider.of<Dio>(context);
    final moreApi = MoreApi(client);
    final _getBackersRepository = GetBackersRepositroyImpl(moreApi);
    final getBackersUseCase = GetBackersUseCase(_getBackersRepository);
    final _backersCache = BackersCache(getBackersUseCase);
    _backersCache.backers;

    return [
      Provider<HallOfFameBloc>(
          create: (_) => HallOfFameBloc(_backersCache),
          dispose: (context, bloc) => bloc.dispose()),
    ];
  }
}
