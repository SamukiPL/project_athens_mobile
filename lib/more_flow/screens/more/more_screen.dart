import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/navigation/app_navigation.dart';
import 'package:project_athens/athens_core/presentation/base_screen.dart';
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

    return Container(
        child: Column(
          children: [
            _buildMoreSegment(localization.getText().moreUser(), [
              MaterialButton(
                onPressed: () => bloc.logout(),
                child: Container(
                  width: double.infinity,
                  child: Text(
                    localization.getText().settingsButtonLogout(),
                    textAlign: TextAlign.left,
                    style: linkTextStyle,
                  ),
                )
              ),
              MaterialButton(
                onPressed: () => goToDestination(context, MoreHallOfFameScreenDestination()),
                child: Container(
                  width: double.infinity,
                  child: Text(
                  localization.getText().settingsHallOfFameTitle(),
                  textAlign: TextAlign.left,
                  style: linkTextStyle,
                  ),
                )
              )
            ]),
            _buildMoreSegment(localization.getText().settingsSettingsTitle(), [
              MaterialButton(
                onPressed: () => goToDestination(context, MoreSettingsScreenDestination()),
                child: Container(
                  width: double.infinity,
                  child: Text(
                  localization.getText().moreGoToSettings(),
                  textAlign: TextAlign.left,
                  style: linkTextStyle,
                  ),
                )
              ),
              Column(
                children: [
                  MaterialButton(
                      onPressed: () => bloc.checkForUpdates(),
                      child: Container(
                          width: double.infinity,
                          child: StreamProvider<bool>.value(
                            value: bloc.checkingForUpdateStream,
                            initialData: false,
                            child: Consumer<bool>(builder: (context, isChecking, bloc) {
                              if (!isChecking) {
                                return Text(
                                  localization.getText().moreCheckForUpdates(),
                                  textAlign: TextAlign.left,
                                  style: linkTextStyle,
                                );
                              } else {
                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      localization.getText().moreCheckForUpdates(),
                                      textAlign: TextAlign.left,
                                      style: linkTextStyle,
                                    ),
                                    Container(
                                        padding: EdgeInsets.only(left: 8),
                                        child: SizedBox(
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                          ),
                                          height: 18,
                                          width: 18,
                                        )
                                    ),
                                  ],
                                );
                              }
                            }),
                          )
                      )
                  ),
                  FutureProvider.value(
                    value: bloc.getAppVersion(),
                    initialData: '',
                    child: Consumer<String>(
                      builder: (context, version, _) {
                        if (version != null && version != '') {
                          return Container(
                            width: double.infinity,
                            padding: EdgeInsets.only(left: 36),
                            child: Text(
                              localization.getText().moreAppVersion() + ": " + version,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                color: Colors.black45,
                                fontSize: 10
                              ),
                            )
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  )
                ],
              )
            ]),
            Expanded(child: Container()),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(localization.getText().moreLikeApplication()),
                  MaterialButton(
                    splashColor: Color.fromRGBO(230, 65, 100, 0.4),
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () => bloc.goToCrowdFundingPage(),
                    child: Text(
                      localization.getText().moreSupportUs(),
                      style: TextStyle(
                          color: Color.fromRGBO(230, 65, 100, 1)
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                        side: BorderSide(color: Color.fromRGBO(230, 65, 100, 1))
                    ),

                  )
                ]
            ),

          ],
        ));
  }

  Widget _buildMoreSegment(String title, List<Widget> children) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              title,
              style: TextStyle(
                fontSize: 22,
                color: Colors.black87,
              ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: children,
          )
        ],
      ),
    );
  }

  @override
  Widget buildFloatingActionButton(BuildContext context, MoreBloc bloc) {
    return null;
  }

  @override
  void onSuccess(BuildContext context) {
    var appNavigation = Provider.of<AppNavigation>(context, listen: false);
    appNavigation.goToLoginWidget(context);
  }
}
