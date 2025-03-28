import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:project_athens/athens_core/ads/ads_ids.dart';
import 'package:project_athens/athens_core/ads/domain/are_ads_enabled_use_case.dart';
import 'package:project_athens/athens_core/presentation/base_blocs/base_change_notifier.dart';

class InternalNativeAd extends BaseChangeNotifier {
  final AreAdsEnabledUseCase _areAdsEnabledUseCase;
  late NativeAd _ad;

  NativeAd get ad => _ad;

  bool _isLoaded = false;

  bool _adsEnabled = true;

  bool get shouldShow => _isLoaded && _adsEnabled;

  InternalNativeAd(String factoryId, this._areAdsEnabledUseCase) {
    checkIfAdsAreEnabled();
    _ad = NativeAd(
      adUnitId: AdsIds.nativeAd,
      factoryId: factoryId,
      request: AdRequest(),
      listener: NativeAdListener(onAdLoaded: (_) {
        _isLoaded = true;
        notifyListeners();
      }, onAdFailedToLoad: (ad, error) {
        ad.dispose();

        print('Ad load failed (code=${error.code} message=${error.message})');
      }, onAdClosed: (_) {
        _isLoaded = false;
      }),
    );
    _ad.load();
  }

  Future<void> checkIfAdsAreEnabled() async {
    _adsEnabled = await _areAdsEnabledUseCase();
    notifyListeners();
  }

  @override
  void dispose() {
    _ad.dispose();
    super.dispose();
  }
}
