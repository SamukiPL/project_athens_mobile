import 'package:athens_core/domain/result.dart';
import 'package:athens_core/presentation/base_bloc.dart';
import 'package:pagination/paging_bloc.dart';
import 'package:pagination/paging_list_adapter.dart';
import 'package:timeline_flow/domain/get_timeline_use_case.dart';
import 'package:timeline_flow/domain/timeline_model.dart';
import 'package:timeline_flow/domain/timeline_parameters.dart';
import 'package:timeline_flow/screens/list/timeline_row_view_model.dart';
import 'package:athens_core/domain/base_repository.dart';
import 'package:timeline_flow/screens/list/timeline_row_view_model_factory.dart';

class TimelineBloc extends BaseBloc implements PagingBloc<TimelineRowViewModel> {

  final GetTimelineUseCase getTimelineUseCase;

  TimelineBloc(this.getTimelineUseCase) {
    adapter = PagingListAdapter(this);
    test();
  }

  Future<void> test() async {
    _loadFreshData();
  }

  @override
  PagingListAdapter<TimelineRowViewModel> adapter;

  @override
  int batchSize;

  @override
  int page;

  List<TimelineRowViewModel> _items;

  @override
  Future<void> loadMore() async {}

  @override
  Future<void> refresh() async {}

  Future<void> _loadFreshData() async {
    final result = await getTimelineUseCase(TimelineParameters(9, "2020-04-15T15:37:56Z"))
                      .safeApiCall();

    if (result is Success<List<TimelineModel>>) {
      _items = result.result.toTimelineRowViewModel();
      adapter.updateList(_items);
    }
  }

  @override
  void dispose() {
    adapter.dispose();
    super.dispose();
  }

}