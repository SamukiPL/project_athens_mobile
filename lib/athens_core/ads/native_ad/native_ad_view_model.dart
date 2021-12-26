import 'package:flutter/src/widgets/framework.dart';
import 'package:project_athens/athens_core/ads/native_ad/internal_native_ad.dart';
import 'package:project_athens/athens_core/ads/native_ad/native_ad_widget.dart';
import 'package:project_athens/athens_core/presentation/base_item_view_model.dart';

class NativeAdViewModel extends BaseItemViewModel {
  final InternalNativeAd _internalAd;

  NativeAdViewModel(this._internalAd);

  InternalNativeAd get internalAd => _internalAd;

  @override
  Widget buildWidget(int index, int length) {
    return NativeAdWidget(
      viewModel: this,
    );
  }

  @override
  void dispose() {
    _internalAd.dispose();
    super.dispose();
  }
}
