import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/navigation/bottom_navigation_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:project_athens/main/presentation/main_widget.dart';
import 'package:provider/provider.dart';

class BottomNavigationWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = Provider.of<AppLocalizations>(context);

    return Consumer<BottomNavigationBloc>(
      builder: (context, bloc, _) => BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: bloc.currentItem.index,
        onTap: (item) {
          bloc.pickItem(item);
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.timeline),
              label: localizations.getText().timelineTimelineNavTitle()
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: localizations.getText().deputiesDeputiesListTitle()
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.record_voice_over),
              label: localizations.getText().speechesSpeechesListTitle()
          ),
          BottomNavigationBarItem(
              icon: Icon(MdiIcons.vote),
              label: localizations.getText().votingsVotingListTitle()
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: localizations.getText().settingsSettingsTitle()
          ),
        ],
      ),
    );
  }

  void refreshMainWidget(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => MainWidget()
      ),
      (Route<dynamic> route) => false
    );
  }

}