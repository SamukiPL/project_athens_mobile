import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/filters_and_sort/domain/easy_filters/easy_filter_model.dart';

abstract class EasyFiltersRepository<T> {

  Future<Result<List<EasyFilterModel<T>>>> getFilters();
}
