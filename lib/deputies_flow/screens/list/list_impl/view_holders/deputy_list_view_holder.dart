import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/deputies_flow/screens/list/list_impl/deputy_list_item_view_model.dart';
import 'package:provider/provider.dart';

class DeputyListViewHolder extends StatelessWidget {
  final DeputyListItemViewModel viewModel;

  const DeputyListViewHolder({Key key, @required this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<DeputyListItemViewModel>(
        builder: (context, viewModel, _) => InkWell(
          onTap: viewModel.itemClick,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
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
    final theme = Theme.of(context);
    return Hero(
      tag: viewModel.model.id,
      child: Container(
        height: 50,
        width: 50,
        child: ClipOval(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Stack(
              children: [
                Positioned.fill(child: Icon(Icons.person, size: 45, color: theme.dividerColor,)),
                Image.network(
                  viewModel.model.thumbnailUrl,
                  width: 50,
                  fit: BoxFit.fitWidth,
                ),
              ],
            ),
          ),
        ),
      ),
    );;
  }

  Widget getNameAndClub(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(left: 8, top: 4, bottom: 4),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
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
}
