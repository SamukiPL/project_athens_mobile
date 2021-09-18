import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/navigation/destination_manager.dart';
import 'package:project_athens/deputies_flow/domain/vote_accuracy_alignment_enum.dart';
import 'package:project_athens/deputies_flow/navigation/deputies_destinations.dart';
import 'package:project_athens/deputies_flow/screens/details/presentation/vote_accuracy_bar_expand_notifier.dart';
import 'package:project_athens/deputies_utils/domain/deputy_full.dart';
import 'package:project_athens/deputies_utils/domain/deputy_model.dart';
import 'package:provider/provider.dart';

class DeputyVoteAccuracyTable extends StatelessWidget {
  final List<ClubVoteAccuracy> _voteAccuracy;
  final DeputyModel _deputy;
  final void Function(BuildContext context, Destination destination) _navigationCallback;


  const DeputyVoteAccuracyTable(this._voteAccuracy, this._deputy, this._navigationCallback);

  @override
  Widget build(BuildContext context) {
    final localizations = Provider.of<AppLocalizations>(context);
    final theme = Theme.of(context);
    final int highestOverallAccuracy = _voteAccuracy[0].compatibleVotes;

    return Container(
      child: Column(
        children: _voteAccuracy.map((e) => _buildVoteAccuracyTableRow(e, highestOverallAccuracy, context)).toList(),
      ),
    );
  }

  Widget _buildClubImage(ClubVoteAccuracy clubVoteAccuracy) {
    return Container(
      padding: EdgeInsets.only(right: 5),
      alignment: Alignment.center,
      width: 50,
      height: 50,
      child: CachedNetworkImage(
        filterQuality: FilterQuality.high,
        imageUrl: clubVoteAccuracy.parliamentClub?.imageSrc,
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) =>
            Center(
              child: Text(clubVoteAccuracy.parliamentClub?.shortName ?? "Err: unkown club"),
            ),
        width: 40,
        height: 40,
        memCacheHeight: 700,
        memCacheWidth: 700,
        alignment: Alignment.center,
      ),
    );
  }

  Widget _buildAccuracyBar(ClubVoteAccuracy clubVoteAccuracy, int overallHighestAccuracy, ThemeData theme) {
    final double barWidth = clubVoteAccuracy.compatibleVotes / overallHighestAccuracy;
    final accuracyPercentage = (barWidth * 100).toStringAsFixed(1) + '%';

    return Expanded(
      child: FractionallySizedBox(
        alignment: Alignment.topLeft,
        widthFactor: barWidth,
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: theme.primaryColor,
          ),
          child: Center(
            child: Text(
              accuracyPercentage,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      )
    );
  }

  Widget _buildVoteAccuracyTableRow(ClubVoteAccuracy clubVoteAccuracy, int overallHighestAccuracy, BuildContext context) {
    final expandChangeNotifier = VoteAccuracyBarExpandNotifier();
    final localizations = Provider.of<AppLocalizations>(context);
    final theme = Theme.of(context);

    return Container(
        color: Colors.white,
        padding: EdgeInsets.only(top: 5, left: 5, right: 5),
        child: Column(
          children: [
            GestureDetector(
              onTap: () => expandChangeNotifier.toggle(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildClubImage(clubVoteAccuracy),
                  _buildAccuracyBar(clubVoteAccuracy, overallHighestAccuracy, theme)
                ],
              ),
            ),
            ChangeNotifierProvider<VoteAccuracyBarExpandNotifier>.value(
                value: expandChangeNotifier,
                child: Consumer<VoteAccuracyBarExpandNotifier>(
                  builder: (context, notifier, child) => AnimatedContainer(
                      duration: Duration(milliseconds: 400),
                      curve: Curves.ease,
                      height: notifier.isOpen ? 100 : 0,
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MaterialButton(
                            onPressed: () => _navigationCallback(context, DeputyDetailsVoteAccuracyDestination(
                              clubVoteAccuracy,
                              _deputy,
                              VoteAccuracyAlignment.ALIGNED
                            )),
                            child: Text(localizations.getText().deputiesAlignedWithParty())
                          ),
                          MaterialButton(
                            onPressed: () => _navigationCallback(context, DeputyDetailsVoteAccuracyDestination(
                              clubVoteAccuracy,
                              _deputy,
                              VoteAccuracyAlignment.NOT_ALIGNED
                            )),
                            child: Text(localizations.getText().deputiesNotAlignedWithParty())
                          ),
                        ],
                      )
                  )
                ),
            )
          ],
        )
    );
  }
}