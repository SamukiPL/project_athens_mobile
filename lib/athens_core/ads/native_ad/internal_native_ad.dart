import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:project_athens/athens_core/presentation/base_blocs/base_change_notifier.dart';

class InternalNativeAd extends BaseChangeNotifier {
  late NativeAd _ad;

  NativeAd get ad => _ad;

  bool _isLoaded = false;

  bool get isLoaded => _isLoaded;

  InternalNativeAd(String factoryId) {
    _ad = NativeAd(
      adUnitId: NativeAd.testAdUnitId,
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

  @override
  void dispose() {
    _ad.dispose();
    super.dispose();
  }
}
