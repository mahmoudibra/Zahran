import 'package:flutter/material.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/commom/media_picker/MediaFileTypes.dart';

import '../../../../r.dart';

class QuestionMediaRow extends StatelessWidget {
  final MediaLocal mediaModel;
  final bool hasDeleteOption;
  final Function onMediaRemoveCallback;

  QuestionMediaRow({
    required this.mediaModel,
    required this.onMediaRemoveCallback,
    bool? hasDeleteOption,
  }) : this.hasDeleteOption = hasDeleteOption ?? false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: 70,
          height: 70,
        ),
        PositionedDirectional(bottom: 0, child: decideMediaType(context)),
        PositionedDirectional(
          end: 0,
          top: 0,
          child: GestureDetector(
            onTap: () {
              onMediaRemoveCallback();
            },
            child: Container(
              width: 20,
              height: 20,
              child: Image.asset(R.assetsImagesRemoveIcon),
            ),
          ),
        )
      ],
    );
  }

  Widget decideMediaType(BuildContext context) {
    Widget mediaWidget = Container();
    switch (mediaModel.mediaFileTypes) {
      case MediaFileTypes.IMAGE:
        mediaWidget = _buildImageMedia(context);
        break;
      case MediaFileTypes.VIDEO:
        mediaWidget = _buildVideoMedia(context);
        break;
      case MediaFileTypes.AUDIO:
        mediaWidget = buildAudioComponent(context);
        break;
    }
    return mediaWidget;
  }

  Widget _buildVideoMedia(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(end: 10),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          Container(
            height: 64,
            width: 64,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(4)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Theme.of(context).dividerColor,
                  blurRadius: 4,
                )
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              child: Image.file(
                mediaModel.videoThumbnail!,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: 32,
            width: 32,
            child: Image.asset(
              R.assetsImagesPlay,
              fit: BoxFit.cover,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildImageMedia(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(end: 10),
      height: 64,
      width: 64,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(4)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Theme.of(context).dividerColor,
            blurRadius: 4,
          )
        ],
      ),
      child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          child: Image.file(
            mediaModel.mediaFile,
          )),
    );
  }

  Widget buildAudioComponent(BuildContext context) {
    return Container(
      height: 64,
      width: 64,
      margin: EdgeInsetsDirectional.only(end: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(4)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Theme.of(context).dividerColor,
            blurRadius: 4,
          )
        ],
      ),
      child: Center(
        child: SizedBox(
          height: 24,
          width: 24,
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            child: Image.asset(
              R.assetsImagesPlay,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
