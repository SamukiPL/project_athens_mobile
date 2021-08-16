import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/models/speech_model.dart';
import 'package:project_athens/athens_core/presentation/delegates/redirection_delegate.dart';
import 'package:project_athens/speeches_flow/navigation/speeches_destinations.dart';
import 'package:project_athens/speeches_flow/screens/details/video_widget/next_video_overlay_bloc.dart';
import 'package:provider/provider.dart';

class NextVideoOverlay extends StatelessWidget with RedirectionDelegate {

  final NextVideoOverlayBloc bloc;
  final bool isNormalSpeech;

  const NextVideoOverlay({Key? key, required this.bloc, required this.isNormalSpeech}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = Provider.of<AppLocalizations>(context);

    return StreamProvider.value(
      value: bloc.stream,
      initialData: null,
      child: Consumer<PersonSpeechModel?>(
        builder: (context, model, _) => (model != null) ? AspectRatio(
          aspectRatio: 16 / 9,
          child: Container(
            color: Colors.black,
            child: Center(
                heightFactor: 25,
                widthFactor: 25,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildNextVideoInfo(context, model, theme, localizations),
                    buildButtons(context, model, theme, localizations)
                  ],
                )),
          ),
        ) : Container(),
      ),
    );
  }

  Widget buildNextVideoInfo(BuildContext context, PersonSpeechModel nextPersonSpeech, ThemeData theme, AppLocalizations localizations) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildCountdown(context, nextPersonSpeech, theme),
          buildSpeechInfo(nextPersonSpeech, localizations)
        ],
      ),
    );
  }

  Widget buildCountdown(BuildContext context, PersonSpeechModel nextPersonSpeech, ThemeData theme) {
    return Stack(alignment: Alignment.center, children: [
      CircularCountDownTimer(
        duration: 5,
        fillColor: theme.primaryColor,
        height: 50,
        width: 50,
        ringColor: theme.dividerColor,
        controller: bloc.controller,
        onComplete: () => goToNextVideo(context, nextPersonSpeech),
      ),
      Container(
        width: 45,
        height: 45,
        child: ClipOval(
          child: Container(
            decoration: BoxDecoration(color: Colors.white),
            child: Image.network(
              nextPersonSpeech.thumbnailUrl ?? "",
              width: 45,
              errorBuilder: (context, exception, stackTrace) =>
                  Icon(
                    Icons.record_voice_over,
                    color: theme.dividerColor,
                    size: 25,
                  ),
            ),
          ),
        ),
      )
    ]);
  }

  Widget buildSpeechInfo(PersonSpeechModel nextPersonSpeech, AppLocalizations localizations) {
    return Container(
      margin: EdgeInsets.only(left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              localizations().speechesNextSpeech(),
              style:
              TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          Text(
            nextPersonSpeech.name,
            style: TextStyle(color: Colors.white70, fontSize: 16),
          )
        ],
      ),
    );
  }

  Widget buildButtons(BuildContext context, PersonSpeechModel nextPersonSpeech, ThemeData theme, AppLocalizations localizations) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(right: 32),
          child: TextButton(
            onPressed: () => bloc.stopCountdown(),
            child: Text(
              localizations().universalCancel(),
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
        MaterialButton(
          onPressed: () {
            bloc.stopCountdown();
            goToNextVideo(context, nextPersonSpeech);
          },
          color: theme.primaryColor,
          child: Text(
            localizations().speechesPlayNow(),
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        )
      ],
    );
  }

  void goToNextVideo(BuildContext context, PersonSpeechModel nextPersonSpeech) {
    final destination = SpeechDetailsDestination.nextSpeechReplacement(nextPersonSpeech.speechId, isNormalSpeech);
    goToDestination(context, destination);
  }

}