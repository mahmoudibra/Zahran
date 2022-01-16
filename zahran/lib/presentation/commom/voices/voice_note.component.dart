import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:zahran/presentation/commom/voices/voice_note.pm.dart';
import 'package:zahran/presentation/external/permission/permission_handler.manager.dart';
import 'package:zahran/presentation/external/permission/permission_handler.manager.impl.dart';
import 'package:zahran/presentation/external/sound_engine/sound_engine.manager.impl.dart';
import 'package:zahran/presentation/localization/tr.dart';

import '../app_loader.dart';
import '../toolbox.helper.dart';

typedef OnAcceptNoteCallback = Function({File? file});
typedef OnRemoveNoteCallback = Function();
typedef OnCloseNoteCallback = Function();

class VoiceNote extends StatefulWidget {
  final OnAcceptNoteCallback onAcceptNote;
  final OnRemoveNoteCallback onRemoveNote;
  final OnRemoveNoteCallback? onClose;
  final File? file;
  final String? audioUrl;
  final VoiceNoteIntent intent;

  final VoiceNotePM _voiceNotePM;

  VoiceNote(
      {required this.onAcceptNote,
      required this.onRemoveNote,
      required this.onClose,
      required this.intent,
      this.file,
      this.audioUrl})
      : assert(intent == VoiceNoteIntent.Record ||
            (intent != VoiceNoteIntent.Record && file != null) ||
            (intent != VoiceNoteIntent.Record && audioUrl != null)),
        assert(file == null || audioUrl == null),
        _voiceNotePM = VoiceNotePM(
            soundEngineManager: SoundEngineManagerImpl(),
            permissionHandlerManager: PermissionManagerImpl());

  @override
  _VoiceNoteState createState() => _VoiceNoteState();
}

class _VoiceNoteState extends State<VoiceNote> with TickerProviderStateMixin {
  // Data Members
  VoiceNotePMModel _viewState = VoiceNotePMModel.defaultValue();
  AnimationController? _audioLevelAnimationController;
  Tween<double>? _sizeAnimation;
  double _latestAudioLevel = 0.0;

  // Overrides
  @override
  void initState() {
    _audioLevelAnimationController = AnimationController(vsync: this);
    Future.delayed(Duration.zero).then((_) {
      _sizeAnimation =
          Tween(begin: 60.0, end: MediaQuery.of(context).size.width - 30);
      widget._voiceNotePM.init(
          intent: widget.intent, file: widget.file, audioUrl: widget.audioUrl);
    });
    super.initState();
  }

