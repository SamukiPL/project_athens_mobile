import 'package:flutter/src/widgets/framework.dart';
import 'package:nested/nested.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/deputies_chooser/list/deputy_item_view_model.dart';
import 'package:project_athens/deputies_flow/screens/details/deputy_details_bloc.dart';
import 'package:project_athens/deputies_flow/screens/vote_accuracy/deputy_vote_accuracy_bloc.dart';
import 'package:project_athens/deputies_utils/domain/deputy_model.dart';
import 'package:project_athens/deputies_utils/domain/subscribed_deputy_model.dart';
import 'package:provider/provider.dart';

class DeputyVoteAccuracyModule extends Module {

  final SubscribedDeputyModel _deputyModel;

  DeputyVoteAccuracyModule(BuildContext context, this._deputyModel) : super(context);

  @override
  List<SingleChildWidget> getProviders() {
    return [
      Provider<DeputyVoteAccuracyBloc>(
        create: (context) => DeputyVoteAccuracyBloc(),
        dispose: (context, bloc) => bloc.dispose(),
      )
    ];
  }

}