import 'dart:async';
import 'dart:io';

import 'package:rxdart/subjects.dart';
import 'package:zahran/presentation/external/permission/permission_handler.manager.dart';
import 'package:zahran/presentation/external/sound_engine/sound_engine.manager.dart';
import 'package:zahran/presentation/external/sound_engine/sound_engine.manager.impl.dart';
import 'package:zahran/presentation/helpers/date/date-manager.dart';

class VoiceNotePM {
  final SoundEngineManagerImpl _soundEngineManager;
  final PermissionManager _permissionHandlerManager;

  BehaviorSubject<VoiceNotePMModel> _voiceNoteState = BehaviorSubject.seeded(VoiceNotePMModel.defaultValue());

  VoiceNotePM({required SoundEngineManagerImpl soundEngineManager, required PermissionManager permissionHandlerManager})
      : this._soundEngineManager = soundEngineManager,
        this._permissionHandlerManager = permissionHandlerManager;

  // Getters
  Stream<VoiceNotePMModel> get voiceNoteState => _voiceNoteState.stream;

  // Actions
  void init({required VoiceNoteIntent intent, File? file, String? audioUrl}) {
    assert(intent == VoiceNoteIntent.Record ||
        (intent != VoiceNoteIntent.Record && file != null) ||
        (intent != VoiceNoteIntent.Record && audioUrl != null));

    assert(file == null || audioUrl == null);

    if (intent == VoiceNoteIntent.Record)
      _permissionHandlerManager.checkPermission(service: PermissionType.Microphone).then(_onPermissionResolved);
    else {
      _voiceNoteState.add(VoiceNotePMModel.copyWith(
          origin: _voiceNoteState.value,
          audioFile: file,
          audioUrl: audioUrl,
          permissionState: PermissionState.Granted));
      file != null ? startPlayer(file: file) : startPlayerFromURL(audioUrl: audioUrl);
    }
  }

  void stopRecorder() {
    if (_soundEngineManager.audioState != AudioState.Recording) return;

    _soundEngineManager.stopRecorder();
    _voiceNoteState.add(VoiceNotePMModel.copyWith(
        origin: _voiceNoteState.value, isRecording: false, message: VoiceNoteModelMessage.Recorded, audioLevel: 0.0));
  }

  void startPlayer({required File? file}) {
    assert(file != null);

    _soundEngineManager.startPlayer(uri: _voiceNoteState.value.audioFile!.path).then(_onPlayerStarted);

    _voiceNoteState.add(VoiceNotePMModel.copyWith(
        origin: _voiceNoteState.value, isPlaying: true, message: VoiceNoteModelMessage.Playing, audioFile: file));
  }

  void startPlayerFromURL({required String? audioUrl}) {
    assert(audioUrl != null);

    _soundEngineManager.startPlayer(uri: _voiceNoteState.value.audioUrl ?? "").then(_onPlayerStarted);

    _voiceNoteState.add(VoiceNotePMModel.copyWith(
        origin: _voiceNoteState.value, isPlaying: true, message: VoiceNoteModelMessage.Playing, audioUrl: audioUrl));
  }

  void stopPlayer() {
    if (_soundEngineManager.audioState == AudioState.Playing ||
        (_voiceNoteState.value.playbackEvent?.duration != null &&
            _voiceNoteState.value.playbackEvent?.progress != null &&
            _voiceNoteState.value.playbackEvent!.duration == _voiceNoteState.value.playbackEvent!.progress)) {
      _voiceNoteState.add(
        VoiceNotePMModel.copyWith(
          origin: _voiceNoteState.value,
          isPlaying: false,
          message: VoiceNoteModelMessage.Played,
        ),
      );
    }
    if (_soundEngineManager.audioState == AudioState.Playing) {
      _soundEngineManager.stopPlayer();
    }
  }

  Future reset({bool clear = false}) {
    if (clear) return _removeTempFile();
    _voiceNoteState.add(VoiceNotePMModel.defaultValue());
    return Future.value();
  }

  void dispose() {
    _voiceNoteState.close();
  }

  void openAppSettings() {
    _permissionHandlerManager.openSettings();
  }

  // Events
  void _onPermissionResolved(PermissionState permissionState) {
    _voiceNoteState.add(VoiceNotePMModel.copyWith(origin: _voiceNoteState.value, permissionState: permissionState));
    if (permissionState == PermissionState.Granted) _startRecorder();
  }

  void _onRecorderStarted() {
    _soundEngineManager.onRecorderStateChanged.forEach((progress) {
      _updateTextTime(progress);
      _onRecorderDbPeakChanged(progress.decibels);
    });
  }

