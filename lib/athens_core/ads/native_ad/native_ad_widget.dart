import 'package:flutter/cupertino.dart';
import 'package:project_athens/athens_core/ads/native_ad/internal_native_ad.dart';
import 'package:project_athens/athens_core/ads/native_ad/native_ad_provider.dart';
import 'package:project_athens/athens_core/ads/native_ad/native_ad_view_model.dart';
import 'package:project_athens/athens_core/ads/native_ad/native_ads.dart';
import 'package:provider/provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class NativeAdWidget extends StatelessWidget {
  final NativeAdViewModel viewModel;

  const NativeAdWidget({Key? key, required this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final adProvider = Provider.of<NativeAdProvider>(context);
    return ChangeNotifierProvider<InternalNativeAd>.value(
      value: adProvider.provide(),
      child: Consumer<InternalNativeAd>(
        builder: (context, internalAd, _) {
          return internalAd.isLoaded ? _buildAd(adProvider, internalAd) : Container();
        },
      ),
    );
  }

  double _getAdHeight(String factoryId) {
    if (factoryId == NativeAds.deputyAd) {
      return NativeAds.deputyAdHeight;
    }
    return NativeAds.defaultHeight;
  }

  Widget _buildAd(NativeAdProvider adProvider, InternalNativeAd internalAd) {
    viewModel.adLoaded();
    return Container(
      child: AdWidget(ad: internalAd.ad),
      height: _getAdHeight(adProvider.factoryId),
    );
  }
}
