import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/data/repo/base.repo.dart';
import 'package:zahran/domain/models/models.dart';
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

class _CommentFormFieldState extends State<CommentFormField>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return FormField(
      initialValue: widget.intialValue,
      onSaved: widget.onChanged,
      validator: (v) => widget.optional || v != null
          ? null
          : ReusableLocalizations.of(context)?.requiredField,
      builder: (FormFieldState<CommentModel> field) {
        var media = (field.value?.media ?? []);
        return AnimatedSize(
          vsync: this,
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
          onPressed: () {},
          padding: EdgeInsets.zero,
          icon: Image.asset(R.assetsImgsMic),
        ),
      ],
    );
  }

  Expanded _buildTextField(
      BuildContext context, FormFieldState<CommentModel> field) {
    return Expanded(
      child: CustomTextField(
        validator: (v) => null,
        hint: TR.of(context).enter_decription_here,
        initialValue: field.value?.comment,
        onChanged: (v) {
          field.didChange(field.value?.copyWith(comment: v) ??
              CommentModel(comment: v ?? ''));
          widget.onChanged(field.value);
        },
      ),
    );
  }

  Future<void> selectImage(FormFieldState<CommentModel> field) async {
    ScreenRouter.showPopup(
        type: PopupsNames.MEDIA_PICKER_POPUP,
        parameters: {
          "pickerType": MediaPickerType.CAMERA_WITH_GALLERY,
        },
        actionsCallbacks: _prepareMediaAction(field));
  }

  Map<String, Function> _prepareMediaAction(
      FormFieldState<CommentModel> field) {
    Map<String, Function> actionsCallbacks = Map();
    actionsCallbacks['mediaPickerCallback'] = (MediaLocal? mediaModel) async {
      try {
        var data = await MediaLocal.compressImage(
          mediaModel!.mediaFile.path,
        );
        var result = await FlareAnimation.show(
          action: Repos.mediaRepo.uploadUint8ListMedia(data: data!),
          context: context,
        );
        field.didChange(
            field.value?.copyWith(media: (old) => [...old, result!]) ??
                CommentModel(media: [result!]));
        widget.onChanged(field.value);
      } catch (e) {}
    };
    actionsCallbacks['dismissCallback'] =
        () => {print("🚀🚀🚀🚀 User Dismissed")};
    return actionsCallbacks;
  }
}

class MediaView extends StatelessWidget {
  final List<MediaUpload> media;
  final ValueChanged<MediaUpload>? onDelete;
  const MediaView({Key? key, required this.media, this.onDelete})
      : super(key: key);

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

  Widget _buildMediaItem(MediaUpload e, BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ShapedRemoteImage.aspectRatio(
          outerPadding: EdgeInsets.all(onDelete == null ? 0 : 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          url: e.path,
        ),
        if (onDelete != null)
          PositionedDirectional(
            top: 0,
            end: 0,
            child: InkWell(
              onTap: () => onDelete?.call(e),
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
    );
  }
}
