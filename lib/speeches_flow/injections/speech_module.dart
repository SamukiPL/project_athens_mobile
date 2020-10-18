import 'package:flutter/src/widgets/framework.dart';
import 'package:nested/nested.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/athens_core/models/timeline_model.dart';
import 'package:project_athens/speeches_flow/screens/details/speech_details_bloc.dart';
import 'package:project_athens/speeches_flow/screens/details/video_manager.dart';
import 'package:provider/provider.dart';

class SpeechModule extends Module {
  final SpeechModel speechModel;

  SpeechModule(BuildContext context, this.speechModel) : super(context);

  @override
  List<SingleChildWidget> getProviders() {
    final videoWidgetBloc = VideoManager(speechModel);
    return [
      Provider<SpeechDetailsBloc>(
        create: (_) => SpeechDetailsBloc(videoWidgetBloc),
        dispose: (context, bloc) => bloc.dispose(),
      ),
    ];
  }

}