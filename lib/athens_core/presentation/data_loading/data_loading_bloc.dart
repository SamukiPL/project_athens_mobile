import 'package:project_athens/athens_core/presentation/base_blocs/base_change_notifier.dart';
import 'package:project_athens/athens_core/presentation/data_loading/data_loading_state.dart';

class DataLoadingBloc extends BaseChangeNotifier {
  DataLoadingBloc({this.loadingState = const DataLoadingState.initialLoading()});

  DataLoadingState loadingState;

  void setDataLoadingState(DataLoadingState newState) {
    loadingState = newState;
    notifyListeners();
  }
}
