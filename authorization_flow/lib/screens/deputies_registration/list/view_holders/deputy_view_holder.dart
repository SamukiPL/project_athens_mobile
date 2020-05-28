import 'package:authorization_flow/screens/deputies_registration/list/deputy_item_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class DeputyViewHolder extends StatelessWidget {
  final DeputyItemViewModel viewModel;

  const DeputyViewHolder({Key key, @required this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<DeputyItemViewModel>(
        builder: (context, viewModel, _) => GestureDetector(
          onTap: () {
            viewModel.setChecked(!viewModel.checked);
          },
          child: Card(
            elevation: 4,
            margin: EdgeInsets.all(8),
            child: IntrinsicHeight(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  getCheckIcon(context),
                  getDeputyFace(context),
                  getNameAndClub(context),
                  getVotingType(context),
                  getSpeechType(context),
                  getFile(context)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getCheckIcon(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 4, right: 4),
      child: (viewModel.checked)
          ? Icon(
              Icons.check_circle,
              color: Theme.of(context).primaryColor,
        size: 32,
            )
          : Icon(
              Icons.check_circle_outline,
              color: Theme.of(context).dividerColor,
        size: 32,
            ),
    );
  }

  Widget getDeputyFace(BuildContext context) {
    return Container(
      height: 68,
      width: 55,
      child: Stack(children: <Widget>[
        Center(child: Icon(Icons.photo)),
        Image.network(viewModel.model.thumbnailUrl),
      ]),
    );
  }

  Widget getNameAndClub(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(left: 8, top: 4, right: 8),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Text(
                viewModel.model.name,
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 18,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child: Text(
                viewModel.model.club,
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Theme.of(context).dividerColor,
                  fontSize: 12,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getVotingType(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 4),
      child: Icon(
        MdiIcons.vote,
        color: Theme.of(context).dividerColor,
      ),
    );
  }

  Widget getSpeechType(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 4),
      child: Icon(
        Icons.record_voice_over,
        color: Theme.of(context).dividerColor,
      ),
    );
  }

  Widget getFile(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 4),
      child: Icon(
        Icons.insert_drive_file,
        color: Theme.of(context).dividerColor,
      ),
    );
  }
}
