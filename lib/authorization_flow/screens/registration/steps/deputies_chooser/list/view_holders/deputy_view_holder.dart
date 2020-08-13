import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/deputies_chooser/list/deputy_item_view_model.dart';
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
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                getCheckIcon(context),
                getDeputyFace(context),
                getNameAndClub(context),
                getVotingType(context),
                getSpeechType(context),
                getInterpolationType(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getCheckIcon(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 4, right: 4),
      child: Icon(
        (viewModel.checked) ? Icons.check_circle : Icons.check_circle_outline,
        color: getCheckColor(context, viewModel.checked),
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
    final theme = Theme.of(context);
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(left: 8, top: 4, right: 8, bottom: 4),
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
                  color: theme.primaryColor,
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
                  color: theme.dividerColor,
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
    return getTypeIcon(
      context,
      () => viewModel.setVote(!viewModel.vote),
      MdiIcons.vote,
      viewModel.vote,
    );
  }

  Widget getSpeechType(BuildContext context) {
    return getTypeIcon(
      context,
      () => viewModel.setSpeech(!viewModel.speech),
      Icons.record_voice_over,
      viewModel.speech,
    );
  }

  Widget getInterpolationType(BuildContext context) {
    return getTypeIcon(
        context,
        () => viewModel.setInterpolation(!viewModel.interpolation),
        Icons.insert_drive_file,
        viewModel.interpolation);
  }

  Widget getTypeIcon(BuildContext context, Function tapFunction, IconData icon, bool checked) {
    return GestureDetector(
      onTap: tapFunction,
      child: Container(
        margin: EdgeInsets.only(right: 4),
        child: Icon(
          icon,
          color: getCheckColor(context, checked),
        ),
      ),
    );
  }

  Color getCheckColor(BuildContext context, bool checked) {
    final theme = Theme.of(context);
    return (checked)
        ? theme.primaryColor
        : theme.dividerColor;
  }
}
