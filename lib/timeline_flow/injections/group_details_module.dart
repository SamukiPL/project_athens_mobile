import 'package:flutter/src/widgets/framework.dart';
import 'package:nested/nested.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/athens_core/models/timeline_model.dart';
import 'package:project_athens/athens_core/models/voting_model.dart';
import 'package:project_athens/timeline_flow/screens/group_details/group_details_bloc.dart';
import 'package:provider/provider.dart';

class GroupDetailsModule extends Module {
  final GroupedVotingModel _groupedModel;

  GroupDetailsModule(BuildContext context, this._groupedModel) : super(context);

  @override
  List<SingleChildWidget> getProviders() => [
        Provider<GroupDetailsBloc>(
          create: (_) => GroupDetailsBloc(_groupedModel),
          dispose: (_, bloc) => bloc.dispose(),
        )
      ];
}
