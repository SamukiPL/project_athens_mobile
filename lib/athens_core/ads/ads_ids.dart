import 'dart:io';

class AdsIds {
  static final String _interstitialAdAndroid = "ca-app-pub-6413711847127285/3833003493";
  static final String _nativeAdAndroid = "ca-app-pub-6413711847127285/4954513474";
  static final String _rewardedAdAndroid = "TODO ANDROID AD";

  static final String _interstitialAdIos = "ca-app-pub-6413711847127285/8675617702";
  static final String _nativeAdIos = "ca-app-pub-6413711847127285/3810497359";
  static final String _rewardedAdIos = "TODO IOS AD";

  static String get interstitialAd => (Platform.isIOS) ? _interstitialAdIos : _interstitialAdAndroid;
  static String get nativeAd => (Platform.isIOS) ? _nativeAdIos : _nativeAdAndroid;
  static String get rewardedAd => (Platform.isIOS) ? _rewardedAdIos : _rewardedAdAndroid;
}
