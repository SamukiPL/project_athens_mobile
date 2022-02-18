import 'package:project_athens/athens_core/ads/domain/ad_model.dart';
import 'package:project_athens/athens_core/domain/base_list/base_model.dart';
import 'package:project_athens/athens_core/domain/base_list/base_params.dart';
import 'package:project_athens/athens_core/domain/base_list/list_facade.dart';
import 'package:project_athens/athens_core/domain/result.dart';

mixin AdsFacade<T extends BaseParams> on ListFacade<T> {

  @override
  Stream<Result<List<BaseModel>>> getItems() {
    return super.getItems().map((event) {
      if (event.isSuccess()) {
        //To whom it may concern, it's just a dart thing
        final mutableModelsList = event.toSuccess().value.map((e) => e as BaseModel).toList(growable: true);
        final indexesToAdd = new List<int>.generate((event.toSuccess().value.length / 10).floor(), (index) => 5 + (10 * index));
        indexesToAdd.forEach((index) {
          mutableModelsList.insert(index, AdModel());
        });
        return Success(mutableModelsList.toList(growable: false));
      }
      return event;
    }).cast();
  }
}