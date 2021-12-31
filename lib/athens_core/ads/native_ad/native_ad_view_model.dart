import 'package:flutter/src/widgets/framework.dart';
import 'package:project_athens/athens_core/ads/native_ad/native_ad_widget.dart';
import 'package:project_athens/athens_core/presentation/base_item_view_model.dart';

class NativeAdViewModel extends BaseItemViewModel {
  @override
  Widget buildWidget(int index, int length) {
    return NativeAdWidget(
      viewModel: this,
    );
  }
}
