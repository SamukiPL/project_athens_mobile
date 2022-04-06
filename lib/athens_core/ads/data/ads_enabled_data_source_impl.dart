import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project_athens/athens_core/ads/domain/ads_enabled_data_source.dart';

class AdsEnabledDataSourceImpl extends AdsEnabledDataSource {
  static const _dateStorageKey = "DISABLED_DATE_KEY";
  
  FlutterSecureStorage storage = FlutterSecureStorage();

  @override
  Future<bool> areAdsEnabled() async {
    try {
      final savedDateString = await storage.read(key: _dateStorageKey) ?? "2012-02-27";
      final savedDate = DateTime.parse(savedDateString);
      return DateTime.now().compareTo(savedDate) >= 0;
    } catch (e) {
      Fimber.e(e.toString());
      return true;
    }
  }

  @override
  Future<void> disableAds({Duration addToToday = const Duration(days: 1)}) async {
    final disabledTo = DateTime.now().add(addToToday);
    storage.write(key: _dateStorageKey, value: disabledTo.toIso8601String());
  }

}
