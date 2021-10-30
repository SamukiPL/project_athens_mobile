import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/navigation/app_navigation.dart';
import 'package:project_athens/athens_core/navigation/destination_manager.dart';
import 'package:project_athens/athens_core/presentation/base_screen.dart';
import 'package:project_athens/athens_core/presentation/full_card/full_card.dart';
import 'package:project_athens/more_flow/navigation/more_navigation.dart';
import 'package:project_athens/more_flow/screens/more/more_bloc.dart';
import 'package:provider/provider.dart';

class MoreScreen extends BaseScreen<MoreBloc> {
  @override
  bool get showBackArrow => false;
  @override
  bool get shouldShowBottomBar => true;

  String getAppBarTitle(AppLocalizations localizations, MoreBloc bloc) {
    return localizations.getText().moreTitle();
  }

  @override
  Widget buildBody(BuildContext context, MoreBloc bloc) {
    final localization = Provider.of<AppLocalizations>(context);

    final linkTextStyle = TextStyle(
      color: Colors.black45,
      fontSize: 16,
      fontWeight: FontWeight.w300,
    );

    final theme = Theme.of(context);

    return Container(
      child: Column(
      children: [
          _buildActionRow(
            label: localization.getText().settingsButtonLogout(),
            onPressed: () => bloc.logout(),
            theme: theme,
          ),
          _buildActionRow(
            label: localization.getText().settingsHallOfFameTitle(),
            onPressed: () =>
                goToDestination(context, MoreHallOfFameScreenDestination()),
            theme: theme,
          ),
          _buildActionRow(
            label: localization.getText().moreGoToSettings(),
            onPressed: () =>
                goToDestination(context, MoreSettingsScreenDestination()),
            theme: theme,
          ),
          _buildActionRow(
              label: localization.getText().moreCredits(),
              onPressed: () =>
                goToDestination(context, MoreCreditsScreenDestination()),
              theme: theme
          ),
          _buildActionRow(
              label: localization.getText().moreCheckForUpdates(),
              onPressed: () => bloc.checkForUpdates(),
              theme: theme,
              drawBottomBorder: false,
              isNavigation: false,
              additionalChild: FutureProvider.value(
                value: bloc.getAppVersion(),
                initialData: null,
                child: Consumer<String?>(
                  builder: (context, version, _) {
                    if (version != null && version != '') {
                      return StreamProvider<bool>.value(
                        value: bloc.checkingForUpdateStream,
                        initialData: false,
                        child: Consumer<bool>(
                            builder: (context, isChecking, bloc) {
                              if (!isChecking) {
                                return Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.only(left: 16, top: 12),
                                    child: Text(
                                      localization.getText().moreAppVersion() +
                                          ": " +
                                          version,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          color: Colors.black45,
                                          fontSize: 10),
                                    ));
                              } else {
                                return Container(
                                  padding: EdgeInsets.only(left: 16, top: 12),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                          child: Text(
                                            localization.getText().moreAppVersion() +
                                                ": " +
                                                version,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w300,
                                                color: Colors.black45,
                                                fontSize: 10),
                                          )),
                                      Container(
                                          padding: EdgeInsets.only(left: 8),
                                          child: SizedBox(
                                            child: CircularProgressIndicator(
                                              strokeWidth: 1,
                                            ),
                                            height: 12,
                                            width: 12,
                                          )),
                                    ],
                                  )
                                );
                              }
                            }),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              )
          ),
        Expanded(child: Container()),
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Text(localization.getText().moreLikeApplication()),
          MaterialButton(
            splashColor: Color.fromRGBO(230, 65, 100, 0.4),
            focusColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () => bloc.goToCrowdFundingPage(),
            child: Text(
              localization.getText().moreSupportUs(),
              style: TextStyle(color: Color.fromRGBO(230, 65, 100, 1)),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
                side: BorderSide(color: Color.fromRGBO(230, 65, 100, 1))),
          )
        ]),
      ],
    ));
  }

  Widget _buildMoreSegment(String title, List<Widget> children) {
    return FullCard(
      header: title,
      headerPadding: 8,
      cardPadding: EdgeInsets.only(bottom: 0),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: children,
        )
      ),
    );
  }

  Widget _buildActionRow(
      {required String label,
      required void Function() onPressed,
      required ThemeData theme,
      bool drawBottomBorder = true,
      bool isNavigation = true,
      Widget? additionalChild
      }) {
    return GestureDetector(
      onTap: onPressed,
      child: InkWell(
        child: Container(
          padding: EdgeInsets.only(left: 8, right: 8, top: 16, bottom: 16),
          decoration: drawBottomBorder ? BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1, color: theme.dividerColor.withOpacity(0.2))
            )
          ) : BoxDecoration(),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                          color: theme.dividerColor,
                          fontSize: 20
                      ),
                    ),
                    isNavigation ? Icon(
                        Icons.chevron_right,
                        color: theme.dividerColor.withOpacity(0.4)
                    ) : Container()
                  ],
                ),
                additionalChild != null ? additionalChild : Container()
              ],
            ),
        )
      )
    );
  }

  @override
  Widget? buildFloatingActionButton(BuildContext context, MoreBloc bloc) {
    return null;
  }

  @override
  void onSuccess(BuildContext context) {
    var appNavigation = Provider.of<AppNavigation>(context, listen: false);
    appNavigation.goToLoginWidget(context);
  }
}
