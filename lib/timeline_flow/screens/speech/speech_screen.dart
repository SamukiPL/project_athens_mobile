import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/athens_core/presentation/base_screen.dart';
import 'package:project_athens/timeline_flow/domain/timeline_model.dart';
import 'package:project_athens/timeline_flow/injections/speech_module.dart';
import 'package:project_athens/timeline_flow/screens/speech/speech_bloc.dart';
import 'package:project_athens/timeline_flow/screens/speech/video_widget_bloc.dart';
import 'package:provider/provider.dart';

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
        Consumer<VideoWidgetBloc>(
          builder: (context, bloc, child) => GestureDetector(
            onTap: () {
              bloc.videoClick();
            },
            child: Stack(
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
                child
              ],
            ),
          ),
          child: VlcPlayer(
          aspectRatio: 16/9,
          url: speechModel.videoUrl,
          controller: bloc.controller,
          options: [],
          ),
        ),
        Container(
          color: theme.primaryColor,
          child: Row(
            children: [
              Container(
                width: 75,
                height: 75,
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
              Text(
                speechModel.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              )
            ],
          ),
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

  @override
  Widget buildFloatingActionButton(BuildContext context, SpeechBloc bloc) {
    return null;
  }

  @override
  List<Module> getProviders(BuildContext context) {
    return [SpeechModule(context)];
  }

}