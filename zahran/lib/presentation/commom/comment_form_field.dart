import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:reusable/reusable.dart';
import 'package:zahran/data/repo/base.repo.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/commom/media_picker/MediaFileTypes.dart';
import 'package:zahran/presentation/commom/voices/voice_note.pm.dart';
import 'package:zahran/presentation/localization/tr.dart';
import 'package:zahran/presentation/navigation/screen_router.dart';
import 'package:zahran/r.dart';

import 'flare_component.dart';
import 'media_picker/media_picker.pm.dart';
import 'media_view/media_view.dart';

class CommentFormField extends StatefulWidget {
  final CommentModel? intialValue;
  final FormFieldSetter<CommentModel> onChanged;
  final bool optional;
  const CommentFormField({
    Key? key,
    this.intialValue,
    required this.onChanged,
    this.optional = true,
  }) : super(key: key);

  @override
  _CommentFormFieldState createState() => _CommentFormFieldState();
}

class _CommentFormFieldState extends State<CommentFormField>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return FormField<CommentModel>(
      initialValue: widget.intialValue,
      onSaved: widget.onChanged,
      validator: (CommentModel? v) =>
          widget.optional || v?.comment.isNullOrEmptyOrWhiteSpace != true
              ? null
              : ReusableLocalizations.of(context)?.requiredField,
      builder: (FormFieldState<CommentModel> field) {
        var media = (field.value?.media ?? []);
        return AnimatedSize(
          duration: Duration(milliseconds: 300),
          alignment: Alignment.topCenter,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                TR.of(context).comment,
                style: context.bodyText1,
              ),
              SizedBox(height: 10),
              _buildFields(context, field),
              if (media.length > 0) ...[
                SizedBox(height: 10),
                MediaView(
                  media: media,
                  onDelete: (e) {
                    field.didChange(field.value?.copyWith(
                        media: (old) => old
                            .where((element) => element.id != e.id)
                            .toList()));
                    widget.onChanged(field.value);
                  },
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Row _buildFields(BuildContext context, FormFieldState<CommentModel> field) {
    return Row(
      crossAxisAlignment:
          field.hasError ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        _buildTextField(context, field),
        SizedBox(width: 10),
        _buildButton(
          context: context,
          field: field,
          child: IconButton(
            onPressed: () => selectMedia(field),
            padding: EdgeInsets.zero,
            icon: Image.asset(R.assetsImgsCamera),
          ),
        ),
        SizedBox(width: 10),
        _buildButton(
          context: context,
          field: field,
          child: IconButton(
            onPressed: () => recordVoiceNote(field),
            padding: EdgeInsets.zero,
            icon: Image.asset(R.assetsImgsMic),
          ),
        ),
      ],
    );
  }

  Widget _buildButton({
    required BuildContext context,
    required FormFieldState<CommentModel> field,
    required Widget child,
  }) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      decoration: BoxDecoration(
        border: Border.all(
          color: field.hasError
              ? Theme.of(context).errorColor
              : Colors.transparent,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: child,
    );
  }

  Expanded _buildTextField(
      BuildContext context, FormFieldState<CommentModel> field) {
    return Expanded(
      child: CustomTextField.decoration(
        validator: (v) => null,
        decoration: InputDecoration(
          hintText: TR.of(context).enter_decription_here,
          errorText: field.errorText,
        ),
        initialValue: field.value?.comment,
        onChanged: (v) {
          field.didChange(field.value?.copyWith(comment: v) ??
              CommentModel(comment: v ?? ''));
          widget.onChanged(field.value);
        },
      ),
    );
  }

  Future<void> recordVoiceNote(FormFieldState<CommentModel> field) async {
    ScreenRouter.showBottomSheet(
        type: BottomSheetNames.VOICE_NOTE,
        parameters:
            _prepareVoiceNoteParameter(voiceNoteIntent: VoiceNoteIntent.Record),
        actionsCallbacks: _prepareVoiceNoteActions(field: field));
  }

  Future<void> playVoiceNote(Media media) async {
    ScreenRouter.showBottomSheet(
        type: BottomSheetNames.VOICE_NOTE,
        parameters: _prepareVoiceNoteParameter(
            voiceNoteIntent: VoiceNoteIntent.Play,
            voiceNoteUrl: media.mediaPath),
        actionsCallbacks: _prepareVoiceNoteActions());
  }

  Map<String, dynamic>? _prepareVoiceNoteParameter(
      {required VoiceNoteIntent voiceNoteIntent,
      File? voiceNoteFile,
      String? voiceNoteUrl}) {
    Map<String, dynamic>? parameters = Map();
    parameters["voiceNoteIntent"] = voiceNoteIntent;
    parameters["voiceNoteFile"] = voiceNoteFile;
    parameters["voiceNoteUrl"] = voiceNoteUrl;
    return parameters;
  }

  Map<String, Function> _prepareVoiceNoteActions(
      {FormFieldState<CommentModel>? field}) {
    Map<String, Function> actionsCallbacks = Map();
    actionsCallbacks['onAcceptNoteCallback'] = (File? file) async {
      ScreenRouter.pop();
      print("🚀🚀🚀🚀 onAcceptNoteCallback done with file $file}");
      var mediaModel = MediaLocal(
        mediaFile: file!,
        mediaFileTypes: MediaFileTypes.AUDIO,
        fileName: path.basename(file.path),
      );

      try {
        var result = await FlareAnimation.show(
          action: (notifier) => mediaModel.compressAndUpload(
            notifier: notifier,
            upload: (file, onProgress) async {
              return await Repos.mediaRepo.uploadMedia(
                uploadedFile: file,
                mediaFileTypes: mediaModel.mediaFileTypes,
                onProgress: onProgress,
              );
            },
          ),
          context: context,
        );
        if (field != null) {
          field.didChange(
              field.value?.copyWith(media: (old) => [...old, result!]) ??
                  CommentModel(media: [result!]));
          widget.onChanged(field.value);
        }
      } catch (e) {}
    };
    actionsCallbacks['onCloseNoteCallback'] =
        () => {ScreenRouter.pop(), print("🚀🚀🚀🚀 On Close Note Callback")};
    actionsCallbacks['onRemoveNoteCallback'] =
        () => {ScreenRouter.pop(), print("🚀🚀🚀🚀 On Remove Note Callback")};

    return actionsCallbacks;
  }

  Future<void> selectMedia(FormFieldState<CommentModel> field) async {
    ScreenRouter.showPopup(
        type: PopupsNames.MEDIA_PICKER_POPUP,
        parameters: {
          "pickerType": MediaPickerType.BOTH,
        },
        actionsCallbacks: _prepareMediaAction(field));
  }

  Map<String, Function> _prepareMediaAction(
    FormFieldState<CommentModel> field,
  ) {
    Map<String, Function> actionsCallbacks = Map();
    actionsCallbacks['mediaPickerCallback'] =
        (BuildContext context, MediaLocal? mediaModel) async {
      try {
        var result = await FlareAnimation.show(
          action: (notifier) async {
            try {
              return await mediaModel?.compressAndUpload(
                notifier: notifier,
                upload: (file, onProgress) async {
                  return await Repos.mediaRepo.uploadMedia(
                    uploadedFile: file,
                    mediaFileTypes: mediaModel.mediaFileTypes,
                    onProgress: onProgress,
                  );
                },
              );
            } catch (e) {
              rethrow;
            }
          },
          context: context,
        );
        field.didChange(
            field.value?.copyWith(media: (old) => [...old, result!]) ??
                CommentModel(media: [result!]));
        widget.onChanged(field.value);
      } catch (e) {
        print(e);
      }
    };
    actionsCallbacks['dismissCallback'] =
        () => {print("🚀🚀🚀🚀 User Dismissed")};
    return actionsCallbacks;
  }
}
