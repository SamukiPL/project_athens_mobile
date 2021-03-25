import 'package:flutter/cupertino.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/presentation/base_list/base_list.dart';
import 'package:project_athens/athens_core/presentation/base_list/base_list_bloc.dart';
import 'package:provider/provider.dart';

class DeputySpeechesDetailsTab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final localizations = Provider.of<AppLocalizations>(context);
    final baseListBloc = Provider.of<BaseListBloc>(context);

    return Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: BaseListWidget(listBloc: baseListBloc, noDataText: localizations.getText().speechesNoData()),
          )
        ]
    );
  }
}