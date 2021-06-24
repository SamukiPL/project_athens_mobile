import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/navigation/bottom_navigation_bloc.dart';
import 'package:project_athens/athens_core/presentation/delegates/redirection_delegate.dart';
import 'package:project_athens/athens_core/presentation/technical_data/technical_data.dart';
import 'package:project_athens/deputies_flow/navigation/deputies_destinations.dart';
import 'package:project_athens/deputies_flow/screens/list/list_impl/deputy_list_item_view_model.dart';
import 'package:provider/provider.dart';

class DeputyListViewHolder extends StatelessWidget with RedirectionDelegate {
  final DeputyListItemViewModel viewModel;

  const DeputyListViewHolder({Key key, @required this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<DeputyListItemViewModel>(
        builder: (context, viewModel, _) => Card(
          elevation: 4,
          margin: EdgeInsets.all(8),
          child: InkWell(
            onTap: () {
              goToDestination(context, DeputyDetailsDestination(viewModel.model));
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                getDeputyFace(context),
                getNameAndClub(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getDeputyFace(BuildContext context) {
    return Container(
      height: 68,
      width: 55,
      child: Stack(children: <Widget>[
        Center(child: Icon(Icons.photo)),
        Hero(
          tag: viewModel.model.id,
          child: Image.network(viewModel.model.thumbnailUrl)
        ),
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
                  color: Colors.black87,
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
            ),
            TechnicalData(technicalId: viewModel.model.id)
          ],
        ),
      ),
    );
  }
}
