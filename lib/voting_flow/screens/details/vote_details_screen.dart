import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:project_athens/athens_core/constants/color_constants.dart';
import 'package:project_athens/athens_core/data/vote/vote_slim_model.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/models/voting_model.dart';
import 'package:project_athens/athens_core/presentation/base_screen.dart';
import 'package:project_athens/athens_core/presentation/db_source/db_source.dart';
import 'package:project_athens/athens_core/presentation/full_card/full_card.dart';
import 'package:project_athens/athens_core/presentation/simple_horizontal_table/simple_horizontal_table.dart';
import 'package:project_athens/athens_core/presentation/simple_horizontal_table/simple_horizontal_table_cell.dart';
import 'package:project_athens/athens_core/presentation/technical_data/technical_data.dart';
import 'package:project_athens/deputies_utils/cache/deputies_cache.dart';
import 'package:project_athens/deputies_utils/domain/deputy_model.dart';
import 'package:project_athens/voting_flow/screens/details/linear_vote_distribution/linear_vote_distribution.dart';
import 'package:project_athens/voting_flow/screens/details/vote_club_distribution_row_data.dart';
import 'package:project_athens/voting_flow/screens/details/vote_details_bloc.dart';
import 'package:project_athens/voting_flow/screens/details/linear_vote_distribution/linear_vote_distribution_model.dart';
import 'package:provider/provider.dart';

class VoteDetailsScreen extends BaseScreen<VoteDetailsBloc> {

  final VoteSlimModel _voteModel;

  VoteDetailsScreen(this._voteModel);

