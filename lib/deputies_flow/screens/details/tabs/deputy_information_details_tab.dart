import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/presentation/full_card/full_card.dart';
import 'package:project_athens/athens_core/presentation/simple_horizontal_table/simple_horizontal_table.dart';
import 'package:project_athens/athens_core/presentation/technical_data/technical_data.dart';
import 'package:project_athens/deputies_flow/screens/details/tabs/deputy_information_details_tab_bloc.dart';
import 'package:project_athens/deputies_utils/domain/deputy_full.dart';
import 'package:provider/provider.dart';

class DeputyInformationDetailsTab extends StatelessWidget {
  final DeputyInformationDetailsTabBloc bloc;

  DeputyInformationDetailsTab(this.bloc);

  Widget buildCardHeader(String text, ThemeData theme, double fontSize) {
    fontSize = fontSize != null ? fontSize : 21;

    return Container(
          // padding: EdgeInsets.only(top: 5, bottom: 5, left: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(text,
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.w200,
                    color: theme.dividerColor
                ),
              ),
              // Container(
              //   padding: EdgeInsets.only(left: 5),
              //   width: 50,
              //   height: 2,
              //   decoration: BoxDecoration(
              //       color: theme.dividerColor
              //   ),
              // )
            ],
          )
        );

  }

  Widget buildBriefInfoTable(AppLocalizations localizations) {
    return Column(
      children: [
        SimpleHorizontalTable(cells: bloc.getBriefInfoTableCells(localizations)),
        TechnicalData(technicalId: bloc.getDeputyId())
      ],
    );
  }

  Widget buildHorizontalTable(String leftText, String rightText, ThemeData theme) {
    return Container(
      padding: EdgeInsets.only(top: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              leftText,
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: theme.dividerColor.withOpacity(0.8),
                  fontWeight: FontWeight.w300
              ),
            ),
          ),
          Expanded(
              flex: 7,
              child: Container(
                  padding: EdgeInsets.only(left: 15),
                  child: Text(
                    rightText,
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 15
                    ),
                  )
              )
          )
        ],
      ),
    );


  }

  Widget buildDetailedInfoBlock(AppLocalizations localizations, ThemeData theme) {
    final cv = bloc.getDeputyCV();

    final finishedSchools = cv.finishedSchools.trim();
    final experience = cv.parliamentExperience.trim();
    // final parliamentExperience = bloc.getParliamentExperience();

    return
      Column(
        children: [
          buildHorizontalTable(localizations.getText().deputiesFinishedSchools(), finishedSchools, theme),
          buildHorizontalTable(localizations.getText().deputiesParliamentExperience(), experience, theme)
        ]
    );
  }

  Widget buildVoteAccuracyTableRow(ClubVoteAccuracy voteAccuracy, int overallHighestAccuracy, ThemeData theme) {
    final double barWidth = voteAccuracy.compatibleVotes / overallHighestAccuracy;

    final accuracyPercentage = (barWidth * 100).toStringAsFixed(1) + '%';

    return Container(
      padding: EdgeInsets.only(top: 5, left: 5, right: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(right: 5),
            alignment: Alignment.center,
            width: 50,
            height: 50,
            child: CachedNetworkImage(
              imageUrl: voteAccuracy?.parliamentClub?.imageSrc,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Center(child: Text(voteAccuracy?.parliamentClub?.shortName),),
              width: 40,
              height: 40,
              memCacheHeight: 700,
              memCacheWidth: 700,
              alignment: Alignment.center,
              // )
            ),
          ),
          // Expanded(
          //     flex: 3,
          //     child:

          Expanded(
              // flex: 7,
              child: FractionallySizedBox(
                alignment: Alignment.topLeft,
                widthFactor: barWidth,
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: theme.primaryColor,
                  ),
                  child: Center(
                    child: Text(accuracyPercentage, style: TextStyle(color: Colors.white),),
                  ),
                ),
              )
          ),
        ],
      )
    );

  }

  Widget buildVoteAccuracyTable(List<ClubVoteAccuracy> voteAccuracy, AppLocalizations localizations, ThemeData theme) {
    final int highestOverallAccuracy = voteAccuracy[0]?.compatibleVotes;

    return Container(
      child: Column(
        children: voteAccuracy.map((e) => buildVoteAccuracyTableRow(e, highestOverallAccuracy, theme)).toList(),
      ),
    );
  }

  Widget buildStatisticsBlock(AppLocalizations localizations, ThemeData theme) {
    final stats = bloc.getStatistics();

    final voteAccuracy = stats.clubVoteAccuracy;
    voteAccuracy.sort((a,b) => a.compatibleVotes > b.compatibleVotes ? -1 : 1);

    final cells = bloc.getStatisticsHorizontalTableCells(localizations);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // buildCardHeader('Statystyki', theme, 21),
        SimpleHorizontalTable(cells: cells),
        buildCardHeader('Zgodność głosowania', theme, 15),
        buildVoteAccuracyTable(voteAccuracy, localizations, theme)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = Provider.of<AppLocalizations>(context);
    final theme = Theme.of(context);

    return Container(
      child: Column(
        children: [
          FullCard(
            child: buildBriefInfoTable(localizations),
            rightPadding: 10,
            leftPadding: 10,
            header: 'Podstawowe informacje',
          ),
          FullCard(
            rightPadding: 10,
            leftPadding: 10,
            child: buildDetailedInfoBlock(localizations, theme),
            header: 'Doświadczenie',
          ),
          FullCard(
            rightPadding: 10,
            leftPadding: 10,
            child: buildStatisticsBlock(localizations, theme),
            header: 'Statystyki'
          )
        ]
      ),
    );
  }
}