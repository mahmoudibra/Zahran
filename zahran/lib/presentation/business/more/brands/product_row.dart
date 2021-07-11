import 'package:flutter/material.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/commom/rounded_image.dart';
import 'package:zahran/presentation/commom/toolbox.helper.dart';

class ProductRow extends StatelessWidget {
  final Product singleProduct;

  ProductRow({required this.singleProduct});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      padding: EdgeInsets.all(5),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                child: RoundedImage(
                  radius: 24,
                  borderSize: 1,
                  borderColor: Colors.white,
                  imageUrl: singleProduct.media,
                  loadingIndicatorSize: 12,
                ),
              ),
              ViewsToolbox.emptySpaceWidget(width: 5),
              Expanded(
                child: Text(
                  singleProduct.name.format(context),
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(fontWeight: FontWeight.normal),
                ),
              ),
              Text(
                singleProduct.serialNum.toString(),
                style: Theme.of(context).textTheme.subtitle1?.copyWith(fontWeight: FontWeight.normal),
              ),
            ],
          ),
          ViewsToolbox.emptySpaceWidget(height: 5),
          Divider(
            height: 1,
            thickness: 1,
            color: Theme.of(context).dividerColor,
          ),
        ],
      ),
    ));
  }
}
