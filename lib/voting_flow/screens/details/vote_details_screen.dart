import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:project_athens/athens_core/constants/color_constants.dart';
import 'package:project_athens/athens_core/data/base_responses/voting_response.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/models/voting_model.dart';
import 'package:project_athens/athens_core/navigation/bottom_navigation_bloc.dart';
import 'package:project_athens/athens_core/presentation/base_screen.dart';
import 'package:project_athens/athens_core/presentation/technical_data/technical_data.dart';
import 'package:project_athens/deputies_utils/cache/deputies_cache.dart';
import 'package:project_athens/deputies_utils/domain/deputy_model.dart';
import 'package:project_athens/deputies_utils/domain/parliament_club_model.dart';
import 'package:project_athens/voting_flow/screens/details/linear_vote_distribution/linear_vote_distribution.dart';
import 'package:project_athens/voting_flow/screens/details/vote_details_bloc.dart';
import 'package:provider/provider.dart';

class VoteDetailsScreen extends BaseScreen<VoteDetailsBloc> {

  final BottomNavItem _currentBottomBarItem;

  final VotingModel _votingModel;

  VoteDetailsScreen(this._currentBottomBarItem, this._votingModel);

  @override
  BottomNavItem get currentBottomBarItem => _currentBottomBarItem;

  @override
  String getAppBarTitle(AppLocalizations localization, VoteDetailsBloc bloc) {
    return _votingModel.votingDesc;
  }

