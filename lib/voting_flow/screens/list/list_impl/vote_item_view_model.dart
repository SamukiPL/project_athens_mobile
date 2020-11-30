import 'package:project_athens/athens_core/models/voting_model.dart';
import 'package:project_athens/athens_core/presentation/base_item_view_model.dart';

class VoteItemViewModel extends BaseItemViewModel {

  final String id;
  final String title;
  final String date;
  final VoteResultModel results;
  final String description;

  VoteItemViewModel(this.id, this.title, this.date, this.results, this.description);

}