import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound_platform_interface/flutter_sound_recorder_platform_interface.dart';
import 'package:zahran/presentation/external/sound_engine/sound_engine.manager.dart';

class SoundEngineManagerImpl implements SoundEngineManager {
  static const int SUBSCRIPTION_DURATION_IN_MILLISECONDS = 100;
  FlutterSoundPlayer _flutterSoundPlayer;
  FlutterSoundRecorder _flutterSoundRecorder;

  SoundEngineManagerImpl()
      : _flutterSoundPlayer = FlutterSoundPlayer(),
        _flutterSoundRecorder = FlutterSoundRecorder();

  @override
  AudioState get audioState {
    AudioState result = AudioState.None;
    if (_flutterSoundRecorder.recorderState == RecorderState.isRecording) {
      result = AudioState.Recording;
    } else if (_flutterSoundPlayer.playerState == PlayerState.isStopped) {
      result = AudioState.Stopped;
    } else if (_flutterSoundPlayer.playerState == PlayerState.isPaused) {
      result = AudioState.Paused;
    } else if (_flutterSoundPlayer.playerState == PlayerState.isPlaying) {
      result = AudioState.Playing;
    }
    return result;
  }

  @override
  Stream<PlaybackEvent> get onPlayerStateChanged {
    return _flutterSoundPlayer.onProgress!.map((event) => PlaybackEvent(event.duration, event.position, 0.0));
  }

  @override
  Stream<PlaybackEvent> get onRecorderStateChanged =>
      _flutterSoundRecorder.onProgress!.map((event) => PlaybackEvent(Duration(), event.duration, event.decibels!));

  @override
  Future<void> startRecorder({required String uri}) async {
    await _flutterSoundRecorder.openAudioSession(
        focus: AudioFocus.requestFocusAndDuckOthers,
        category: SessionCategory.playAndRecord,
        mode: SessionMode.modeDefault,
        device: AudioDevice.speaker,
        audioFlags: outputToSpeaker | allowBlueToothA2DP | allowAirPlay);
    _flutterSoundRecorder.setSubscriptionDuration(Duration(milliseconds: SUBSCRIPTION_DURATION_IN_MILLISECONDS));
    return _flutterSoundRecorder.startRecorder(toFile: uri);
  }

  @override
  Future<String?> stopRecorder() {
    return _flutterSoundRecorder.stopRecorder();
  }

  @override
  Future<String> startPlayer({required String uri}) async {
    await _flutterSoundPlayer.openAudioSession(
        focus: AudioFocus.requestFocusAndDuckOthers,
        category: SessionCategory.playAndRecord,
        mode: SessionMode.modeDefault,
        device: AudioDevice.speaker,
        audioFlags: outputToSpeaker | allowBlueToothA2DP | allowAirPlay,
        withUI: true);
    _flutterSoundPlayer.setSubscriptionDuration(Duration(milliseconds: SUBSCRIPTION_DURATION_IN_MILLISECONDS));
    Duration? duration = await _flutterSoundPlayer.startPlayer(fromURI: uri);
    return duration.toString();
  }

  @override
  Future<void> stopPlayer() {
    return _flutterSoundPlayer.stopPlayer();
  }
}
