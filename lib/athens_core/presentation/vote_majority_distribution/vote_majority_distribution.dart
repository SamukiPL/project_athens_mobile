import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/constants/color_constants.dart';
import 'package:project_athens/athens_core/models/voting_model.dart';
import 'package:project_athens/athens_core/presentation/vote_majority_distribution/vote_majority_distribution_model.dart';

class VoteMajorityDistribution extends StatelessWidget {
  final List<VoteMajorityDistributionModel> votesMajority;
  final bool showAbsent;

  double get avatarSize => 50;
  double get clubNameFontSize => 10;

  VoteMajorityDistribution({this.votesMajority, this.showAbsent});

  Widget buildIconRow(ThemeData theme) {
    return Row(
      children: [
        Expanded(
          child: Container(
            child:
              Icon(
                Icons.thumb_up,
                color: theme.dividerColor,
              )
          ),
        ),
        Expanded(
          child: Container(
            child:
              Icon(
                Icons.thumb_down,
                color: theme.dividerColor,
              )
          ),
        ),
        Expanded(
          child: Container(
            child:
              Icon(
                Icons.pan_tool,
                color: theme.dividerColor,
              )
          ),
        ),
        showAbsent ?
        Expanded(
          child: Container(
            child:
              Icon(
                Icons.clear,
                color: theme.dividerColor,
              )
          )
        ) : Container(),
      ],
    );
  }

  Widget buildVoteAvatar(VoteMajorityDistributionModel model, ThemeData theme) {
    final shouldClipToOval = (Widget child) => model.isDeputy
        ? Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: theme.primaryColor, width: 2)
              ),
              child: ClipOval(
                child: child,
              )
            )
        : Container(child: child);


    return Container(
      padding: EdgeInsets.only(right: 5),
      alignment: Alignment.center,
      width: avatarSize,
      height: avatarSize,
      child: shouldClipToOval(CachedNetworkImage(
        imageUrl: model.img,
        filterQuality: FilterQuality.high,
        fit: BoxFit.cover,
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) =>
            Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1)
              ),
              child: Center(
                  child: Text(
                    model.alt,
                    style: TextStyle(
                        fontSize: clubNameFontSize
                    ),
                  )
              ),
            ),
        width: avatarSize - 5,
        height: avatarSize - 5,
        memCacheHeight: 700,
        memCacheWidth: 700,
        alignment: Alignment.center,
        // )
        ),
      )
    );
  }

  Widget buildVoteTypeCell(VoteType currentType, ThemeData theme) {
    final votes = votesMajority.where((element) => element.type == currentType).toList();

    return Container(
      child: Center(
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: votes.map((e) => buildVoteAvatar(e, theme)).toList(),
        ),
      )
    );
  }

  Widget buildVoteTypeRow(ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: buildVoteTypeCell(VoteType.IN_FAVOR, theme)),
        Expanded(child: buildVoteTypeCell(VoteType.AGAINST, theme)),
        Expanded(child: buildVoteTypeCell(VoteType.HOLD, theme)),
        showAbsent ? Expanded(child: buildVoteTypeCell(VoteType.ABSENT, theme)) : Container(),
      ],
    );
  }

  Color getBorderColor(VoteType type) {
    switch(type)  {
      case VoteType.IN_FAVOR:
        return ColorConstants.voteInFavorColor;
        break;
      case VoteType.AGAINST:
        return ColorConstants.voteAgainstColor;
        break;
      case VoteType.HOLD:
        return ColorConstants.voteHoldColor;
        break;
      case VoteType.ABSENT:
        return ColorConstants.voteAbsetColor;
        break;
    }
  }

  Widget buildAvatar(VoteMajorityDistributionModel model) {
    return Container(
        padding: EdgeInsets.only(right: 5),
        alignment: Alignment.center,
        width: avatarSize,
        height: avatarSize,
        child: CachedNetworkImage(
          imageUrl: model.img,
          filterQuality: FilterQuality.high,
          fit: model.isDeputy ? BoxFit.cover : BoxFit.contain,
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider
              ),
              shape: model.isDeputy ? BoxShape.circle : BoxShape.rectangle,
              border: Border.all(color: getBorderColor(model.type), width: 2)
            ),
          ),
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) =>
              Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                    border: Border.all(color: getBorderColor(model.type), width: 2)
                ),
                child: Center(
                    child: Text(
                      model.alt,
                      style: TextStyle(
                          fontSize: clubNameFontSize
                      ),
                    )
                ),
              ),
          width: avatarSize - 5,
          height: avatarSize - 5,
          memCacheHeight: 700,
          memCacheWidth: 700,
          alignment: Alignment.center,
          // )
        ),
      );
  }

  Widget buildVoteTypesRow(ThemeData theme) {
    votesMajority.sort((a, b) => a.type.index.compareTo(b.type.index));

    return Container(
      child: Row(
        children: votesMajority.map((e) => buildAvatar(e)).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.only(bottom: 8),
      child: Column(
        children: [
          // buildIconRow(theme),
          // buildVoteTypeRow(theme),
          buildVoteTypesRow(theme),
        ],
      )
    );
  }
}