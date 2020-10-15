import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/navigation/bottom_navigation_bloc.dart';
import 'package:project_athens/athens_core/navigation/destination_manager.dart';
import 'package:project_athens/athens_core/presentation/base_screen.dart';
import 'package:project_athens/deputies_flow/screens/details/deputy_details_bloc.dart';
import 'package:project_athens/deputies_utils/domain/deputy_model.dart';
import 'package:provider/provider.dart';

class DeputyDetailsScreen extends BaseScreen<DeputyDetailsBloc> {

  final DeputyModel _deputyModel;

  DeputyDetailsScreen(this._deputyModel);

  @override
  String get appBarTitle => _deputyModel.name;

  @override
  BottomNavItem get currentBottomBarItem => BottomNavItem.DEPUTIES;

  @override
  Widget buildBody(BuildContext context, DeputyDetailsBloc bloc) {
    final theme = Theme.of(context);
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          leading: Consumer<DestinationManager>(
              builder: (context, destinationManager, _) => BackButton(
                color: Colors.white,
                onPressed: () {
                  destinationManager.goBack();
                  Navigator.pop(context);
                },
              )
          ),
          expandedHeight: 250,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: Container(
              margin: EdgeInsets.only(left: 8, right: 8),
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  _deputyModel.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            background: Container(
              color: theme.primaryColor,
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(32),
                  child: Image.network(_deputyModel.thumbnailUrl)
                ),
              ),
            ),
          ),
        ),
        SliverFillRemaining()
      ],
    );
  }

  @override
  Widget buildFloatingActionButton(
      BuildContext context, DeputyDetailsBloc bloc) => null;

  @override
  Widget buildAppBar(BuildContext context, DeputyDetailsBloc bloc) => null;
}
