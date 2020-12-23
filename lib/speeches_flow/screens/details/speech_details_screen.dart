import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/models/timeline_model.dart';
import 'package:project_athens/athens_core/navigation/bottom_navigation_bloc.dart';
import 'package:project_athens/athens_core/presentation/base_screen.dart';
import 'package:project_athens/athens_core/presentation/technical_data/technical_data.dart';
import 'package:project_athens/deputies_flow/navigation/deputies_destinations.dart';
import 'package:project_athens/deputies_utils/domain/deputy_model.dart';
import 'package:project_athens/speeches_flow/screens/details/speech_details_bloc.dart';

class SpeechDetailsScreen  extends BaseScreen<SpeechDetailsBloc> {

  @override
  BottomNavItem get currentBottomBarItem => BottomNavItem.SPEECHES;

  final SpeechModel speechModel;

  SpeechDetailsScreen({@required this.speechModel});

  @override
  String getAppBarTitle(AppLocalizations localizations, SpeechDetailsBloc bloc) {
    return localizations.getText().speechesSpeechDetailsTitle();
  }

  @override
  Widget buildBody(BuildContext context, SpeechDetailsBloc bloc) {
    final theme = Theme.of(context);
    return Column(
      children: [
        speakerLabel(context, bloc, theme),
        Stack(
          children: [
            AspectRatio(
              aspectRatio: 16/9,
              child: Container(
                color: Colors.black,
                child: Center(
                    heightFactor: 25,
                    widthFactor: 25,
                    child: CircularProgressIndicator()
                ),
              ),
            ),
            FlickVideoPlayer(
              flickManager: bloc.controller,
            )
          ],
        ),
        Container(
          margin: EdgeInsets.all(16),
          child: Text(
            speechModel.desc,
            style: TextStyle(
              color: theme.dividerColor,
              fontSize: 18
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(16),
          child: TechnicalData(technicalId: speechModel.id, additionalIds: { 'deputyId': speechModel.deputyId }),
        )
      ],
    );
  }

  Widget speakerLabel(BuildContext context, SpeechDetailsBloc bloc, ThemeData theme) {
    return Container(
      color: theme.primaryColor,
      child: GestureDetector(
        onTap: () => goToDeputyDetails(context, bloc.deputyModel),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 65,
                  height: 65,
                  child: Hero(
                    tag: speechModel.id,
                    child: Container(
                      margin: EdgeInsets.all(8),
                      height: double.infinity,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: theme.dividerColor, width: 2)),
                      child: ClipOval(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white
                          ),
                          child: Image.network(
                            speechModel.thumbnailUrl,
                            width: 65,
                            errorBuilder:
                                (context, exception, stackTrace) => Icon(
                              Icons.record_voice_over,
                              color: theme.dividerColor,
                              size: 45,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      speechModel.personName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: Text(
                        speechModel.club,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(right: 8),
              child: Text(
                DateFormat("hh:mm\nd.M.y", "pl").format(speechModel.date),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget buildFloatingActionButton(BuildContext context, SpeechDetailsBloc bloc) => null;

  void goToDeputyDetails(BuildContext context, DeputyModel model) {
    final destination = DeputyDetailsDestination(model, currentBottomBarItem);
    goToDestination(context, destination);
  }

}