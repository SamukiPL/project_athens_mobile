import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/constants/color_constants.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/models/voting_model.dart';
import 'package:project_athens/voting_flow/screens/details/linear_vote_distribution/linear_vote_distribution_painter.dart';
import 'package:provider/provider.dart';

import 'linear_vote_distribution_segment.dart';

class LinearVoteDistribution extends StatelessWidget {
  final VotingModel voting;

  LinearVoteDistribution({required this.voting});

  Widget build(BuildContext context) {
    final double _diameter = (MediaQuery.of(context).size.width / 1.616);
    final AppLocalizations localizations = Provider.of<AppLocalizations>(context);

    List<LinearVoteDistributionSegment> segments = _buildVoteSegments(localizations);
    int requiredVotes = _getRequiredVotes();

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
           CustomPaint(
              foregroundPainter: LinearVoteDistributionPainter(localizations, segments, requiredVotes),
              child: Container(

                  constraints: BoxConstraints.expand(height: _diameter / 2, width: _diameter),
                  child: Align(

                      alignment: Alignment.center,
                      child: Row(

                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[]
                      )
                  )
              )
          ),
          buildUnusedSegments(context, segments)
        ],
      ),
    );

  }

  buildUnusedSegments(BuildContext context, List<LinearVoteDistributionSegment> unusedSegments) {
    final double halfWidth = (MediaQuery.of(context).size.width / 2);

    return unusedSegments.length > 0 ?
    Container(
      padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
      child: Wrap(
      children:
        unusedSegments.map((segment) =>
          Container(
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
            )
          )
        ).toList(),
      ),
    ) : Container();

  }

  List<LinearVoteDistributionSegment> _buildVoteSegments(AppLocalizations localizations) {
    bool isAbsentUsed = true;
    bool isHoldUsed = true;
    bool isInFavorUsed = true;
    bool isAgainstUsed = true;

    if (voting.absoluteMajority != 0 && voting.absoluteMajority != null) {
      isAbsentUsed = false;
    } else if (voting.qualifyingMajority != 0 && voting.qualifyingMajority != null) {
      // every is being used
    } else {
      isAbsentUsed = false;
      isHoldUsed = false;
    }

    return [
      LinearVoteDistributionSegment(voting.results.inFavor, localizations.getText().votingsVoteTypesInFavor(), ColorConstants.voteInFavorColor, voting.results.inFavor == 0 ? false : isInFavorUsed),
      LinearVoteDistributionSegment(voting.results.absent, localizations.getText().votingsVoteTypesAbsentPlural(), ColorConstants.voteAbsetColor, voting.results.absent == 0 ? false : isAbsentUsed),
      LinearVoteDistributionSegment(voting.results.hold, localizations.getText().votingsVoteTypesHoldPlural(), ColorConstants.voteHoldColor, voting.results.hold == 0 ? false : isHoldUsed),
      LinearVoteDistributionSegment(voting.results.against, localizations.getText().votingsVoteTypesAgainst(), ColorConstants.voteAgainstColor, voting.results.against == 0 ? false : isAgainstUsed),
    ];
  }

  int _getRequiredVotes() {
    if (this.voting.absoluteMajority != 0 && this.voting.absoluteMajority != null) {
      return this.voting.absoluteMajority!;
    } else if (this.voting.qualifyingMajority != 0 && this.voting.qualifyingMajority != null) {
      return this.voting.qualifyingMajority!;
    } else {
      final int summedVotes = this.voting.results.inFavor + this.voting.results.against;
      final int votesRequired = summedVotes % 2 == 0 ? ((summedVotes / 2 ) + 1).ceil() : (summedVotes / 2).ceil();

      return votesRequired;
    }
  }
}