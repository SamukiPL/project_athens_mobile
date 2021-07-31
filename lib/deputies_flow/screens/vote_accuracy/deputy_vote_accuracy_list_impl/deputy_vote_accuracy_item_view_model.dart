import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:project_athens/athens_core/models/voting_model.dart';
import 'package:project_athens/athens_core/presentation/base_item_view_model.dart';
import 'package:project_athens/voting_flow/screens/list/list_impl/view_holders/vote_view_holder.dart';

class VoteItemViewModel extends BaseItemViewModel {

  final VotingModel model;

  String get id => model.id;
  String get title => model.title;
  String get date => DateFormat("d.MM.y", "pl").format(model.date);
  VoteResultModel get results => model.results;
  String get description => model.votingDesc;

  VoteItemViewModel(this.model);

  @override
  Widget buildWidget(int index, int length) => VoteViewHolder(this);

}