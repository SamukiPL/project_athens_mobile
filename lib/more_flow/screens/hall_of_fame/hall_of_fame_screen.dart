import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/presentation/base_screen.dart';
import 'package:project_athens/more_flow/domain/more/backer_model.dart';
import 'package:project_athens/more_flow/screens/hall_of_fame/hall_of_fame_bloc.dart';
import 'package:provider/provider.dart';

class HallOfFameScreen extends BaseScreen<HallOfFameBloc> {

  @override
  bool get showBackArrow => true;

  @override
  bool get shouldShowBottomBar => false;

  String getAppBarTitle(AppLocalizations localizations, HallOfFameBloc bloc) {
    return localizations.getText().settingsHallOfFameTitle();
  }

  @override
  Widget buildBody(BuildContext context, HallOfFameBloc bloc) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureProvider(
            create: (context) => bloc.backersCache.hasUserBacked,
            child: Consumer<bool>(
              builder: (context, isBacker, _) => isBacker != null && isBacker ? _buildBackerCard() : Container(),
            ),
          ),
          FutureProvider(
            create: (context) => bloc.backersCache.backers,
            child: Consumer<Result<List<BackerModel>>>(
              builder: (context, backers, _) {
                if (backers != null && backers is Success<List<BackerModel>>) {
                  return
                    Expanded(child: _buildBackers(backers.value, theme)
                    );
                } else {
                  return Container();
                }
              }
            )
          )
        ],
      ),
    );
  }

  Widget _buildDecorativeCard(String title, Widget child) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        color: Colors.black.withAlpha(5)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 12),
            child: Text(
              title,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 26
              ),
            )
          ),
          child
        ],
      ),
    );
  }

  Widget _buildBackerCard() {
    return _buildDecorativeCard(
      "Dziękujemy za wsparcie ❤",
      Column(
        children: [
          Text("Aplikacja nie powstałaby bez Twojego wkładu, jesteśmy Ci niezmiernie wdzięczni za okazane zaufanie oraz pomoc w realizacji naszej apki.")
        ],
      )
    );
  }

  Widget _buildBackerItem(BackerModel backer, ThemeData theme) {
    return Container(
      margin: EdgeInsets.only(top: 8, bottom: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child:
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: backer.nickname,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        )
                      ),
                      WidgetSpan(
                        child: backer.hasBadge
                          ? Icon(
                          MdiIcons.license,
                          color: Colors.black45,
                          size: 18,
                          )
                          : Container()
                      ),
                      WidgetSpan(child:
                        Container(
                          width: 8,
                        ),
                      ),
                      TextSpan(
                          text: backer.comment,
                          style: TextStyle(
                            color: Colors.black45,
                            fontSize: 14,
                            fontWeight: FontWeight.w300
                          )
                      ),
                    ]
                  ),
                )
              ),
            ],
          ),
        ],
      )
    );
  }

  Widget _buildBackers(List<BackerModel> backers, ThemeData theme) {
    backers.sort((a,b) => b.amount.compareTo(a.amount));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 12),
          child: Text(
            "Wsparli nas",
            style: TextStyle(
              color: Colors.black87,
              fontSize: 28
            )
          ),
        ),
        Expanded(child: 
          ListView.builder(
            itemBuilder: (context, idx) => _buildBackerItem(backers[idx], theme),
            itemCount: backers.length
          )
        )
      ]
    );
  }

  @override
  Widget buildFloatingActionButton(BuildContext context, HallOfFameBloc bloc) {
    return null;
  }
}