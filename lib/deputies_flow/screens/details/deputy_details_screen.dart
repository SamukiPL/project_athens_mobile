import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/navigation/bottom_navigation_bloc.dart';
import 'package:project_athens/athens_core/presentation/base_screen.dart';
import 'package:project_athens/deputies_flow/screens/details/deputy_details_bloc.dart';
import 'package:project_athens/deputies_utils/domain/deputy_model.dart';

class DeputyDetailsScreen extends BaseScreen<DeputyDetailsBloc> {

  final DeputyModel _deputyModel;

  DeputyDetailsScreen(this._deputyModel);

  @override
  String get appBarTitle => _deputyModel.name;

  @override
  BottomNavItem get currentBottomBarItem => BottomNavItem.DEPUTIES;

  @override
  Widget buildBody(BuildContext context, DeputyDetailsBloc bloc) {
    return Column(
      children: [
        Hero(
            tag: _deputyModel.id,
            child: Image.network(_deputyModel.thumbnailUrl)
        ),
      ],
    );
  }

  @override
  Widget buildFloatingActionButton(
      BuildContext context, DeputyDetailsBloc bloc) => null;
}
