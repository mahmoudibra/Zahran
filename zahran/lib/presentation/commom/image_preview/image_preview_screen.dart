import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/presentation/localization/tr.dart';

import '../scaffold_silver_app_bar.dart';
import 'image_preview_view_model.dart';

class ImagePreviewScreen extends StatelessWidget {
  ImagePreviewScreen();

  Widget build(BuildContext context) {
    return GetBuilder(
      init: ImagePreviewViewModel(context),
      builder: (ImagePreviewViewModel vm) {
        return ScaffoldSilverAppBar(
          content: content(context, vm),
          title: TR.of(context).image_preview,
          paddingVertical: 0.0,
          paddingHorizontal: 0.0,
        );
      },
    );
  }

  Widget content(BuildContext context, ImagePreviewViewModel vm) {
    print("🚀🚀🚀🚀 Image url ${vm.imageUrl}");
    return Container(
      color: Color(int.parse("0xFF040126")),
      child: ShapedRemoteImage(
        width: MediaQuery.of(context).size.height,
        height: MediaQuery.of(context).size.width,
        url: vm.imageUrl,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0),
          border: Border.all(color: Theme.of(context).colorScheme.primary, width: 2),
        ),
      ),
    );
  }
}
