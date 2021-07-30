import 'package:project_athens/athens_core/presentation/base_blocs/base_bloc.dart';
import 'package:project_athens/more_flow/cache/backers_cache.dart';

class HallOfFameBloc extends BaseBloc {

  final BackersCache backersCache;

  HallOfFameBloc(this.backersCache);
}
