
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scatter/flutter_scatter.dart';
import 'package:project_athens/athens_core/data/word_model/word_model.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/navigation/destination_manager.dart';
import 'package:project_athens/athens_core/presentation/async_once/async_once.dart';
import 'package:project_athens/athens_core/presentation/db_source/db_source.dart';
import 'package:project_athens/athens_core/presentation/full_card/full_card.dart';
import 'package:project_athens/athens_core/presentation/simple_horizontal_table/simple_horizontal_table.dart';
import 'package:project_athens/athens_core/presentation/technical_data/technical_data.dart';
import 'package:project_athens/deputies_flow/domain/details/get_full_deputy_use_case.dart';
import 'package:project_athens/deputies_flow/screens/details/presentation/deputy_vote_accuracy_table.dart';
import 'package:project_athens/deputies_flow/screens/details/tabs/deputy_information_extension.dart';
import 'package:project_athens/deputies_utils/cache/deputies_cache.dart';
import 'package:project_athens/deputies_utils/domain/deputy_full.dart';
import 'package:project_athens/deputies_utils/domain/deputy_model.dart';
import 'package:provider/provider.dart';

class DeputyInformationDetailsTab extends StatelessWidget {

  final void Function(BuildContext context, Destination destination) _navigationCallback;
  final DeputyModel _deputyModel;

  DeputyInformationDetailsTab(this._navigationCallback, this._deputyModel);

  @override
  Widget build(BuildContext context) {
    final localizations = Provider.of<AppLocalizations>(context);
    final theme = Theme.of(context);

    final asyncOnceUseCase = Provider.of<GetFullDeputyUseCase>(context);

    final DeputiesCache deputyCache = Provider.of<DeputiesCache>(context);

    return AsyncOnce<DeputyFull>(asyncOnceUseCase: asyncOnceUseCase, builder: (deputyFull) {
      return SingleChildScrollView(
        child: Container(
          color: Colors.grey.shade200,
          child: Column(
              children: [
                FullCard(
                  child: buildBriefInfoTable(localizations, deputyFull),
                  rightPadding: 10,
                  leftPadding: 10,
                  header: localizations.getText().deputiesBasicInfo(),
                ),
                FullCard(
                  rightPadding: 10,
                  leftPadding: 10,
                  child: buildDetailedInfoBlock(localizations, theme, deputyFull),
                  header: localizations.getText().deputiesExperience(),
                ),
                FullCard(
                    rightPadding: 10,
                    leftPadding: 10,
                    child: buildStatisticsBlock(localizations, theme, deputyFull),
                    header: localizations.getText().deputiesStatistics(),
                    dialogText: localizations.getText().deputiesStatisticsInfo(),
                ),
                FullCard(
                  rightPadding: 10,
                  leftPadding: 10,
                  child: buildNounCloud(localizations, theme, deputyFull, deputyCache, context),
                  header: localizations.getText().deputiesWordCloud(),
                  dialogText: localizations.getText().deputiesWordCloudInfo(),
                ),
                FullCard(
                  rightPadding: 10,
                  leftPadding: 10,
                  child: DbSource(deputyFull),
                )
              ]
          ),
        ),
      );
    });
  }

  Widget buildBriefInfoTable(AppLocalizations localizations, DeputyFull deputyFull) {
    return Column(
      children: [
        SimpleHorizontalTable(cells: deputyFull.getBriefInfoTableCells(localizations)),
        TechnicalData(technicalId: deputyFull.getDeputyId())
      ],
    );
  }

  Widget buildCardHeader(String text, ThemeData theme, double fontSize) {
    fontSize = fontSize != null ? fontSize : 21;

    return Container(
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
            ],
          )
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

  Widget buildDetailedInfoBlock(AppLocalizations localizations, ThemeData theme, DeputyFull deputyFull) {
    final cv = deputyFull.getDeputyCV();

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
      child: GestureDetector(
        onTap: () {

        },
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
                imageUrl: voteAccuracy.parliamentClub?.imageSrc,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Center(child: Text(voteAccuracy.parliamentClub?.shortName ?? ""),),
                width: 40,
                height: 40,
                memCacheHeight: 700,
                memCacheWidth: 700,
                alignment: Alignment.center,
                // )
              ),
            ),
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
      )
    );
  }

  Widget buildVoteAccuracyTable(List<ClubVoteAccuracy> voteAccuracy, AppLocalizations localizations, ThemeData theme) {
    final int highestOverallAccuracy = voteAccuracy[0].compatibleVotes;

    return Container(
      child: Column(
        children: voteAccuracy.map((e) => buildVoteAccuracyTableRow(e, highestOverallAccuracy, theme)).toList(),
      ),
    );
  }

  Widget buildStatisticsBlock(AppLocalizations localizations, ThemeData theme, DeputyFull deputyFull) {
    final stats = deputyFull.getStatistics();

    final voteAccuracy = stats.clubVoteAccuracy;
    voteAccuracy.sort((a,b) => a.compatibleVotes > b.compatibleVotes ? -1 : 1);

    final cells = deputyFull.getStatisticsHorizontalTableCells(localizations);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SimpleHorizontalTable(cells: cells),
        buildCardHeader(localizations.getText().deputiesVoteAccuracy(), theme, 15),
        DeputyVoteAccuracyTable(voteAccuracy, _deputyModel, _navigationCallback)
      ],
    );
  }

  List<Widget> generateNounsWidgets(List<WordModel> words) {

    List<Widget> widgets = [];
    words.forEach((model) {
      widgets.add(RotatedBox(
        quarterTurns: (model.occurrence % 2).toInt(),
        child: Text(
          "#${model.word}",
          style: TextStyle(fontSize: model.occurrence, color: Colors.black38),
        ),
      ));
    });

    return widgets;
  }

  Widget buildNounCloud(AppLocalizations localizations, ThemeData theme, DeputyFull deputyFull, DeputiesCache deputyCache, BuildContext context) {
    final nounsPromise = deputyCache.getDeputyNouns(deputyFull.id);

    final screenSize = MediaQuery.of(context).size;
    final ratio = (screenSize.width - 20) / screenSize.height;

    return FutureProvider<Result<List<WordModel>>?>(
      initialData: null,
      create: (context) => nounsPromise,
      child: Consumer<Result<List<WordModel>>?>(
          builder: (context, list, _) {
            if (list is Success<List<WordModel>>) {
              final nouns = (list as Success<List<WordModel>>).value;
              return InteractiveViewer(
                child: Transform.scale(
                  scale: 0.80,
                  child: Scatter(
                      fillGaps: true,
                      delegate: ArchimedeanSpiralScatterDelegate(
                        ratio: ratio,
                        a: 1.0,
                        b: 1.0,
                      ),
                      children: generateNounsWidgets(nouns),
                      overflow: Overflow.visible),
                ),
              );
            } else {
              return Container(
                width: double.infinity,
                height: screenSize.width,
                child: Center(
                  child: CircularProgressIndicator())
              );
            }
          }
        )
    );
  }
}