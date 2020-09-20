import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:project_athens/athens_core/presentation/base_screen.dart';
import 'package:project_athens/timeline_flow/domain/timeline_model.dart';
import 'package:project_athens/timeline_flow/screens/speech/speech_bloc.dart';

class SpeechScreen  extends BaseScreen<SpeechBloc> {

  final SpeechModel speechModel;

  SpeechScreen({@required this.speechModel});

  @override
  bool get showBackArrow => true;

  @override
  String get appBarTitle => "Speech";

  @override
  Widget buildBody(BuildContext context, SpeechBloc bloc) {
    final theme = Theme.of(context);
    return Column(
      children: [
        speakerLabel(theme),
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
        )
      ],
    );
  }

  Widget speakerLabel(ThemeData theme) => Container(
        color: theme.primaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                width: 65,
                height: 65,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.all(8),
                      height: double.infinity,
                      child: FutureBuilder(
                        future: speechModel.thumbnailUrl,
                        builder: (context, AsyncSnapshot<String> snapshot) =>
                            ClipOval(
                              child: Container(
                                width: double.infinity,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.white
                                ),
                                child: Image.network(
                                  snapshot.data ?? "",
                                  fit: BoxFit.fitWidth,
                                  width: 45,
                                  errorBuilder: (context, exception, stackTrace) =>  Icon(
                                    Icons.record_voice_over,
                                    color: theme.dividerColor,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 8, bottom: 8),
                      height: double.infinity,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: theme.dividerColor, width: 2)),
                    )],
                ),
              ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      speechModel.title,
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
                    )
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
      );

  @override
  Widget buildFloatingActionButton(BuildContext context, SpeechBloc bloc) {
    return null;
  }

}