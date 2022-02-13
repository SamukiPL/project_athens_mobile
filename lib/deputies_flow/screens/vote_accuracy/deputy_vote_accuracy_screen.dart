import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/presentation/base_list/base_list.dart';
import 'package:project_athens/athens_core/presentation/base_list/base_list_bloc.dart';
import 'package:project_athens/athens_core/presentation/base_screen.dart';
import 'package:project_athens/deputies_flow/domain/vote_accuracy_alignment_enum.dart';
import 'package:provider/provider.dart';

class DeputyVoteAccuracyScreen extends BaseScreen<BaseListBloc> {
  final VoteAccuracyAlignment _alignment;

  DeputyVoteAccuracyScreen(this._alignment);

  @override
  Widget buildBody(BuildContext context, BaseListBloc bloc) {
    final localizations = Provider.of<AppLocalizations>(context);

    return Column(mainAxisSize: MainAxisSize.max, children: [
      Expanded(
        child: BaseListWidget(
          listBloc: bloc,
          noDataText: localizations.getText().votingsNoData(),
          separator: Divider(
            height: 1,
          ),
        ),
      )
    ]);
  }

  @override
  Widget? buildFloatingActionButton(BuildContext context, BaseListBloc bloc) => null;

  @override
  String getAppBarTitle(AppLocalizations localizations, BaseListBloc bloc) {
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