import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/models/db_harvest_model.dart';
import 'package:provider/provider.dart';

class DbSource extends StatelessWidget {
  final DbHarvestModel _harvestModel;

  DbSource(this._harvestModel);

  @override
  Widget build(BuildContext context) {
    final localizations = Provider.of<AppLocalizations>(context);

    return Container(

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(localizations.getText().universalSource() + ': ' + this._harvestModel.source),
          Text(localizations.getText().universalCreatedAt() + ': ' + DateFormat("HH:mm dd.MM.y", "pl").format(_harvestModel.createAt ?? DateTime.now())),
          Text(localizations.getText().universalUpdatedAt() + ': ' + DateFormat("HH:mm dd.MM.y", "pl").format(_harvestModel.updateAt ?? DateTime.now()))
        ],
      )
    );
  }
}