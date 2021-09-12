import 'package:flutter/material.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/commom/cashed_Image.component.dart';
import 'package:zahran/presentation/commom/toolbox.helper.dart';
import 'package:zahran/r.dart';

import 'product_row.dart';

class BrandRow extends StatefulWidget {
  final BrandModel brand;

  BrandRow({required this.brand});

  @override
  _BrandRowState createState() => _BrandRowState();
}

class _BrandRowState extends State<BrandRow> with TickerProviderStateMixin {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      curve: Curves.fastOutSlowIn,
      alignment: Alignment.topCenter,
      duration: Duration(milliseconds: 400),
      child: GestureDetector(
        onTap: () {
          setState(() {
            isExpanded = !isExpanded;
          });
        },
        child: _buildContainer(context),
      ),
    );
  }

  Container _buildContainer(BuildContext context) {
    return Container(
        height: isExpanded ? null : 60,
        margin: EdgeInsetsDirectional.only(bottom: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Theme.of(context).dividerColor,
              blurRadius: 4,
            )
          ],
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  brandImage(),
                  ViewsToolbox.emptySpaceWidget(width: 10),
                  Text(
                    widget.brand.name.format(context),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Image.asset(
                    isExpanded
                        ? R.assetsImagesArrowUp
                        : R.assetsImagesArrowDown,
                  )
                ],
              ),
              ViewsToolbox.emptySpaceWidget(height: 5),
              isExpanded ? buildSubBrandsList(context) : Container()
            ],
          ),
        ));
  }

  Widget brandImage() {
    return Container(
      height: 32,
      width: 32,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        child: CachedImage(
          imageUrl: widget.brand.mediaPath,
        ),
      ),
    );
  }

  Widget buildSubBrandsList(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.only(top: 10, bottom: 10),
      itemCount: widget.brand.products.length,
      itemBuilder: (context, index) {
        return ProductRow(
          singleProduct: widget.brand.products[index],
        );
      },
    );
  }
}
