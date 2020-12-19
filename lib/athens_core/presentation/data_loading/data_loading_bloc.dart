import 'package:project_athens/athens_core/presentation/base_change_notifier.dart';
import 'package:project_athens/athens_core/presentation/data_loading/data_loading_state.dart';

class DataLoadingBloc extends BaseChangeNotifier {
  DataLoadingState _loadingState = DataLoadingState.INITIAL_LOADING;

  DataLoadingState get loadingState => _loadingState;

  void setDataLoadingState(DataLoadingState newState) {
    _loadingState = newState;
    notifyListeners();
  }
}