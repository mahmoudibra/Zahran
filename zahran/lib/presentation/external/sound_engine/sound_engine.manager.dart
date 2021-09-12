abstract class SoundEngineManager {
  AudioState? get audioState;

  Stream<PlaybackEvent> get onRecorderStateChanged;

  Stream<PlaybackEvent> get onPlayerStateChanged;

  Future<void> startRecorder({required String uri});

  Future<String?> stopRecorder();

  Future startPlayer({required String uri});

  Future<void> stopPlayer();
}

class PlaybackEvent {
  final Duration duration;
  final Duration progress;
  final double decibels;

  PlaybackEvent(this.duration, this.progress, this.decibels);

  @override
  String toString() {
    return 'PlaybackEvent(duration: $duration, progress: $progress)';
  }
}

enum AudioState { Stopped, Paused, Playing, Recording, None }
