import 'package:project_athens/athens_core/presentation/base_blocs/base_bloc.dart';
import 'package:project_athens/athens_core/presentation/data_loading/data_loading_bloc.dart';
import 'package:project_athens/settings_flow/cache/backers_cache.dart';

class HallOfFameBloc extends BaseBloc {

  final BackersCache backersCache;

  HallOfFameBloc(this.backersCache);

  @override
  dispose() {
  }
}
