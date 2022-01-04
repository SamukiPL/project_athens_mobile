import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:project_athens/athens_core/ads/ads_ids.dart';

class InternalInterstitialAd {

  final Function dismissedCallback;

  InterstitialAd? _ad;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  InternalInterstitialAd({required this.dismissedCallback}) {
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

  void showAd() {
    if (_isLoaded) {
      _ad!.show();
    } else {
      dismissedCallback();
    }
  }

}