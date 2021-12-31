import 'package:google_mobile_ads/google_mobile_ads.dart';

class InternalInterstitialAd {

  final Function dismissedCallback;

  InterstitialAd? _ad;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  InternalInterstitialAd({required this.dismissedCallback}) {
    InterstitialAd.load(
        adUnitId: InterstitialAd.testAdUnitId,
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