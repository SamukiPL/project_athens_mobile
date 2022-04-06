import 'package:project_athens/athens_core/ads/domain/ads_enabled_data_source.dart';
import 'package:project_athens/athens_core/domain/base_use_case.dart';

class DisableAdsUseCase extends BaseUseCase {
  final AdsEnabledDataSource _dataSource;

  DisableAdsUseCase(this._dataSource);

  Future<void> call({Duration addToToday = const Duration(days: 1)}) => _dataSource.disableAds(addToToday: addToToday);
}
