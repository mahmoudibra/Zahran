//TODO: migrate to new version.
//
// class SoundEngineManagerImpl implements SoundEngineManager {
//   final FlutterSound _flutterSound;
//
//   SoundEngineManagerImpl() : _flutterSound = FlutterSound();
//
//   @override
//   AudioState get audioState {
//     AudioState result;
//     switch (_flutterSound.audioState) {
//       case t_AUDIO_STATE.IS_STOPPED:
//         result = AudioState.Stopped;
//         break;
//       case t_AUDIO_STATE.IS_PAUSED:
//         result = AudioState.Paused;
//         break;
//       case t_AUDIO_STATE.IS_PLAYING:
//         result = AudioState.Playing;
//         break;
//       case t_AUDIO_STATE.IS_RECORDING:
//         result = AudioState.Recording;
//         break;
//     }
//     return result;
//   }
//
//   @override
//   Stream<PlaybackEvent> get onPlayerStateChanged => _flutterSound
//       .onPlayerStateChanged
//       .map((event) => PlaybackEvent(event?.duration, event?.currentPosition));
//
//   @override
//   Stream<double> get onRecorderDbPeakChanged =>
//       _flutterSound.onRecorderDbPeakChanged;
//
//   @override
//   Stream<double> get onRecorderStateChanged =>
//       _flutterSound.onRecorderStateChanged
//           .map((event) => event?.currentPosition);
//
//   @override
//   Future<String> setDbLevelState({bool state}) {
//     return _flutterSound.setDbLevelEnabled(state);
//   }
//
//   @override
//   Future<String> setDbPeakLevelUpdate({double level}) {
//     return _flutterSound.setDbPeakLevelUpdate(level);
//   }
//
//   @override
//   Future<String> setSubscriptionDuration({double seconds}) {
//     return _flutterSound.setSubscriptionDuration(seconds);
//   }
//
//   @override
//   Future<String> startRecorder({String uri}) {
//     return _flutterSound.startRecorder(uri: uri, iosQuality: IosQuality.MEDIUM);
//   }
//
//   @override
//   Future<String> stopRecorder() {
//     return _flutterSound.stopRecorder();
//   }
//
//   @override
//   Future<String> startPlayer({String uri}) {
//     return _flutterSound.startPlayer(uri);
//   }
//
//   @override
//   Future<String> stopPlayer() {
//     return _flutterSound.stopPlayer();
//   }
// }

class PlaybackEvent {
  final double duration;
  final double progress;

  PlaybackEvent(this.duration, this.progress);

  @override
  String toString() {
    return 'PlaybackEvent(duration: $duration, progress: $progress)';
  }
}

enum AudioState { Stopped, Paused, Playing, Recording }
