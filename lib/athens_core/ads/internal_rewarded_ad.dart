import 'package:google_mobile_ads/google_mobile_ads.dart';

class InternalRewardedAd {
  final Function onRewardGranted;
  final Function adLoaded;
  final Function adFailed;
  final FullScreenContentCallback<RewardedAd>? fullScreenContentCallback;

  RewardedAd? _ad;

  bool get isLoaded => _ad != null;

  InternalRewardedAd({required this.onRewardGranted, required this.adLoaded, required this.adFailed, this.fullScreenContentCallback}) {
    loadNewAd();
  }

  void loadNewAd() {
    RewardedAd.load(
        adUnitId: RewardedAd.testAdUnitId,
        request: AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (ad) {
            _ad = ad;
            ad.fullScreenContentCallback = fullScreenContentCallback;
            adLoaded();
          },
          onAdFailedToLoad: (err) {
            adFailed();
          },
        ));
  }

  void showAd() {
    if (isLoaded) {
      _ad!.show(onUserEarnedReward: (_, reward) {
        onRewardGranted();
        _ad = null;
      });
    }
  }

  void dispose() {
    _ad?.dispose();
  }
}
