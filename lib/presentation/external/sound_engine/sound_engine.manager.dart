abstract class SoundEngineManager {
  AudioState get audioState;

  Stream<double> get onRecorderStateChanged;

  Stream<PlaybackEvent> get onPlayerStateChanged;

  Stream<double> get onRecorderDbPeakChanged;

  Future<String> setDbLevelState({bool state});

  Future<String> setDbPeakLevelUpdate({double level});

  Future<String> setSubscriptionDuration({double seconds});

  Future<String> startRecorder({String uri});

  Future<String> stopRecorder();

  Future<String> startPlayer({String uri});

  Future<String> stopPlayer();
}

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
