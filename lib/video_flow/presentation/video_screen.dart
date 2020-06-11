import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:provider/provider.dart';

import 'video_screen_bloc.dart';
import 'video_screen_bloc.dart';
import 'video_screen_bloc.dart';

class VideoScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Provider<VideoScreenBloc>(
        create: (_) => VideoScreenBloc(),
        child: Consumer<VideoScreenBloc>(
          builder: (context, bloc, _) => VlcPlayer(
            aspectRatio: 16/9,
            url: "https://r.dcs.redcdn.pl/nvr/o2/sejm/ENC01/live.livx?startTime=609923058000&stopTime=609923571000&name=090418-091251.flv",
            controller: bloc.controller,
          ),
        ),
      ),
    );
  }
}