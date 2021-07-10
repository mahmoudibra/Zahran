import 'package:flutter/material.dart';

import 'cashed_Image.component.dart';

class RoundedImage extends StatelessWidget {
  final double radius;
  final double borderSize;
  final String imageUrl;
  final Color borderColor;
  final double loadingIndicatorSize;

  const RoundedImage({
    required this.radius,
    required this.borderSize,
    required this.imageUrl,
    required this.borderColor,
    required this.loadingIndicatorSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: radius,
      width: radius,
      decoration: BoxDecoration(
        border: Border.all(
          width: borderSize,
          color: borderColor,
        ),
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        shape: BoxShape.rectangle,
      ),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: CachedImage(
            imageUrl: imageUrl,
            loadingIndicatorSize: loadingIndicatorSize,
          )),
    );
  }
}
