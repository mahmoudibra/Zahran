import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/domain/models/models.dart';

import '../../../../r.dart';

class TaskProductRow extends StatelessWidget {
  final Product products;
  final Function productCaptureImageCallback;

  TaskProductRow({required this.products, required this.productCaptureImageCallback});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        child: Column(
          children: <Widget>[
            Divider(height: 2, color: Theme.of(context).dividerColor),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Text(products.name.format(context), style: Theme.of(context).textTheme.subtitle2),
                ),
                cameraImage(context),
              ],
            ),
          ],
        ));
  }

  Widget cameraImage(BuildContext context) {
    return GestureDetector(
      onTap: () {
        productCaptureImageCallback();
      },
      child: Container(
        margin: EdgeInsetsDirectional.only(top: 8, bottom: 8, start: 10),
        height: 40,
        width: 40,
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            child: products.media.isEmpty
                ? Image.asset(
                    R.assetsImagesCaptureIcon,
                    fit: BoxFit.cover,
                  )
                : ShapedRemoteImage(
                    url: products.media,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Theme.of(context).colorScheme.primary, width: 1),
                    ))),
      ),
    );
  }
}
