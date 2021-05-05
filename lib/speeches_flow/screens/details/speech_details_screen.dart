import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/presentation/base_screen.dart';
import 'package:project_athens/athens_core/presentation/data_loading/data_loading_widget.dart';
import 'package:project_athens/athens_core/presentation/technical_data/technical_data.dart';
import 'package:project_athens/athens_core/utils/pair.dart';
import 'package:project_athens/deputies_flow/navigation/deputies_destinations.dart';
import 'package:project_athens/deputies_utils/domain/deputy_model.dart';
import 'package:project_athens/speeches_flow/screens/details/clipper_ltrb.dart';
import 'package:project_athens/speeches_flow/screens/details/speech_details_bloc.dart';
import 'package:project_athens/speeches_flow/screens/details/video_widget/speech_video_widget.dart';
import 'package:provider/provider.dart';

class SpeechDetailsScreen extends BaseScreen<SpeechDetailsBloc> {
  SpeechDetailsScreen();

  @override
  String getAppBarTitle(
      AppLocalizations localizations, SpeechDetailsBloc bloc) {
    return localizations.getText().speechesSpeechDetailsTitle();
  }

  @override
  Widget buildBody(BuildContext context, SpeechDetailsBloc bloc) {
    final theme = Theme.of(context);
    final localization = Provider.of<AppLocalizations>(context);
    return DataLoadingWidget(bloc.dataLoadingBloc,
        childBuilder: () =>
            buildMainScreen(context, bloc, theme, localization));
  }

  Widget buildMainScreen(BuildContext context, SpeechDetailsBloc bloc,
      ThemeData theme, AppLocalizations localization) {
    return Column(
      children: [
        SpeechVideoWidget(
          videoManager: bloc.videoManager,
        ),
        speakerLabel(context, bloc, theme),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(16),
                  child: Text(
                    bloc.speechModel.desc ?? "",
                    style: TextStyle(color: theme.dividerColor, fontSize: 18),
                  ),
                ),
                buildNextRow(bloc, theme, localization),
                buildPreviousRow(bloc, theme, localization),
                Container(
                  margin: EdgeInsets.all(16),
                  child: TechnicalData(
                      technicalId: bloc.speechModel.id,
                      additionalIds: {'deputyId': bloc.speechModel.deputyId}),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget speakerLabel(
      BuildContext context, SpeechDetailsBloc bloc, ThemeData theme) {
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
                    tag: bloc.speechModel.id,
                    child: Container(
                      margin: EdgeInsets.all(8),
                      height: double.infinity,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border:
                              Border.all(color: theme.dividerColor, width: 2)),
                      child: ClipOval(
                        child: Container(
                          decoration: BoxDecoration(color: Colors.white),
                          child: Image.network(
                            bloc.speechModel.thumbnailUrl,
                            width: 65,
                            errorBuilder: (context, exception, stackTrace) =>
                                Icon(
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
                      bloc.speechModel.personName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: Text(
                        bloc.speechModel.club.shortName,
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
                DateFormat("hh:mm\nd.MM.y", "pl").format(bloc.speechModel.date),
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

  Widget buildNextRow(SpeechDetailsBloc bloc, ThemeData theme,
          AppLocalizations localization) =>
      (bloc.speechModel.nextPersonSpeech != null)
          ? Container(
              margin: EdgeInsets.symmetric(vertical: 16),
              child: GestureDetector(
                onTap: () => bloc.goToNextSpeech(),
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      buildPic(theme,
                          bloc.speechModel.nextPersonSpeech.thumbnailUrl),
                      buildNextDecoration(theme),
                      buildNextPreviousInfo(
                          theme,
                          localization().speechesNextSpeech(),
                          bloc.speechModel.nextPersonSpeech.name),
                    ],
                  ),
                ),
              ),
            )
          : Container();

  Widget buildPreviousRow(SpeechDetailsBloc bloc, ThemeData theme,
          AppLocalizations localization) =>
      (bloc.speechModel.previousPersonSpeech != null)
          ? Container(
        margin: EdgeInsets.symmetric(vertical: 16),
            child: GestureDetector(
                onTap: () => bloc.goToPreviousSpeech(),
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      buildNextPreviousInfo(
                          theme,
                          localization().speechesPreviousSpeech(),
                          bloc.speechModel.previousPersonSpeech.name),
                      buildPreviousDecoration(theme),
                      buildPic(theme,
                          bloc.speechModel.previousPersonSpeech.thumbnailUrl),
                    ],
                  ),
                ),
              ),
          )
          : Container();

  Widget buildNextPreviousInfo(ThemeData theme, String header, String name) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              color: theme.primaryColor,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Text(
                header,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildPic(ThemeData theme, String thumbnailUrl) {
    return Container(
      width: 65,
      height: 65,
      child: Container(
        margin: EdgeInsets.all(8),
        height: double.infinity,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: theme.dividerColor, width: 2)),
        child: ClipOval(
          child: Container(
            decoration: BoxDecoration(color: Colors.white),
            child: Image.network(
              thumbnailUrl,
              width: 65,
              errorBuilder: (context, exception, stackTrace) => Icon(
                Icons.record_voice_over,
                color: theme.dividerColor,
                size: 45,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildNextDecoration(ThemeData theme) =>
      buildDecoration(theme, Pair(15.0, 0.0), null, null, Pair(0.0, null));

  Widget buildPreviousDecoration(ThemeData theme) =>
      buildDecoration(theme, null, Pair(5.0, 0.0), Pair(20.0, null), null);

  Widget buildDecoration(
      ThemeData theme,
      Pair<double, double> leftTop,
      Pair<double, double> rightTop,
      Pair<double, double> leftBottom,
      Pair<double, double> rightBottom) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: ClipPath(
            clipper: ClipperLTRB(leftTop: leftTop, rightTop: rightTop),
            child: Container(
              width: 20,
              color: theme.primaryColor,
            ),
          ),
        ),
        Expanded(
          child: ClipPath(
            clipper:
                ClipperLTRB(leftBottom: leftBottom, rightBottom: rightBottom),
            child: Container(
              width: 20,
              color: theme.primaryColorDark,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget buildFloatingActionButton(
          BuildContext context, SpeechDetailsBloc bloc) =>
      null;

  void goToDeputyDetails(BuildContext context, DeputyModel model) {
    final destination = DeputyDetailsDestination(model);
    goToDestination(context, destination);
  }
}
