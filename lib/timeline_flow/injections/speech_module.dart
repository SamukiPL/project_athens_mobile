import 'package:flutter/src/widgets/framework.dart';
import 'package:nested/nested.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/timeline_flow/screens/speech/speech_bloc.dart';
import 'package:project_athens/timeline_flow/screens/speech/video_widget_bloc.dart';
import 'package:provider/provider.dart';

class SpeechModule extends Module {
  SpeechModule(BuildContext context) : super(context);

  @override
  List<SingleChildWidget> getProviders() {
    final videoWidgetBloc = VideoWidgetBloc();
    return [
      Provider<SpeechBloc>(
        create: (_) => SpeechBloc(videoWidgetBloc),
        dispose: (context, bloc) => bloc.dispose(),
      ),
      ChangeNotifierProvider<VideoWidgetBloc>.value(value: videoWidgetBloc)
    ];
  }

}