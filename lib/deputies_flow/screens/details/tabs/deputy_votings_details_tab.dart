import 'package:flutter/cupertino.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/presentation/base_list/base_list.dart';
import 'package:project_athens/athens_core/presentation/base_list/base_list_bloc.dart';
import 'package:project_athens/deputies_flow/screens/details/tabs/deputy_votings_details_tab_bloc.dart';
import 'package:project_athens/deputies_utils/data/network/response/deputy_response.dart';
import 'package:provider/provider.dart';

class DeputyVotingsDetailsTab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final localizations = Provider.of<AppLocalizations>(context);
    final baseListBloc = Provider.of<BaseListBloc>(context);

    return Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: BaseListWidget(listBloc: baseListBloc, noDataText: localizations.getText().votingsNoData(),),
          )
        ]
    );
  }
}