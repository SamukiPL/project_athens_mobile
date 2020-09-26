import 'package:flutter/src/widgets/framework.dart';
import 'package:nested/nested.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/timeline_flow/domain/timeline_model.dart';
import 'package:project_athens/timeline_flow/screens/speech/speech_bloc.dart';
import 'package:project_athens/timeline_flow/screens/speech/video_manager.dart';
import 'package:provider/provider.dart';

class SpeechModule extends Module {
  final SpeechModel speechModel;

  SpeechModule(BuildContext context, this.speechModel) : super(context);

  @override
  List<SingleChildWidget> getProviders() {
    final videoWidgetBloc = VideoManager(speechModel);
    return [
      Provider<SpeechBloc>(
        create: (_) => SpeechBloc(videoWidgetBloc),
        dispose: (context, bloc) => bloc.dispose(),
      ),
    ];
  }

}