import 'package:project_athens/athens_core/domain/item_was_seen/speech_was_seen_use_case.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/models/speech_model.dart';
import 'package:project_athens/athens_core/presentation/base_blocs/base_bloc.dart';
import 'package:project_athens/athens_core/presentation/data_loading/data_loading_state.dart';
import 'package:project_athens/athens_core/presentation/widget_state.dart';
import 'package:project_athens/deputies_utils/cache/deputies_cache.dart';
import 'package:project_athens/deputies_utils/domain/deputy_model.dart';
import 'package:project_athens/main/wakelock/wakelock_service.dart';
import 'package:project_athens/speeches_flow/domain/get_speech_use_case.dart';
import 'package:project_athens/speeches_flow/navigation/speeches_destinations.dart';
import 'package:project_athens/speeches_flow/screens/details/video_widget/managers/video_manager.dart';
import 'package:project_athens/speeches_flow/screens/details/video_widget/managers/video_manager_factory.dart';

class SpeechDetailsBloc extends BaseBloc {

  final bool isNormalSpeech;

  final GetSpeechUseCase _getSpeechUseCase;

  final DeputiesCache _deputiesCache;

  final WakelockService _wakelock;

  final SpeechWasSeenUseCase _speechWasSeenUseCase;

  SpeechDetailsBloc(this.isNormalSpeech, this._getSpeechUseCase, this._deputiesCache, this._wakelock, this._speechWasSeenUseCase) {
    _getSpeechModel();
  }

  late SpeechModel _speechModel;
  SpeechModel get speechModel => _speechModel;

  late DeputyModel _deputyModel;
  DeputyModel get deputyModel => _deputyModel;

  late VideoManager _videoManager;
  VideoManager get videoManager => _videoManager;

  Future<void> _getSpeechModel() async {
    final result = await _getSpeechUseCase(null);

    if (result is Success<SpeechModel>) {
      _speechModel = result.value;
      _videoManager = VideoManagerFactory.create(speechModel, isNormalSpeech, _wakelock);

      await _initDeputyModel();
      setLoadingState(DataLoadingState.contentLoaded());
      _speechWasSeenUseCase(result.value.id);
    }
    manageState(result);
  }

  Future<void> _initDeputyModel() async {
    if (speechModel.deputyId != null)
      _deputyModel = await _deputiesCache.getDeputyModelById(speechModel.deputyId!);
  }

  void goToNextSpeech() {
    final destination = SpeechDetailsDestination(speechModel.nextPersonSpeech!.speechId, isNormalSpeech, replace: true);
    stateController.add(WidgetState.redirection(destination, replaceBottomNavItem: false));
  }

  void goToPreviousSpeech() {
    final destination = SpeechDetailsDestination(speechModel.previousPersonSpeech!.speechId, isNormalSpeech, replace: true);
    stateController.add(WidgetState.redirection(destination, replaceBottomNavItem: false));
  }

  @override
  void dispose() {
    videoManager.dispose();

    // due to flick video player is disabling wakelock via direct Wakelock
    // reference we have to manually check whether we should restore wakelock
    _wakelock.shouldLock();
    super.dispose();
  }

}
