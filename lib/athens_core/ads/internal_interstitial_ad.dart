import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:project_athens/athens_core/ads/ads_ids.dart';
import 'package:project_athens/athens_core/ads/domain/are_ads_enabled_use_case.dart';

class InternalInterstitialAd {

  final Function dismissedCallback;
  final AreAdsEnabledUseCase areAdsEnabledUseCase;

  InterstitialAd? _ad;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  InternalInterstitialAd({required this.dismissedCallback, required this.areAdsEnabledUseCase}) {
    InterstitialAd.load(
        adUnitId: AdsIds.interstitialAd,
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            this._ad = ad;

            ad.fullScreenContentCallback = FullScreenContentCallback(
              onAdDismissedFullScreenContent: (ad) {
                dismissedCallback();
              },
            );

            _isLoaded = true;
          },
          onAdFailedToLoad: (err) {
            print('Failed to load an interstitial ad: ${err.message}');
            _isLoaded = false;
          },
        ),
    );
  }

  Future<void> showAd() async {
    if (_isLoaded && await areAdsEnabledUseCase()) {
      _ad!.show();
    } else {
      dismissedCallback();
    }
  }

  void dispose() {
    _ad?.dispose();
  }

}
