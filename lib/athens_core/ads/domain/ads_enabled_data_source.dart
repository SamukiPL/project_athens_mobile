

abstract class AdsEnabledDataSource {
  Future<bool> areAdsEnabled();
  Future<void> disableAds({Duration addToToday = const Duration(days: 1)});
}
