import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:project_athens/athens_core/models/timeline_model.dart';
import 'package:project_athens/athens_core/navigation/bottom_navigation_bloc.dart';
import 'package:project_athens/athens_core/navigation/destination_manager.dart';
import 'package:project_athens/athens_core/presentation/base_screen.dart';
import 'package:project_athens/speeches_flow/navigation/speeches_destination_manager.dart';
import 'package:project_athens/speeches_flow/screens/list/list_impl/speeches_list.dart';
import 'package:project_athens/speeches_flow/screens/list/speeches_list_bloc.dart';
import 'package:provider/provider.dart';

class SpeechesListScreen extends BaseScreen<SpeechesListBloc> {
  @override
  String get appBarTitle => "Speeches";
  @override
  bool get showBackArrow => false;

  @override
  BottomNavItem get currentBottomBarItem => BottomNavItem.SPEECHES;

  @override
  Widget buildBody(BuildContext context, SpeechesListBloc bloc) {
    SpeechesDestinationManager speechesDestinationManager = Provider.of<DestinationManager>(context);
    return StreamProvider<SpeechModel>.value(
      value: bloc.goToDetails,
      updateShouldNotify: (_, model) => goToDetails(context, model, speechesDestinationManager),
      child: Consumer<SpeechModel>(
        builder: (BuildContext context, SpeechModel value, Widget child) => child,
        child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Container(
                  height: 0,
                  child: SpeechesList(bloc.adapter),
                ),
              )
            ]
        ),
      ),
    );
  }

  @override
  Widget buildFloatingActionButton(BuildContext context, SpeechesListBloc bloc) => null;

  bool goToDetails(BuildContext context, SpeechModel model, SpeechesDestinationManager destinationManager) {
    destinationManager.goToSpeechDetails(context, model);
    return false;
  }

}