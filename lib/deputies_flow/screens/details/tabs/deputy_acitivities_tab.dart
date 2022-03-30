import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/presentation/delegates/redirection_delegate.dart';
import 'package:project_athens/deputies_flow/navigation/deputies_destinations.dart';
import 'package:project_athens/deputies_utils/domain/subscribed_deputy_model.dart';
import 'package:provider/provider.dart';

class DeputyActivitiesTab extends StatelessWidget with RedirectionDelegate {
  final SubscribedDeputyModel _deputyModel;

  DeputyActivitiesTab(this._deputyModel);

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = Provider.of<AppLocalizations>(context);
    return Container(
        child: Container(
      child: Column(mainAxisSize: MainAxisSize.max, children: [
        AthensTile(
            title: l10n.getText().deputiesSpeeches(),
            goToFn: () => goToDestination(context, DeputySpeechesListDestination(_deputyModel))),
        AthensTile(
            title: l10n.getText().deputiesVotings(),
            goToFn: () => goToDestination(context, DeputyVotesListDestination(_deputyModel))),
      ]),
    ));
  }
}

class AthensTile extends StatelessWidget {
  final String title;
  final void Function() goToFn;

  static const double elevation = 2.0;

  AthensTile({required this.title, required this.goToFn});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
        padding: EdgeInsets.all(8),
        child: Material(
            child: Container(
              child: InkWell(
                  onTap: () => goToFn(),
                  child: ClipRRect(
                    child: Container(
                      color: Colors.white,
                      // decoration: BoxDecoration(
                      //     //     image: DecorationImage(
                      //     //   image: Image.asset("resources/images/parliament/parliament_gathering_512px.jpg").image,
                      //     //   fit: BoxFit.cover,
                      //     // )
                      //     ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                        child: Center(
                          child: ClipRRect(
                              child: Container(
                                  // width: double.infinity,
                                  // height: double.infinity,
                                  // color: Colors.black.withOpacity(0.7),
                                  child: Text(
                            title,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: Theme.of(context).primaryTextTheme.headlineSmall?.fontSize),
                          ))),
                        ),
                      ),
                    ),
                  )),
              decoration: BoxDecoration(border: Border.all(color: Colors.black.withOpacity(0.05))),
            ),
            elevation: elevation,
            shadowColor: Colors.black.withOpacity(0.3),
            color: Colors.white,
            borderOnForeground: true,
            type: MaterialType.card));
  }
}