  @override
  Widget buildBody(BuildContext context, VoteDetailsBloc bloc) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      child: Container(
        color: Colors.grey.shade200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // vote distribution card
            buildFullCard(
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  buildDateAndFrequencyTable(context, theme),
                  Container(
                    child: buildVoteDistributionChart(bloc, context)
                  )
                ],
              )
            ),
            buildFullCard(buildDescription(theme)),
            buildFullCard(buildClubVoteDistributionView(context, theme)),
            buildFullCard(buildDeputyVotesView(context, theme)),
            TechnicalData(technicalId: _votingModel.id),
          ],
        ),
      )
    );
  }

  Widget buildFullCard(Widget child) {
    return Container(
      padding: EdgeInsets.only(top: 4, bottom: 4),
      child: Container(
        padding: EdgeInsets.only(top: 8, bottom: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 2), // changes position of shadow
          )]
        ),
        child: child,
      )
    );
  }

  Widget buildDateRow(ThemeData theme) {
    return
      Container(
        padding: EdgeInsets.only(bottom: 20),
        child: Text(
          DateFormat("hh:mm d.M.y", "pl").format(_votingModel.date),
          style: TextStyle(
            color: theme.primaryColor,
            fontSize: 14,
          ),
          textAlign: TextAlign.center,
        )
      );
  }

  Widget buildVoteDistributionChart(bloc, context) {
    return
      Container(
        child: LinearVoteDistribution(voting: _votingModel),
      );
  }
  
  Widget buildSimpleTable(IconData icon, String upperText, String lowerText, ThemeData theme, Border border) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(top: 8, bottom: 8),
        decoration: BoxDecoration(
          border: border != null ? border : Border()
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: theme.dividerColor,
              size: 30,
            ),
            Text(
              upperText + lowerText,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 19,
                  fontWeight: FontWeight.w300
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }

  Widget buildDateAndFrequencyTable(BuildContext context, ThemeData theme) {
    return Container(
      padding: EdgeInsets.only(top: 8),
      child: Row(
        children: [
          buildSimpleTable(Icons.access_time, DateFormat("hh:", "pl").format(_votingModel.date), DateFormat("mm", "pl").format(_votingModel.date), theme, Border( right: BorderSide(color: theme.dividerColor.withOpacity(0.4), width: 1) )),
          buildSimpleTable(Icons.today, DateFormat("d.M.", "pl").format(_votingModel.date), DateFormat("yyyy", "pl").format(_votingModel.date), theme, null),
          buildSimpleTable(Icons.how_to_reg, (_votingModel.results.inFavor + _votingModel.results.hold + _votingModel.results.against).toString(), "/460", theme, Border( left: BorderSide(color: theme.dividerColor.withOpacity(0.4), width: 1) )),
        ],
      ),
    );
  }

  Widget buildVotesResultTable(BuildContext context, ThemeData theme) {
    final VoteResultModel results = _votingModel.results;

    return Container(
      margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Icon(Icons.thumb_up, color: theme.dividerColor,),
                Text(
                    results.inFavor.toString(),
                    style: TextStyle(
                      color: ColorConstants.voteInFavorColor
                    ),
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Icon(Icons.thumb_down, color: theme.dividerColor,),
                Text(
                    results.against.toString(),
                    style: TextStyle(
                      color: ColorConstants.voteAgainstColor
                    ),
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Icon(Icons.pan_tool, color: theme.dividerColor,),
                Text(
                    results.hold.toString(),
                    style: TextStyle(
                      color: ColorConstants.voteHoldColor
                    ),
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Icon(Icons.clear, color: theme.dividerColor,),
                Text(
                    results.absent.toString(),
                    style: TextStyle(
                      color: ColorConstants.voteAbsetColor
                    ),
                )
              ],
            )
          ),
        ],
      ),
    );
  }

  Widget buildTypeAndDateRow(ThemeData theme) {
    return Container(
        margin: EdgeInsets.fromLTRB(8, 0, 8, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              _votingModel.votingDesc,
              style: TextStyle(
                  color: theme.primaryColor,
                  fontSize: 18
              ),
            ),
            Text(
              DateFormat("hh:mm\nd.M.y", "pl").format(_votingModel.date),
              style: TextStyle(
                color: theme.primaryColor,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      );
  }

  Widget buildDescription(ThemeData theme) {
    return Container(
      margin: EdgeInsets.fromLTRB(8, 16, 8, 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _votingModel.title,
            style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w300
            ),
          ),
        ],
      )

    );
  }

  TableRow buildClubVoteTableRow(List<ParliamentClubModel> clubs, ParliamentClubVotingNumbers votes, ThemeData theme) {
    final dataRowStyle = TextStyle(
      fontSize: 10,
    );

    final club = clubs.firstWhere((element) => element.id == votes.parliamentClub);

    return TableRow(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: theme.dividerColor,
                  width: 1
              )
          )
      ),
      children: [
        Container(
          padding: EdgeInsets.all(4),
          child: Text(
              club.shortName,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 11
              )
          ),
        ),
        Container(padding: EdgeInsets.all(4), child: Text(votes.totalDeputies.toString(), textAlign: TextAlign.center , style: dataRowStyle)),
        Container(padding: EdgeInsets.all(4), child: Text(votes.actualVoted.toString(), textAlign: TextAlign.center , style: dataRowStyle)),
        Container(padding: EdgeInsets.all(4), child: Text(votes.absent.toString(), textAlign: TextAlign.center , style: dataRowStyle)),
        Container(padding: EdgeInsets.all(4), child: Text(votes.inFavor.toString(), textAlign: TextAlign.center , style: dataRowStyle)),
        Container(padding: EdgeInsets.all(4), child: Text(votes.against.toString(), textAlign: TextAlign.center , style: dataRowStyle)),
        Container(padding: EdgeInsets.all(4), child: Text(votes.hold.toString(), textAlign: TextAlign.center , style: dataRowStyle)),
      ],
    ) ;
  }


  Widget buildClubVoteDistributionView(BuildContext context, ThemeData theme) {
    final localizations = Provider.of<AppLocalizations>(context);
    final headingRowStyle = TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w500
    );
    final TableRow headingRow = TableRow(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: theme.primaryColor,
            width: 2
          )
        )
      ),
      children: [
        TableCell(child: Container()), // just to fill empty space
        TableCell(child: Container(padding: EdgeInsets.all(4), child: Icon(Icons.group, color: theme.dividerColor, size: 20)), verticalAlignment: TableCellVerticalAlignment.middle,),
        TableCell(child: Container(padding: EdgeInsets.all(4), child: Icon(Icons.how_to_reg, color: theme.dividerColor, size: 20)), verticalAlignment: TableCellVerticalAlignment.middle,),
        TableCell(child: Container(padding: EdgeInsets.all(4), child: Icon(MdiIcons.accountOff, color: theme.dividerColor, size: 20)), verticalAlignment: TableCellVerticalAlignment.middle,),
        TableCell(child: Container(padding: EdgeInsets.all(4), child: Icon(Icons.thumb_up, color: theme.dividerColor, size: 17)), verticalAlignment: TableCellVerticalAlignment.middle,),
        TableCell(child: Container(padding: EdgeInsets.all(4), child: Icon(Icons.thumb_down, color: theme.dividerColor, size: 17)), verticalAlignment: TableCellVerticalAlignment.middle,),
        TableCell(child: Container(padding: EdgeInsets.all(4), child: Icon(Icons.pan_tool, color: theme.dividerColor, size: 15)), verticalAlignment: TableCellVerticalAlignment.middle,),
      ],
    );
    final DeputiesCache deputiesCache = Provider.of<DeputiesCache>(context);


    return FutureProvider(
      create: (context) => deputiesCache.parliamentClubs,
      child: Consumer<Result<List<ParliamentClubModel>>>(
        builder: (context, clubsResult, _) {
          if (clubsResult == null) {
            return Container();
          } else if (clubsResult is Success<List<ParliamentClubModel>>) {
            return Container(
              // additional padding on bottom to compensate internal table cells padding
              padding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
              child: Table(
                // set first column with parliament club names a little bigger
                // since it's need more space than 3 digit number.
                columnWidths: const {
                  0: FlexColumnWidth(1.5),
                },
                children: [headingRow]
                  ..addAll(_votingModel.clubVotes.map((clubVotes) => buildClubVoteTableRow(clubsResult.value, clubVotes, theme))),
              )
            );
          } else {
            // TODO: handle error, generic error view required
            return Container();
          }
        }
      ),
    );
  }

  Widget buildDeputyVotesView(BuildContext context, ThemeData theme) {
    final AppLocalizations localizations = Provider.of<AppLocalizations>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(left: 8, right: 8),
          child: Text(
            localizations.getText().votingsSubscribedDeputiesVotes(),
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colors.black,
                fontSize: 25
            ),
          ),
        ),
        Wrap(
          direction: Axis.horizontal,
          children: _votingModel.votes.map((e) => buildDeputyVotingView(e, context, theme)).toList()
        ),
      ],
    );
  }


  Widget buildDeputyVotingView(VoteModel voting, BuildContext context, ThemeData theme) {
    final deputiesCache = Provider.of<DeputiesCache>(context);
    final viewWidth = MediaQuery.of(context).size.width;
    final localizations = Provider.of<AppLocalizations>(context);
    String voteTypeStr;
    Color borderColor;
    switch(voting.type) {
      case VoteType.IN_FAVOR:
        voteTypeStr = localizations.getText().votingsVoteTypesInFavorSingle();
        borderColor = ColorConstants.voteInFavorColor;
        break;
      case VoteType.AGAINST:
        voteTypeStr = localizations.getText().votingsVoteTypesAgainstSingle();
        borderColor = ColorConstants.voteAgainstColor;
        break;
      case VoteType.HOLD:
        voteTypeStr = localizations.getText().votingsVoteTypesHoldSingle();
        borderColor = ColorConstants.voteHoldColor;
        break;
      case VoteType.ABSENT:
        voteTypeStr = localizations.getText().votingsVoteTypesAbsentSingle();
        borderColor = ColorConstants.voteAbsetColor;
        break;
    }

    final circleSize = viewWidth * 0.25;

    final foundDeputy = deputiesCache.getDeputyModel(voting.cadencyDeputy);
    // return Container();
    return FutureProvider(
        create: (context) => foundDeputy,
        child: Consumer<DeputyModel>(
          builder: (context, deputy, _)  =>
            deputy != null

            ? Container(
              width: circleSize,
              padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
              child:
              Column(
                children: [
                  Container(
                    height: circleSize * 0.8,
                    width: circleSize * 0.8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                fit: BoxFit.cover,
                                image: new NetworkImage(
                                    deputy?.thumbnailUrl
                                ),
                              )
                          )
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            voteTypeStr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: borderColor.withOpacity(0.3),
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: borderColor,
                                  width: 2
                              )
                          ),
                        )
                      ],
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.only(top: 8),
                    child: Text(
                      deputy.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      deputy.club,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: theme.dividerColor,
                        fontWeight: FontWeight.w300,
                        fontSize: 12
                      ),
                    ),
                  ),
                ],
              )

            )
            : Container()
        ),
    );
  }

  @override
  Widget buildFloatingActionButton(BuildContext context, VoteDetailsBloc bloc) => null;

}