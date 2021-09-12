import 'dart:io';

import 'package:zahran/presentation/commom/voices/voice_note.pm.dart';

class VoiceNoteModel {
  VoiceNoteIntent voiceNoteIntent;
  File? file;
  String? audioUrl;
  Function onAcceptVoiceNote;
  Function onRemoveVoiceNote;
  Function onClose;

  VoiceNoteModel(
      {required this.voiceNoteIntent,
      this.file,
      this.audioUrl,
      required this.onAcceptVoiceNote,
      required this.onRemoveVoiceNote,
      required this.onClose});
}