  @override
  String getAppBarTitle(AppLocalizations localization, VoteDetailsBloc bloc) {
    return _voteModel.votingDesc;
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
          FullCard(
            header: 'Podstawowe informacje',
              headerPadding: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  buildDateAndFrequencyTable(context, theme),
                  Container(child: buildVoteDistributionChart(bloc, context))
                ],
          )),
          FullCard(header: 'Opis', headerPadding: 8, child: buildDescription(theme)),
          FullCard(header: 'Rozkład głosów', headerPadding: 8, child: buildClubVoteDistributionView(context, theme, bloc)),
          FullCard(header: 'Obserwowani posłowie', headerPadding: 8, child: buildDeputyVotesView(context, theme, bloc)),
          StreamProvider<VotingModel?>.value(
              value: bloc.votingFullStream,
              initialData: null,
              child: Consumer<VotingModel?>(
                builder: (context, model, _) =>
                    model != null ?
                    FullCard(
                    leftPadding: 8,
                    rightPadding: 8,
                    child: DbSource(model)
                ) : Container()
              )
          ),
          TechnicalData(technicalId: _voteModel.id),

        ],
      ),
    ));
  }

  Widget buildFullCard(Widget child) {
    return Container(
        padding: EdgeInsets.only(top: 4, bottom: 4),
        child: Container(
          padding: EdgeInsets.only(top: 8, bottom: 8),
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(0, 2), // changes position of shadow
            )
          ]),
          child: child,
        ));
  }

  Widget buildDateRow(ThemeData theme) {
    return Container(
        padding: EdgeInsets.only(bottom: 20),
        child: Text(
          DateFormat("HH:mm d.MM.y", "pl").format(_voteModel.voteAt),
          style: TextStyle(
            color: theme.primaryColor,
            fontSize: 14,
          ),
          textAlign: TextAlign.center,
        ));
  }

  Widget buildVoteDistributionChart(bloc, context) {
    return Container(
      child: LinearVoteDistribution(model: LinearVoteDistributionModel.fromVoteSlim(_voteModel)),
    );
  }

  Widget buildDateAndFrequencyTable(BuildContext context, ThemeData theme) {
    final votingsCount = (_voteModel.voteNumbers.inFavor +
        _voteModel.voteNumbers.hold +
        _voteModel.voteNumbers.against);

    final cells = [
      SimpleHorizontalTableCell(
        lowerText: DateFormat("HH:mm", "pl").format(_voteModel.voteAt),
        icon: Icons.access_time
      ),
      SimpleHorizontalTableCell(
          lowerText: DateFormat("d.MM.yyyy", "pl").format(_voteModel.voteAt),
          icon: Icons.today,
      ),
      SimpleHorizontalTableCell(
          lowerText: votingsCount.toString() + "/460",
          icon: Icons.how_to_reg
      ),
    ];

    return SimpleHorizontalTable(cells: cells.toList());
  }

  Widget buildVotesResultTable(BuildContext context, ThemeData theme) {
    final VoteNumbers results = _voteModel.voteNumbers;

    return Container(
      margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Icon(
                  Icons.thumb_up,
                  color: theme.dividerColor,
                ),
                Text(
                  results.inFavor.toString(),
                  style: TextStyle(color: ColorConstants.voteInFavorColor),
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Icon(
                  Icons.thumb_down,
                  color: theme.dividerColor,
                ),
                Text(
                  results.against.toString(),
                  style: TextStyle(color: ColorConstants.voteAgainstColor),
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Icon(
                  Icons.pan_tool,
                  color: theme.dividerColor,
                ),
                Text(
                  results.hold.toString(),
                  style: TextStyle(color: ColorConstants.voteHoldColor),
                )
              ],
            ),
          ),
          Expanded(
              child: Column(
            children: [
              Icon(
                Icons.clear,
                color: theme.dividerColor,
              ),
              Text(
                results.absent.toString(),
                style: TextStyle(color: ColorConstants.voteAbsetColor),
              )
            ],
          )),
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
            _voteModel.votingDesc,
            style: TextStyle(color: theme.primaryColor, fontSize: 18),
          ),
          Text(
            DateFormat("HH:mm\nd.MM.y", "pl").format(_voteModel.voteAt),
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
              _voteModel.title,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w300),
            ),
          ],
        ));
  }

  TableRow  buildClubVoteTableRow(VoteClubDistributionRowData rowData, ThemeData theme) {
    final dataRowStyle = TextStyle(
      fontSize: 10,
    );

    return TableRow(
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(color: theme.dividerColor, width: 1))),
      children: [
        Container(
          padding: EdgeInsets.all(4),
          child: Text(rowData.parliamentClubModel.shortName,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 11)),
        ),
        Container(
            padding: EdgeInsets.all(4),
            child: Text(rowData.votingNumbers.totalDeputies.toString(),
                textAlign: TextAlign.center, style: dataRowStyle)),
        Container(
            padding: EdgeInsets.all(4),
            child: Text(rowData.votingNumbers.actualVoted.toString(),
                textAlign: TextAlign.center, style: dataRowStyle)),
        Container(
            padding: EdgeInsets.all(4),
            child: Text(rowData.votingNumbers.absent.toString(),
                textAlign: TextAlign.center, style: dataRowStyle)),
        Container(
            padding: EdgeInsets.all(4),
            child: Text(rowData.votingNumbers.inFavor.toString(),
                textAlign: TextAlign.center, style: dataRowStyle)),
        Container(
            padding: EdgeInsets.all(4),
            child: Text(rowData.votingNumbers.against.toString(),
                textAlign: TextAlign.center, style: dataRowStyle)),
        Container(
            padding: EdgeInsets.all(4),
            child: Text(rowData.votingNumbers.hold.toString(),
                textAlign: TextAlign.center, style: dataRowStyle)),
      ],
    );
  }

  Widget buildClubVoteDistributionView(BuildContext context, ThemeData theme, VoteDetailsBloc bloc) {
    final localizations = Provider.of<AppLocalizations>(context);
    final headingRowStyle =
        TextStyle(fontSize: 10, fontWeight: FontWeight.w500);
    final TableRow headingRow = TableRow(
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(color: theme.primaryColor, width: 2))),
      children: [
        TableCell(child: Container()), // just to fill empty space
        TableCell(
          child: Container(
              padding: EdgeInsets.all(4),
              child: Icon(Icons.group, color: theme.dividerColor, size: 20)),
          verticalAlignment: TableCellVerticalAlignment.middle,
        ),
        TableCell(
          child: Container(
              padding: EdgeInsets.all(4),
              child:
                  Icon(Icons.how_to_reg, color: theme.dividerColor, size: 20)),
          verticalAlignment: TableCellVerticalAlignment.middle,
        ),
        TableCell(
          child: Container(
              padding: EdgeInsets.all(4),
              child: Icon(MdiIcons.accountOff,
                  color: theme.dividerColor, size: 20)),
          verticalAlignment: TableCellVerticalAlignment.middle,
        ),
        TableCell(
          child: Container(
              padding: EdgeInsets.all(4),
              child: Icon(Icons.thumb_up, color: theme.dividerColor, size: 17)),
          verticalAlignment: TableCellVerticalAlignment.middle,
        ),
        TableCell(
          child: Container(
              padding: EdgeInsets.all(4),
              child:
                  Icon(Icons.thumb_down, color: theme.dividerColor, size: 17)),
          verticalAlignment: TableCellVerticalAlignment.middle,
        ),
        TableCell(
          child: Container(
              padding: EdgeInsets.all(4),
              child: Icon(Icons.pan_tool, color: theme.dividerColor, size: 15)),
          verticalAlignment: TableCellVerticalAlignment.middle,
        ),
      ],
    );
    final DeputiesCache deputiesCache = Provider.of<DeputiesCache>(context);

    return StreamProvider<List<VoteClubDistributionRowData>?>.value(
      initialData: null,
      value: bloc.clubVoteDistribution,
      child: Consumer<List<VoteClubDistributionRowData>?>(
        builder: (context, rowsData, _) =>
            rowsData != null ?
            Container(
              // additional padding on bottom to compensate internal table cells padding
                padding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
                child: Table(
                  // set first column with parliament club names a little bigger
                  // since it's need more space than 3 digit number.
                  columnWidths: const {
                    0: FlexColumnWidth(1.5),
                  },
                  children: [headingRow]..addAll(rowsData.map(
                          (rowData) => buildClubVoteTableRow(
                          rowData, theme))),
                )
            ) : Container()
      )
    );
  }

  Widget buildDeputyVotesView(BuildContext context, ThemeData theme, VoteDetailsBloc bloc) {
    return StreamProvider<VotingModel?>.value(
        value: bloc.votingFullStream,
        initialData: null,
        child: Consumer<VotingModel?>(
            builder: (context, model, _) =>
                model != null ?
                FullCard(
                leftPadding: 8,
                rightPadding: 8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                        direction: Axis.horizontal,
                        children: model.votes
                            .map((e) => buildDeputyVotingView(e, context, theme))
                            .toList()),
                  ],
                )
            ) : Container()
        )
    );
  }

  Widget buildDeputyVotingView(
      VoteModel voting, BuildContext context, ThemeData theme) {
    final deputiesCache = Provider.of<DeputiesCache>(context);
    final viewWidth = MediaQuery.of(context).size.width;
    final localizations = Provider.of<AppLocalizations>(context);
    String voteTypeStr;
    Color borderColor;
    switch (voting.type) {
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

    final foundDeputy = deputiesCache.getDeputyModelById(voting.cadencyDeputy);
    // return Container();
    return FutureProvider(
      initialData: null,
      create: (context) => foundDeputy,
      child: Consumer<DeputyModel?>(
          builder: (context, deputy, _) => deputy != null
              ? Container(
                  width: circleSize,
                  padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
                  child: Column(
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
                                          deputy.thumbnailUrl ?? ""),
                                    ))),
                            Container(
                              alignment: Alignment.center,
                              child: Text(
                                voteTypeStr,
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                              ),
                              decoration: BoxDecoration(
                                  color: borderColor.withOpacity(0.3),
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(color: borderColor, width: 2)),
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
                          deputy.club ?? "",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: theme.dividerColor,
                              fontWeight: FontWeight.w300,
                              fontSize: 12),
                        ),
                      ),
                    ],
                  ))
              : Container()),
    );
  }

  @override
  Widget? buildFloatingActionButton(
          BuildContext context, VoteDetailsBloc bloc) =>
      null;
}
