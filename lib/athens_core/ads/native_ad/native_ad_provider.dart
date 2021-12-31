import 'dart:collection';

import 'package:project_athens/athens_core/ads/native_ad/internal_native_ad.dart';

class NativeAdProvider {
  final String factoryId;
  final Queue<InternalNativeAd> nativeAds = Queue();

  NativeAdProvider(this.factoryId) {
    List.generate(3, (index) => 0).forEach((element) {
      _generateAd();
    });
  }

  InternalNativeAd provide() {
    _generateAd();
    return nativeAds.removeFirst();
  }

  void _generateAd() {
    nativeAds.add(InternalNativeAd(factoryId));
  }

  void dispose() {
    nativeAds.forEach((element) {
      element.dispose();
    });
  }
}