  void _onRecorderDbPeakChanged(double level) {
    if (level == null) return;
    _voiceNoteState.add(VoiceNotePMModel.copyWith(
        origin: _voiceNoteState.value, audioLevel: _normalize(value: level, minValue: 0, limitDelta: 160)));
  }

  void _onPlayerStarted(String _) {
    _soundEngineManager.onPlayerStateChanged.forEach(_onPlayerStateChanged);
  }

  void _onPlayerStateChanged(PlaybackEvent event) {
    _updateTextTime(event);

    if (_voiceNoteState.value.playbackEvent?.duration != null &&
        _voiceNoteState.value.playbackEvent?.progress != null &&
        (_voiceNoteState.value.playbackEvent!.duration - _voiceNoteState.value.playbackEvent!.progress <
            Duration(milliseconds: 100))) stopPlayer();
  }

  // Helpers
  Future<void> _startRecorder() async {
    await _createTempFile();

    _voiceNoteState.add(VoiceNotePMModel.copyWith(
        origin: _voiceNoteState.value, isRecording: true, message: VoiceNoteModelMessage.Recording));

    return _soundEngineManager
        .startRecorder(uri: _voiceNoteState.value.audioFile!.path)
        .then((value) => _onRecorderStarted());
  }

  Future _createTempFile() async {
    Directory tempDir = await Directory.systemTemp.createTemp();
    _voiceNoteState.add(VoiceNotePMModel.copyWith(
        origin: _voiceNoteState.value,
        audioFile: File('${tempDir?.path}/${DateTime.now().millisecondsSinceEpoch}order-voice-memo.aac')));
  }

  Future _removeTempFile() {
    if (_voiceNoteState.value.audioFile != null) {
      return _voiceNoteState.value.audioFile!.delete();
    }
    return Future.value();
  }

  double _normalize({required double value, required double minValue, required double limitDelta}) {
    double result = (value - minValue) / limitDelta;
    if (result > 1.0) return 1.0;
    if (result < 0.0) return 0.0;
    return result;
  }

  String _stringifyMillisecondsDuration(int milliseconds) {
    DateTime date = new DateTime.fromMillisecondsSinceEpoch(milliseconds);
    return DateTimeManager.getTimerFormat(date);
  }

  void _updateTextTime(PlaybackEvent event) {
    if (event?.progress == null) return;

    _voiceNoteState.add(VoiceNotePMModel.copyWith(
        origin: _voiceNoteState.value,
        durationText: _stringifyMillisecondsDuration(event.progress.inMilliseconds),
        playbackEvent: event));
  }
}

enum VoiceNoteIntent { Play, Preview, Record }

enum VoiceNoteModelMessage { Recorded, Recording, Playing, Played }

class VoiceNotePMModel {
  final File? audioFile;
  final String? audioUrl;
  final bool isRecording;
  final bool isPlaying;
  final double audioLevel;
  final VoiceNoteModelMessage? message;
  final String durationText;
  final PermissionState permissionState;
  final PlaybackEvent? playbackEvent;

  VoiceNotePMModel(
      {this.audioFile,
      this.audioUrl,
      required this.isRecording,
      required this.isPlaying,
      required this.audioLevel,
      this.message,
      required this.durationText,
      required this.permissionState,
      this.playbackEvent});

  factory VoiceNotePMModel.defaultValue() {
    return VoiceNotePMModel(
        isRecording: false,
        isPlaying: false,
        audioLevel: 0.0,
        durationText: '00:00',
        permissionState: PermissionState.Resolving);
  }

  factory VoiceNotePMModel.copyWith(
      {required VoiceNotePMModel origin,
      File? audioFile,
      String? audioUrl,
      bool? isRecording,
      bool? isPlaying,
      double? audioLevel,
      VoiceNoteModelMessage? message,
      String? durationText,
      PermissionState? permissionState,
      PlaybackEvent? playbackEvent}) {
    return VoiceNotePMModel(
        audioFile: audioFile ?? origin.audioFile,
        audioUrl: audioUrl ?? origin.audioUrl,
        isRecording: isRecording ?? origin.isRecording,
        isPlaying: isPlaying ?? origin.isPlaying,
        audioLevel: audioLevel ?? origin.audioLevel,
        message: message ?? origin.message,
        durationText: durationText ?? origin.durationText,
        permissionState: permissionState ?? origin.permissionState,
        playbackEvent: playbackEvent ?? origin.playbackEvent);
  }

  @override
  String toString() {
    return 'VoiceNotePMModel(audioFile: ${audioFile?.path}, audioUrl: $audioUrl, isRecording: $isRecording, isPlaying: $isPlaying, audioLevel: $audioLevel, message: $message, durationText: $durationText, permissionState: $permissionState, playbackEvent: $playbackEvent)';
  }
}
