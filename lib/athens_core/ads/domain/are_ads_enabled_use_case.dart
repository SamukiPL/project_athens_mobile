import 'package:project_athens/athens_core/ads/domain/ads_enabled_data_source.dart';
import 'package:project_athens/athens_core/domain/base_use_case.dart';

class AreAdsEnabledUseCase extends BaseUseCase {
  final AdsEnabledDataSource _dataSource;

  AreAdsEnabledUseCase(this._dataSource);

  Future<bool> call() => _dataSource.areAdsEnabled();
}
