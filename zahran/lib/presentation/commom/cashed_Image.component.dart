import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:zahran/presentation/config/configs.dart';

import 'app_loader.dart';

class CachedImage extends StatelessWidget {
  final String imageUrl;
  final double loadingIndicatorSize;

  CachedImage({required this.imageUrl, this.loadingIndicatorSize = 20.0});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      alignment: Alignment.center,
      fit: BoxFit.cover,
      errorWidget: (pContext, pnContext, error) {
        return Image.asset(
            GeneralConfigs.IMAGE_ASSETS_PATH + "test_background.png",
            fit: BoxFit.cover);
      },
      placeholder: (pContext, pnContext) {
        return Container(
          color: Theme.of(pContext).canvasColor,
          child: Center(
            child: Container(
                height: loadingIndicatorSize,
                width: loadingIndicatorSize,
                child: AppLoader()),
          ),
        );
      },
    );
  }
}
