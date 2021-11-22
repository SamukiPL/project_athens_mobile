import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/presentation/base_screen.dart';
import 'package:project_athens/more_flow/screens/credits/credits_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class CreditsScreen extends BaseScreen<CreditsBloc> {

  @override
  bool get showBackArrow => true;

  @override
  bool get shouldShowBottomBar => false;

  String getAppBarTitle(AppLocalizations localizations, CreditsBloc bloc) {
    return localizations.getText().moreCredits();
  }

  @override
  Widget buildBody(BuildContext context, CreditsBloc bloc) {
    final ThemeData theme = Theme.of(context);
    
    return Container(
      child: Column(
        children: [
          _buildCreditRow(
            text: "Zdjęcie 74. posiedzenia sejmu wykorzystane w widoku posła z efektem rozmazania",
            link: "https://flickr.com/photos/141152160@N02/45372953405",
            theme: theme
          )
        ],
      )
    );
  }

  Widget _buildCreditRow({required String text, required String link, required ThemeData theme}) {
    return Container(
      padding: EdgeInsets.only(top: 16, bottom: 16, left: 8, right: 8),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1, color: theme.dividerColor.withOpacity(0.2))
        )
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 8),
            child: GestureDetector(
              onTap: () => launch(link),
              child: Text(
                link,
                style: TextStyle(
                  fontSize: 14,
                  color: theme.dividerColor
                )
              )
            )
          )
        ],
      )
    );
  }

  @override
  Widget? buildFloatingActionButton(BuildContext context, CreditsBloc bloc) {
    return null;
  }
}