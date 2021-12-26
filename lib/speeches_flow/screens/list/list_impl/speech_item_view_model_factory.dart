import 'package:project_athens/athens_core/ads/domain/ad_model.dart';
import 'package:project_athens/athens_core/ads/native_ad/native_ad_provider.dart';
import 'package:project_athens/athens_core/ads/native_ad/native_ad_view_model.dart';
import 'package:project_athens/athens_core/domain/base_list/base_model.dart';
import 'package:project_athens/athens_core/models/speech_model.dart';
import 'package:project_athens/athens_core/presentation/base_item_view_model.dart';
import 'package:project_athens/athens_core/presentation/base_list/item_view_model_factory.dart';
import 'package:project_athens/speeches_flow/screens/list/list_impl/speech_item_view_model.dart';

class SpeechItemViewModelFactory extends ItemViewModelFactory {
  final NativeAdProvider? adProvider;

  SpeechItemViewModelFactory(this.adProvider);

  @override
  BaseItemViewModel? createWithoutError(BaseModel model) {
    if (model is SpeechModel) {
      return SpeechItemViewModel(model);
    } else if (model is AdModel) {
      return NativeAdViewModel(adProvider!.provide());
    }

    return null;
  }
}
