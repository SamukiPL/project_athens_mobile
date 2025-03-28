import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/constants/color_constants.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/voting_flow/screens/details/linear_vote_distribution/linear_vote_distribution_painter.dart';
import 'package:project_athens/voting_flow/screens/details/linear_vote_distribution/linear_vote_distribution_model.dart';
import 'package:provider/provider.dart';

import 'linear_vote_distribution_segment.dart';

class LinearVoteDistribution extends StatelessWidget {
  final LinearVoteDistributionModel model;

  LinearVoteDistribution({required this.model});

  Widget build(BuildContext context) {
    final double _diameter = (MediaQuery.of(context).size.width / 1.616);
    final AppLocalizations localizations =
        Provider.of<AppLocalizations>(context);

    List<LinearVoteDistributionSegment> segments =
        _buildVoteSegments(localizations);
    int requiredVotes = _getRequiredVotes();

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomPaint(
              foregroundPainter: LinearVoteDistributionPainter(
                  localizations, segments, requiredVotes),
              child: Container(
                  constraints: BoxConstraints.expand(
                      height: _diameter / 2, width: _diameter),
                  child: Align(
                      alignment: Alignment.center,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[])))),
          buildUnusedSegments(context, segments)
        ],
      ),
    );
  }

  buildUnusedSegments(BuildContext context,
      List<LinearVoteDistributionSegment> unusedSegments) {
    final double halfWidth = (MediaQuery.of(context).size.width / 2);

    return unusedSegments.length > 0
        ? Container(
            padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
            child: Wrap(
              children: unusedSegments
                  .map((segment) => Container(
                      width: halfWidth - 16,
                      child: Row(
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            color: segment.color,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 5),
                            child: Text(
                              '${segment.label}: ${segment.votes}',
                            ),
                          )
                        ],
                      )))
                  .toList(),
            ),
          )
        : Container();
  }

  List<LinearVoteDistributionSegment> _buildVoteSegments(
      AppLocalizations localizations) {
    bool isAbsentUsed = true;
    bool isHoldUsed = true;
    bool isInFavorUsed = true;
    bool isAgainstUsed = true;

    if (model.absoluteMajority != 0 && model.absoluteMajority != null) {
      isAbsentUsed = false;
    } else if (model.qualifyingMajority != 0 &&
        model.qualifyingMajority != null) {
      // every is being used
    } else {
      isAbsentUsed = false;
      isHoldUsed = false;
    }

    return [
      LinearVoteDistributionSegment(
          model.inFavor,
          localizations.getText().votingsVoteTypesInFavor(),
          ColorConstants.voteInFavorColor,
          model.inFavor == 0 ? false : isInFavorUsed),
      LinearVoteDistributionSegment(
          model.absent,
          localizations.getText().votingsVoteTypesAbsentPlural(),
          ColorConstants.voteAbsetColor,
          model.absent == 0 ? false : isAbsentUsed),
      LinearVoteDistributionSegment(
          model.hold,
          localizations.getText().votingsVoteTypesHoldPlural(),
          ColorConstants.voteHoldColor,
          model.hold == 0 ? false : isHoldUsed),
      LinearVoteDistributionSegment(
          model.against,
          localizations.getText().votingsVoteTypesAgainst(),
          ColorConstants.voteAgainstColor,
          model.against == 0 ? false : isAgainstUsed),
    ];
  }

  int _getRequiredVotes() {
    if (this.model.absoluteMajority != 0 &&
        this.model.absoluteMajority != null) {
      return this.model.absoluteMajority!;
    } else if (this.model.qualifyingMajority != 0 &&
        this.model.qualifyingMajority != null) {
      return this.model.qualifyingMajority!;
    } else {
      final int summedVotes = this.model.inFavor + this.model.against;
      final int votesRequired = summedVotes % 2 == 0
          ? ((summedVotes / 2) + 1).ceil()
          : (summedVotes / 2).ceil();

      return votesRequired;
    }
  }
}
