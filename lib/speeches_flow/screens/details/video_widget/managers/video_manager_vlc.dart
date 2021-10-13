import 'package:better_player/better_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:project_athens/athens_core/models/speech_model.dart';
import 'package:project_athens/main/wakelock/wakelock_service.dart';
import 'package:project_athens/speeches_flow/screens/details/video_widget/managers/video_manager.dart';
import 'package:project_athens/speeches_flow/screens/details/video_widget/managers/vlc/vlc_player_with_controls.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class VideoManagerVlc extends VideoManager {
  late VlcPlayerController controller;

  BehaviorSubject<bool> overlayVisibility = BehaviorSubject<bool>.seeded(true);
  BehaviorSubject<bool> isVideoPlaying = BehaviorSubject<bool>.seeded(false);
  BehaviorSubject<Duration> durationTime = BehaviorSubject<Duration>.seeded(Duration.zero);
  BehaviorSubject<Duration> position = BehaviorSubject<Duration>.seeded(Duration.zero);


  Stream<double> get timelineValue => Rx.combineLatest2<Duration, Duration, double>(durationTime, position, (duration, position) {
    if(duration.inMilliseconds == 0 || position.inMilliseconds == 0) {
      return 0.0;
    } else {
      return position.inMilliseconds / duration.inMilliseconds * 100;
    }
  });

  Stream<String> get timeDisplay => Rx.combineLatest2<Duration, Duration, String>(durationTime, position,
    (duration, position) =>
      position.inMinutes.toString() +
      ':' +
      position.inSeconds.toString() +
      ' / ' +
      duration.inMinutes.toString() +
      ':' +
      duration.inSeconds.toString()
  );

  VideoManagerVlc(
      SpeechModel speechModel, bool isNormalSpeech, WakelockService wakelock)
      : super(speechModel, isNormalSpeech, wakelock) {
    controller = VlcPlayerController.network(
        speechModel.videoUrl.replaceAll("&nolimit=1", ""),
        hwAcc: HwAcc.FULL,
        options: VlcPlayerOptions(
          advanced: VlcAdvancedOptions([
            VlcAdvancedOptions.networkCaching(2000),
          ]),
          subtitle: VlcSubtitleOptions([
            VlcSubtitleOptions.boldStyle(true),
            VlcSubtitleOptions.fontSize(30),
            VlcSubtitleOptions.outlineColor(VlcSubtitleColor.yellow),
            VlcSubtitleOptions.outlineThickness(VlcSubtitleThickness.normal),
            // works only on externally added subtitles
            VlcSubtitleOptions.color(VlcSubtitleColor.navy),
          ]),
          rtp: VlcRtpOptions([
            VlcRtpOptions.rtpOverRtsp(true),
          ]),
        ),

    );

    controller!.addOnInitListener(() async {
      await controller.startRendererScanning();
    });

    controller.addListener(() async {
      if (await controller.isPlaying() == true) {
        wakelock.tryToEnableLock();
      }

      if (controller.value.isInitialized) {
        durationTime.add(controller.value.duration);

        position.add(controller.value.position);
      }

      isVideoPlaying.add(controller.value.isPlaying);
    });
  }

  @override
  Widget buildVideoWidget() {
    final url = speechModel.videoUrl.replaceAll("&nolimit=1", "").substring(0, speechModel.videoUrl.indexOf('&name='));
    BetterPlayerConfiguration betterPlayerConfiguration =
    BetterPlayerConfiguration(
      aspectRatio: 16 / 9,
      fit: BoxFit.contain,
    );
    BetterPlayerDataSource dataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network, url,
        useAsmsSubtitles: true, useAsmsTracks: true,
    );
    final betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
    betterPlayerController.setupDataSource(dataSource);
    return BetterPlayer(controller: betterPlayerController);
    // return VlcPlayerWithControls(controller: controller);
    // return GestureDetector(
    //   onTap: () => toggleOverlay(),
    //   child:
    //   return Stack(
    //     children: [
    //       // GestureDetector(
    //       //     child:
    //           VlcPlayer(
    //             controller: controller,
    //             aspectRatio: 16 / 9,
    //             placeholder: Container(
    //                 width: double.infinity,
    //                 height: double.infinity,
    //                 child: Center(
    //                   child: CircularProgressIndicator(),
    //                 )
    //             ),
    //           ),
    //           // onTap: () => toggleOverlay()
    //       // ),
    //       StreamProvider.value(
    //         initialData: true,
    //         value: overlayVisibility,
    //         child: Consumer<bool>(
    //           builder: (context, visible, _) => visible
    //               ? buildOverlay()
    //               : getEmptyContainer(),
    //         ),
    //       )
    //     ],
    //   // )
    // );
    // return Stack(
    //   children: [
    //     GestureDetector(
    //       child: VlcPlayer(
    //         controller: controller,
    //         aspectRatio: 16 / 9,
    //         placeholder: Container(
    //           width: double.infinity,
    //           height: double.infinity,
    //           child: Center(
    //             child: CircularProgressIndicator(),
    //           )
    //         ),
    //       ),
    //       onTap: () => toggleOverlay()
    //     ),
    //     StreamProvider.value(
    //       initialData: false,
    //       value: overlayVisibility,
    //       child: Consumer<bool>(
    //         builder: (context, visible, _) => visible
    //           ? buildOverlay()
    //           : getEmptyContainer(),
    //       ),
    //     )
    //   ],
    // );
  }

  // void toggleOverlay() {
  //   overlayVisibility.add(!overlayVisibility.value);
  // }
  //
  // Widget getEmptyContainer () {
  //   return Container(
  //     width: 0,
  //     height: 0,
  //   );
  // }
  //
  // Widget buildOverlay() {
  //   return Container(
  //     // height: double.infinity,
  //     width: double.infinity,
  //     decoration: BoxDecoration(
  //       color: Colors.black.withOpacity(0.7)
  //     ),
  //     child: Column(
  //       children: [
  //         Expanded(
  //             flex: 7,
  //             child: buildPauseButton(),
  //         ),
  //         Expanded(
  //             flex: 3,
  //             child: buildTimelineBottomBar()
  //         )
  //       ],
  //     ),
  //   );
  // }
  //
  // Widget buildPauseButton() {
  //   return Center(
  //     child: StreamProvider.value(
  //       value: isVideoPlaying,
  //       initialData: false,
  //       child: Consumer<bool>(
  //         builder: (context, isPlaying, _) => isPlaying
  //           ? Icon(
  //             Icons.pause_circle_filled,
  //             size: 30,
  //             color: Colors.white,
  //           )
  //           : Icon(
  //             Icons.play_circle_filled,
  //             size: 30,
  //             color: Colors.white,
  //           )
  //       ),
  //     )
  //   );
  // }
  //
  // Widget buildTimelineBottomBar() {
  //   return Container(
  //     padding: EdgeInsets.only(left: 8, right: 8),
  //     child: Column(
  //       children: [
  //         buildTimeline(),
  //         buildTimelineControls()
  //       ],
  //     ),
  //   );
  // }
  //
  // Widget buildTimeline() {
  //   return StreamProvider.value(
  //       value: timelineValue,
  //       initialData: 0.0,
  //       child: Consumer<double>(
  //         builder: (context, sliderValue, _) =>
  //             Slider(
  //               value: sliderValue,
  //               min: 0.0,
  //               max: 100.0,
  //               onChanged: (position) => tryToSeekPosition(position),
  //             )
  //       ),
  //   );
  // }
  //
  // Widget buildTimelineControls() {
  //   return Row(
  //     children: [
  //       StreamProvider.value(
  //         value: isVideoPlaying,
  //         initialData: false,
  //         child: Consumer<bool>(
  //           builder: (context, isVideoPlaying, _) => isVideoPlaying
  //             ? Icon(
  //                 Icons.play_arrow
  //               )
  //             : Icon(
  //               Icons.pause
  //             )
  //         ),
  //       ),
  //       StreamProvider.value(
  //         value: timeDisplay,
  //         initialData: '0:00 / 0:00',
  //         child: Consumer<String>(
  //             builder: (context, timeDisplay, _) => Text(
  //               timeDisplay
  //             )
  //         ),
  //       ),
  //       Expanded(child: Container()),
  //     ],
  //   );
  // }
  //
  // tryToSeekPosition(double seekTo) async {
  //   final Duration videoDuration = await durationTime.stream.first;
  //
  //   if (seekTo > 100) {
  //     controller.seekTo(videoDuration);
  //   } else if (seekTo <= 0) {
  //     controller.seekTo(Duration.zero);
  //   } else {
  //     final Duration seekDestination = Duration(milliseconds: (videoDuration.inMilliseconds * seekTo).floor());
  //
  //     controller.seekTo(seekDestination);
  //   }
  // }

  @override
  void dispose() {
    overlayVisibility.close();
    isVideoPlaying.close();

    controller.stopRendererScanning();
    controller.dispose();
    super.dispose();
  }
}
