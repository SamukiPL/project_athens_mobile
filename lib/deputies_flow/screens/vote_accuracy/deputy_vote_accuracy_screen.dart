import 'package:flutter/cupertino.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/presentation/base_screen.dart';
import 'package:project_athens/deputies_flow/domain/vote_accuracy_alignment_enum.dart';
import 'package:project_athens/deputies_flow/screens/vote_accuracy/deputy_vote_accuracy_bloc.dart';
import 'package:project_athens/deputies_utils/domain/deputy_full.dart';
import 'package:project_athens/deputies_utils/domain/deputy_model.dart';

class DeputyVoteAccuracyScreen extends BaseScreen<DeputyVoteAccuracyBloc> {
  final ClubVoteAccuracy _clubVoteAccuracy;
  final DeputyModel _deputy;
  final VoteAccuracyAlignment _alignment;

  DeputyVoteAccuracyScreen(this._clubVoteAccuracy, this._deputy, this._alignment);

  @override
  Widget buildBody(BuildContext context, DeputyVoteAccuracyBloc bloc) {
    return Container(child: Text('test'));
  }

  @override
  Widget buildFloatingActionButton(BuildContext context, DeputyVoteAccuracyBloc bloc) => null;

  @override
  String getAppBarTitle(AppLocalizations localizations, DeputyVoteAccuracyBloc bloc) {
    if (_alignment == VoteAccuracyAlignment.ALIGNED) {
      return localizations.getText().deputiesAlignedWithParty();
    } else {
      return localizations.getText().deputiesNotAlignedWithParty();
    }
  }

  @override
  bool get showBackArrow => true;

  @override
  bool get shouldShowBottomBar => false;
}