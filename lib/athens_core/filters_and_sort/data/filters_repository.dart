import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/filters_and_sort/domain/sorting_model.dart';
import 'package:project_athens/athens_core/filters_and_sort/types/base_filter_type.dart';
import 'package:project_athens/athens_core/filters_and_sort/types/date_from_to.dart';
import 'package:project_athens/athens_core/ext/date_time_extension.dart';
import 'package:project_athens/athens_core/filters_and_sort/types/sorting_filter.dart';

class FiltersRepository {
  Future<Result<List<BaseFilterType>>> getFilters() async {
    final filters = [
      SortingFilter([
        SortingModel(0, "Ascending", "ASC", true),
        SortingModel(1, "Descending", "DESC", false)
      ]),
      DateFromTo(
          fromTime: DateTimeExtension.defaultFrom(),
          toTime: DateTimeExtension.defaultTo())
    ];
    return Success<List<BaseFilterType>>(filters);
  }
}
