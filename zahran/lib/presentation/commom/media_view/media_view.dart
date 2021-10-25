import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/commom/media_picker/MediaFileTypes.dart';
import 'package:zahran/presentation/commom/media_view/media_view_view_model.dart';

import '../../../r.dart';

class MediaView extends StatelessWidget {
  final List<Media> media;
  final ValueChanged<Media>? onDelete;

  const MediaView({Key? key, required this.media, this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: MediaViewViewModel(context),
      builder: (MediaViewViewModel vm) {
        return GridView.count(
          padding: EdgeInsets.zero,
          crossAxisCount: 4,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: media.map((e) => _buildMediaItem(e, vm, context)).toList(),
        );
      },
    );
  }

  Widget _buildMediaItem(
      Media media, MediaViewViewModel vm, BuildContext context) {
    return GestureDetector(
      onTap: () {
        vm.openMediaViewAction(media);
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
      return Container(
        child: Stack(
          children: [
            ShapedRemoteImage.aspectRatio(
              outerPadding: EdgeInsets.all(onDelete == null ? 0 : 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              fit: BoxFit.fill,
              url: media.mediaPath,
            ),
            Align(
              alignment: AlignmentDirectional.center,
              child: Container(
                padding: EdgeInsets.all(4.0),
                child: Image.asset(R.assetsImgsPlayIcon),
              ),
            )
          ],
        ),
      );
    } else {
      return Container(
        child: Stack(
          children: [
            ShapedRemoteImage.aspectRatio(
              outerPadding: EdgeInsets.all(onDelete == null ? 0 : 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              fit: BoxFit.fill,
              url: media.mediaPath,
            ),
            Align(
              alignment: AlignmentDirectional.center,
              child: Container(
                padding: EdgeInsets.all(4.0),
                child: Image.asset(R.assetsImgsMic),
              ),
            )
          ],
        ),
      );
    }
  }
}