  @override
  void dispose() {
    widget._voiceNotePM.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        widget._voiceNotePM.stopPlayer();
        return Future.value(true);
      },
      child: Container(
        height: 300,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.0),
            topRight: Radius.circular(24.0),
          ),
        ),
        child: Material(
          type: MaterialType.transparency,
          child: StreamBuilder(
            stream: widget._voiceNotePM.voiceNoteState,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData && !snapshot.hasError) {
                _viewState = snapshot.data;
                return _resolveState(_viewState);
              } else
                return ViewsToolbox.emptyWidget();
            },
          ),
        ),
      ),
    );
  }

  // UI States
  Widget _drawStateResolvingPermission() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 60.0, width: 60.0, child: AppLoader()),
          Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: Text(
              TR.of(context).voice_note_status_resolving,
              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  color: Theme.of(context).textTheme.headline4?.color),
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawStateReady() {
    Widget secondaryActions;

    if (widget.intent == VoiceNoteIntent.Play)
      secondaryActions = _drawPlayActions();
    else
      secondaryActions = _drawPreviewAndRecordActions();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _drawPlaybackStatus(),
        _drawPlaybackDuration(),
        _drawMainAction(),
        _viewState.isRecording
            ? ViewsToolbox.emptyWidget()
            : Container(margin: EdgeInsets.all(20.0), child: secondaryActions)
      ],
    );
  }

  Widget _drawStateNeedPermission() {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(25.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset(
              'assets/images/mic-access.png',
            ),
            Padding(
              padding: EdgeInsets.only(top: 40, bottom: 16.0),
              child: Text(
                TR.of(context).permission_access_microphone_title,
                style: Theme.of(context).textTheme.headline6,
                textAlign: TextAlign.center,
              ),
            ),
            Text(
              TR.of(context).permission_access_microphone_message,
              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                  color: Theme.of(context).textTheme.bodyText2?.color),
              textAlign: TextAlign.center,
            ),
            ElevatedButton(
              onPressed: () {
                _onGoToSettings();
              },
              child:
                  Text(TR.of(context).permission_access_change_settings_button),
            ),
            ElevatedButton(
              onPressed: () {
                _onDismiss();
              },
              child: Text(TR.of(context).permission_access_dismiss_button),
            )
          ],
        ),
      ),
    );
  }

  Widget _drawStateRestricted() {
    return ViewsToolbox.emptyWidget();
  }

  // UI Builders
  Widget _drawPlaybackStatus() {
    return Padding(
      padding: EdgeInsets.only(left: 40.0, right: 40.0, top: 20),
      child: Text(
        _resolveMessage(_viewState.message),
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline4?.copyWith(
            color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _drawPlaybackDuration() {
    return Padding(
      padding: EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
      child: Text(
        _viewState.durationText,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }

  Widget _drawMainAction() {
    return Expanded(
      child: Stack(alignment: Alignment.center, children: [
        AspectRatio(
          aspectRatio: 1.0,
          child: AnimatedBuilder(
            animation: _audioLevelAnimationController!,
            builder: (cntx, child) {
              var sizeV =
                  (_sizeAnimation?.evaluate(_audioLevelAnimationController!)) ??
                      0.0;
              return Container(
                padding: EdgeInsets.all(15.0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: Opacity(
                    opacity: _audioLevelAnimationController!.value,
                    child: Container(
                      height: sizeV,
                      width: sizeV,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(500.0),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Container(
          height: 75.0,
          width: 75.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(40.0),
            border: Border.all(
              color: Theme.of(context).primaryColor,
              width: 3.0,
            ),
          ),
          child: IconButton(
            onPressed: _viewState.isRecording
                ? _onStopRecorder
                : (_viewState.isPlaying
                    ? _onStopNote
                    : (widget.audioUrl != null
                        ? _onPlayNoteFromUrl
                        : _onPlayNote)),
            icon: _viewState.isRecording
                ? Icon(Icons.stop)
                : (_viewState.isPlaying
                    ? Icon(Icons.pause)
                    : Icon(Icons.play_arrow)),
            color: Theme.of(context).primaryColor,
            iconSize: 30.0,
          ),
        )
      ]),
    );
  }

  Widget _drawPreviewAndRecordActions() {
    return Container(
      margin: EdgeInsets.only(bottom: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 48.0,
            width: 64.0,
            margin: EdgeInsetsDirectional.only(end: 20.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Theme.of(context).highlightColor,
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(
                    width: 1.0, color: Theme.of(context).primaryColor)),
            child: IconButton(
              icon: Icon(Icons.delete_forever),
              onPressed: _onRemoveNote,
              color: Theme.of(context).primaryColor,
            ),
          ),
          Container(
            height: 48.0,
            width: 64.0,
            margin: EdgeInsetsDirectional.only(end: 20.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Theme.of(context).highlightColor,
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(
                    width: 1.0, color: Theme.of(context).primaryColor)),
            child: IconButton(
              icon: Icon(Icons.save),
              onPressed: _onAcceptNote,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawPlayActions() {
    return GestureDetector(
      onTap: _onClose,
      child: Container(
        alignment: Alignment.center,
        height: 48.0,
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(20.0)),
        child: Text(
          TR.of(context).voice_note_dismiss_button,
          style: Theme.of(context)
              .textTheme
              .subtitle1
              ?.copyWith(color: Colors.white),
        ),
      ),
    );
  }

  // UI Events
  void _onStopRecorder() {
    _audioLevelAnimationController!.animateTo(0,
        duration: Duration(milliseconds: 50), curve: Curves.easeInOut);
    widget._voiceNotePM.stopRecorder();
  }

  void _onPlayNote() {
    widget._voiceNotePM.startPlayerFromFile(file: _viewState.audioFile);
  }

  void _onPlayNoteFromUrl() {
    widget._voiceNotePM.startPlayerFromURL(audioUrl: _viewState.audioUrl);
  }

  void _onStopNote() {
    widget._voiceNotePM.stopPlayer();
  }

  void _onAcceptNote() {
    widget._voiceNotePM.stopPlayer();
    widget._voiceNotePM.reset();
    widget.onAcceptNote(file: _viewState.audioFile);
  }

  void _onRemoveNote() {
    widget._voiceNotePM.stopPlayer();
    widget._voiceNotePM.reset(clear: true);
    widget.onRemoveNote();
  }

  void _onClose() {
    widget._voiceNotePM.stopPlayer();
    widget._voiceNotePM.reset();
    widget.onClose?.call();
  }

  void _onGoToSettings() {
    widget._voiceNotePM.openAppSettings();
  }

  void _onDismiss() {
    if (widget.onClose != null) widget.onClose?.call();
  }

  // Helpers
  Widget _resolveState(VoiceNotePMModel model) {
    Widget view = ViewsToolbox.emptyWidget();

    switch (model.permissionState) {
      case PermissionState.Resolving:
        view = _drawStateResolvingPermission();
        break;
      case PermissionState.Granted:
        view = _drawStateReady();
        if (_viewState.audioLevel != _latestAudioLevel) {
          _audioLevelAnimationController!.animateTo(_viewState.audioLevel,
              duration: Duration(milliseconds: 50), curve: Curves.easeInOut);
          _latestAudioLevel = _viewState.audioLevel;
        }
        break;
      case PermissionState.Denied:
        view = _drawStateNeedPermission();
        break;
      case PermissionState.Restricted:
        view = _drawStateRestricted();
        break;
      default:
    }

    return view;
  }

  String _resolveMessage(VoiceNoteModelMessage? message) {
    String messageText = '';
    switch (message ?? VoiceNoteModelMessage.Recording) {
      case VoiceNoteModelMessage.Recorded:
        messageText = TR.of(context).voice_note_status_stopped;
        break;
      case VoiceNoteModelMessage.Recording:
        messageText = TR.of(context).voice_note_status_recording;
        break;
      case VoiceNoteModelMessage.Playing:
        messageText = TR.of(context).voice_note_status_playing;
        break;
      case VoiceNoteModelMessage.Played:
        messageText = TR.of(context).voice_note_status_played;
        break;
    }
    return messageText;
  }
}
