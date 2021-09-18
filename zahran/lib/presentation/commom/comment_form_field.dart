import 'dart:io';

import 'package:flutter/material.dart';
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

class _CommentFormFieldState extends State<CommentFormField> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return FormField(
      initialValue: widget.intialValue,
      onSaved: widget.onChanged,
      validator: (v) => widget.optional || v != null ? null : ReusableLocalizations.of(context)?.requiredField,
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
                    field.didChange(
                        field.value?.copyWith(media: (old) => old.where((element) => element.id != e.id).toList()));
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
      children: [
        _buildTextField(context, field),
        SizedBox(width: 10),
        IconButton(
          onPressed: () => selectImage(field),
          padding: EdgeInsets.zero,
          icon: Image.asset(R.assetsImgsCamera),
        ),
        SizedBox(width: 10),
        IconButton(
          onPressed: () => recordVoiceNote(field),
          padding: EdgeInsets.zero,
          icon: Image.asset(R.assetsImgsMic),
        ),
      ],
    );
  }

  Expanded _buildTextField(BuildContext context, FormFieldState<CommentModel> field) {
    return Expanded(
      child: CustomTextField(
        validator: (v) => null,
        hint: TR.of(context).enter_decription_here,
        initialValue: field.value?.comment,
        onChanged: (v) {
          field.didChange(field.value?.copyWith(comment: v) ?? CommentModel(comment: v ?? ''));
          widget.onChanged(field.value);
        },
      ),
    );
  }

  Future<void> recordVoiceNote(FormFieldState<CommentModel> field) async {
    ScreenRouter.showBottomSheet(
        type: BottomSheetNames.VOICE_NOTE,
        parameters: _prepareVoiceNoteParameter(voiceNoteIntent: VoiceNoteIntent.Record),
        actionsCallbacks: _prepareVoiceNoteActions(field: field));
  }

  Future<void> playVoiceNote(Media media) async {
    ScreenRouter.showBottomSheet(
        type: BottomSheetNames.VOICE_NOTE,
        parameters: _prepareVoiceNoteParameter(voiceNoteIntent: VoiceNoteIntent.Play, voiceNoteUrl: media.mediaPath),
        actionsCallbacks: _prepareVoiceNoteActions());
  }

  Map<String, dynamic>? _prepareVoiceNoteParameter(
      {required VoiceNoteIntent voiceNoteIntent, File? voiceNoteFile, String? voiceNoteUrl}) {
    Map<String, dynamic>? parameters = Map();
    parameters["voiceNoteIntent"] = voiceNoteIntent;
    parameters["voiceNoteFile"] = voiceNoteFile;
    parameters["voiceNoteUrl"] = voiceNoteUrl;
    return parameters;
  }

  Map<String, Function> _prepareVoiceNoteActions({FormFieldState<CommentModel>? field}) {
    Map<String, Function> actionsCallbacks = Map();
    actionsCallbacks['onAcceptNoteCallback'] = (File? file) async {
      ScreenRouter.pop();
      print("🚀🚀🚀🚀 onAcceptNoteCallback done with file $file}");
      var mediaModel = MediaLocal(mediaFile: file!, mediaFileTypes: MediaFileTypes.AUDIO);
      try {
        var result = await FlareAnimation.show(
          action: Repos.mediaRepo
              .uploadMedia(uploadedFile: mediaModel.mediaFile, mediaFileTypes: mediaModel.mediaFileTypes),
          context: context,
        );
        if (field != null) {
          field.didChange(field.value?.copyWith(media: (old) => [...old, result!]) ?? CommentModel(media: [result!]));
          widget.onChanged(field.value);
        }
      } catch (e) {}
    };
    actionsCallbacks['onCloseNoteCallback'] = () => {ScreenRouter.pop(), print("🚀🚀🚀🚀 On Close Note Callback")};
    actionsCallbacks['onRemoveNoteCallback'] = () => {ScreenRouter.pop(), print("🚀🚀🚀🚀 On Remove Note Callback")};

    return actionsCallbacks;
  }

  Future<void> selectImage(FormFieldState<CommentModel> field) async {
    ScreenRouter.showPopup(
        type: PopupsNames.MEDIA_PICKER_POPUP,
        parameters: {
          "pickerType": MediaPickerType.BOTH,
        },
        actionsCallbacks: _prepareMediaAction(field));
  }

  Map<String, Function> _prepareMediaAction(FormFieldState<CommentModel> field) {
    Map<String, Function> actionsCallbacks = Map();
    actionsCallbacks['mediaPickerCallback'] = (MediaLocal? mediaModel) async {
      try {
        var data = await MediaLocal.compressImage(
          mediaModel!.mediaFile.path,
        );

        var result = await FlareAnimation.show(
          action: Repos.mediaRepo.uploadUint8ListMedia(data: data!, mediaFileTypes: mediaModel.mediaFileTypes),
          context: context,
        );
        field.didChange(field.value?.copyWith(media: (old) => [...old, result!]) ?? CommentModel(media: [result!]));
        widget.onChanged(field.value);
      } catch (e) {}
    };
    actionsCallbacks['dismissCallback'] = () => {print("🚀🚀🚀🚀 User Dismissed")};
    return actionsCallbacks;
  }
}

