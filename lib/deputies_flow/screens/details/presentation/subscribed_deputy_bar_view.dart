import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/deputies_utils/domain/subscribed_deputy_model.dart';
import 'package:provider/provider.dart';

class SubscribedDeputyBarView extends StatelessWidget {
  final SubscribedDeputyModel deputyModel;
  const SubscribedDeputyBarView(this.deputyModel);

  @override
  build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = Provider.of<AppLocalizations>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            child:
            GestureDetector(
                onTap: () => deputyModel.notifications.setIsSubscribed(false),
                child: Row(
                    children: [
                      Icon(MdiIcons.bookmarkCheckOutline, color: theme.primaryColor),
                      Text(
                        localizations.getText().deputiesSubscribingDeputy(),
                        style: TextStyle(
                            color: theme.dividerColor,
                            fontSize: 14
                        ),
                      ),
                    ]
                )
            )
        ),
        Row(
          children: [
            getSpeechType(context),
            getVotingType(context),
            getInterpolationType(context)
          ],
        ),
      ],
    );
  }

  Widget getVotingType(BuildContext context) {
    return getTypeIcon(
      context,
          () => deputyModel.notifications.setVote(!deputyModel.notifications.vote),
      MdiIcons.vote,
      deputyModel.notifications.vote,
    );
  }

  Widget getSpeechType(BuildContext context) {
    return getTypeIcon(
      context,
          () => deputyModel.notifications.setSpeech(!deputyModel.notifications.speech),
      Icons.record_voice_over,
      deputyModel.notifications.speech,
    );
  }

  Widget getInterpolationType(BuildContext context) {
    return getTypeIcon(
        context,
            () => deputyModel.notifications
            .setInterpolation(!deputyModel.notifications.interpolation),
        Icons.insert_drive_file,
        deputyModel.notifications.interpolation);
  }

  Widget getTypeIcon(
      BuildContext context, Function tapFunction, IconData icon, bool checked) {
    return GestureDetector(
      onTap: () => tapFunction(),
      child: Container(
        margin: EdgeInsets.only(right: 4),
        child: Icon(
          icon,
          color: getCheckColor(context, checked),
        ),
      ),
    );
  }

  Color getCheckColor(BuildContext context, bool checked) {
    final theme = Theme.of(context);
    return (checked) ? theme.primaryColor : theme.dividerColor;
  }
}