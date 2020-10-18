import 'package:project_athens/athens_core/domain/data_mapper.dart';
import 'package:project_athens/deputies_flow/screens/list/list_impl/deputy_list_item_view_model.dart';
import 'package:project_athens/deputies_utils/domain/deputy_model.dart';

class DeputyItemViewModelFactory extends DataMapper<DeputyModel, DeputyListItemViewModel> {
  @override
  DeputyListItemViewModel transform(DeputyModel data) {
      var item = DeputyListItemViewModel(model: data);
      return item;
  }

}
