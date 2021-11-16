import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:project_athens/athens_core/presentation/base_blocs/base_change_notifier.dart';

class NativeAdBloc extends BaseChangeNotifier {

  final String adFactoryId;

  late NativeAd _ad;
  NativeAd get ad => _ad;

  late Key _key;
  Key get key => _key;

  bool _isLoaded = false;
  bool _isVisible = false;
  bool get isVisible => _isVisible;

  int _adIndex = 5;
  int get adIndex => _adIndex;

  bool get shouldBuildWidget => _isLoaded && !_isVisible;

  NativeAdBloc({required this.adFactoryId}) {
    _ad = NativeAd(
      adUnitId: NativeAd.testAdUnitId,
      factoryId: adFactoryId,
      request: AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (_) {
          _isLoaded = true;
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();

          print('Ad load failed (code=${error.code} message=${error.message})');
        },
        onAdClosed: (_) {
          _isLoaded = false;
        }
      ),
    );
    _ad.load();
    _key = Key(adFactoryId);
  }

  void visibilityChanged(bool isVisible) {
    _isVisible = isVisible;
  }

  void changeAdIndex(int index) {
    _adIndex = index;
  }

  @override
  void dispose() {
    _ad.dispose();
    super.dispose();
  }
}
