import 'dart:collection';

import 'package:project_athens/athens_core/ads/domain/are_ads_enabled_use_case.dart';
import 'package:project_athens/athens_core/ads/native_ad/internal_native_ad.dart';

class NativeAdProvider {
  final String factoryId;
  final AreAdsEnabledUseCase _areAdsEnabledUseCase;
  final Queue<InternalNativeAd> nativeAds = Queue();

  NativeAdProvider(this.factoryId, this._areAdsEnabledUseCase) {
    List.generate(3, (index) => 0).forEach((element) {
      _generateAd();
    });
  }

  InternalNativeAd provide() {
    _generateAd();
    return nativeAds.removeFirst();
  }

  void _generateAd() async {
    nativeAds.add(InternalNativeAd(factoryId, _areAdsEnabledUseCase));
  }

  void dispose() {
    nativeAds.forEach((element) {
      element.dispose();
    });
  }
}
