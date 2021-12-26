import 'package:project_athens/athens_core/ads/domain/ad_model.dart';
import 'package:project_athens/athens_core/ads/native_ad/native_ads.dart';
import 'package:project_athens/athens_core/domain/base_list/base_model.dart';
import 'package:project_athens/athens_core/domain/base_list/base_params.dart';
import 'package:project_athens/athens_core/domain/base_list/list_facade.dart';
import 'package:project_athens/athens_core/domain/result.dart';

mixin AdsFacade on ListFacade<BaseListParams> {

  @override
  Stream<Result<List<BaseModel>>> getItems() {
    return super.getItems().map((event) {
      if (event.isSuccess()) {
        final mutableModelsList = event.toSuccess().value.toList(growable: true);
        final indexesToAdd = new List<int>.generate((event.toSuccess().value.length / 10).floor(), (index) => 5 + (10 * index));
        indexesToAdd.forEach((index) {
          mutableModelsList.insert(index, AdModel(NativeAds.speechAd));
        });
        return Success(mutableModelsList.toList(growable: false));
      }
      return event;
    }).cast();
  }
}