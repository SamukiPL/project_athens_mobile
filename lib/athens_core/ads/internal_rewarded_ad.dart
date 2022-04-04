import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:project_athens/athens_core/ads/ads_ids.dart';

class InternalRewardedAd {
  final Function onRewardGranted;
  final Function adLoaded;
  final Function adFailed;
  final FullScreenContentCallback<RewardedAd>? fullScreenContentCallback;

  RewardedAd? _ad;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  InternalRewardedAd({required this.onRewardGranted, required this.adLoaded, required this.adFailed, this.fullScreenContentCallback}) {
    loadNewAd();
  }

  void loadNewAd() {
    _isLoaded = false;
    RewardedAd.load(
        adUnitId: AdsIds.rewardedAd,
        request: AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (ad) {
            _isLoaded = true;
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
        _ad?.dispose();
        _ad = null;
      });
    }
  }

  void dispose() {
    _ad?.dispose();
  }
}
