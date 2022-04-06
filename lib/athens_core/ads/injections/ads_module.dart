import 'package:flutter/src/widgets/framework.dart';
import 'package:nested/nested.dart';
import 'package:project_athens/athens_core/ads/data/ads_enabled_data_source_impl.dart';
import 'package:project_athens/athens_core/ads/domain/ads_enabled_data_source.dart';
import 'package:project_athens/athens_core/ads/domain/are_ads_enabled_use_case.dart';
import 'package:project_athens/athens_core/ads/domain/disable_ads_use_case.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:provider/provider.dart';

class AdsModule extends Module {
  AdsModule(BuildContext context) : super(context);

  @override
  List<SingleChildWidget> getProviders() {
    AdsEnabledDataSource adsEnableDataSource = AdsEnabledDataSourceImpl();
    return [
      Provider<AreAdsEnabledUseCase>(create: (_) => AreAdsEnabledUseCase(adsEnableDataSource)),
      Provider<DisableAdsUseCase>(create: (_) => DisableAdsUseCase(adsEnableDataSource)),
    ];
  }

}