class MediaView extends StatelessWidget {
  final List<Media> media;
  final ValueChanged<Media>? onDelete;
  const MediaView({Key? key, required this.media, this.onDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.zero,
      crossAxisCount: 4,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: media.map((e) => _buildMediaItem(e, context)).toList(),
    );
  }

  Widget _buildMediaItem(Media media, BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (media.type == MediaFileTypes.IMAGE.value) {
          print("🚀🚀🚀🚀 Open Image Preview");
          ScreenNames.IMAGE_PREVIEW.push(media.mediaPath);
        } else if (media.type == MediaFileTypes.VIDEO.value) {
          print("🚀🚀🚀🚀 Open Video Preview");
          ScreenNames.VIDEO_PREVIEW.push(media.mediaPath);
        } else {
          print("🚀🚀🚀🚀 Open Sound Component ");
          playVoiceNote(media, context);
        }
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          buildMediaImage(media),
          if (onDelete != null)
            PositionedDirectional(
              top: 0,
              end: 0,
              child: InkWell(
                onTap: () => onDelete?.call(media),
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: Theme.of(context).backgroundColor,
                  foregroundColor: Theme.of(context).colorScheme.onBackground,
                  child: Padding(
                    padding: const EdgeInsets.all(2),
                    child: FittedBox(child: Icon(Icons.highlight_off_rounded)),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }

  Widget buildMediaImage(Media media) {
    if (media.type == MediaFileTypes.IMAGE.value) {
      return ShapedRemoteImage.aspectRatio(
        outerPadding: EdgeInsets.all(onDelete == null ? 0 : 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        fit: BoxFit.fill,
        url: media.mediaPath,
      );
    } else if (media.type == MediaFileTypes.VIDEO.value) {
      return ShapedRemoteImage.aspectRatio(
        outerPadding: EdgeInsets.all(onDelete == null ? 0 : 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        fit: BoxFit.fill,
        url: media.mediaPath,
      );
    } else {
      return ShapedRemoteImage.aspectRatio(
        outerPadding: EdgeInsets.all(onDelete == null ? 0 : 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        fit: BoxFit.fill,
        url: media.mediaPath,
      );
    }
  }

  Future<void> playVoiceNote(Media media, BuildContext context) async {
    ScreenRouter.showBottomSheet(
        type: BottomSheetNames.VOICE_NOTE,
        parameters: _prepareVoiceNoteParameter(voiceNoteIntent: VoiceNoteIntent.Play, voiceNoteUrl: media.mediaPath),
        actionsCallbacks: _prepareVoiceNoteActions(context));
  }

  Map<String, dynamic>? _prepareVoiceNoteParameter(
      {required VoiceNoteIntent voiceNoteIntent, File? voiceNoteFile, String? voiceNoteUrl}) {
    Map<String, dynamic>? parameters = Map();
    parameters["voiceNoteIntent"] = voiceNoteIntent;
    parameters["voiceNoteFile"] = voiceNoteFile;
    parameters["voiceNoteUrl"] = voiceNoteUrl;
    return parameters;
  }

  Map<String, Function> _prepareVoiceNoteActions(BuildContext context) {
    Map<String, Function> actionsCallbacks = Map();
    actionsCallbacks['onAcceptNoteCallback'] = (File? file) async {
      ScreenRouter.pop();
      print("🚀🚀🚀🚀 onAcceptNoteCallback done with file $file}");
      var mediaModel = MediaLocal(mediaFile: file!, mediaFileTypes: MediaFileTypes.AUDIO);
      try {
        await FlareAnimation.show(
          action: Repos.mediaRepo
              .uploadMedia(uploadedFile: mediaModel.mediaFile, mediaFileTypes: mediaModel.mediaFileTypes),
          context: context,
        );
      } catch (e) {}
    };
    actionsCallbacks['onCloseNoteCallback'] = () => {ScreenRouter.pop(), print("🚀🚀🚀🚀 On Close Note Callback")};
    actionsCallbacks['onRemoveNoteCallback'] = () => {ScreenRouter.pop(), print("🚀🚀🚀🚀 On Remove Note Callback")};
    return actionsCallbacks;
  }
}
