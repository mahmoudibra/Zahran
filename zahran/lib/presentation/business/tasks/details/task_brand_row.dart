import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/commom/toolbox.helper.dart';

import '../../../../r.dart';
import 'task_product_row.dart';

typedef BrandRowCaptureImageCallback = void Function({@required int productIndex});

class TaskBrandRow extends StatefulWidget {
  final BrandModel subBrands;
  final BrandRowCaptureImageCallback captureImageCallback;

  TaskBrandRow({required this.subBrands, required this.captureImageCallback});

  @override
  _TaskBrandRowState createState() => _TaskBrandRowState();
}

class _TaskBrandRowState extends State<TaskBrandRow> with TickerProviderStateMixin {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      vsync: this,
      curve: Curves.fastLinearToSlowEaseIn,
      duration: Duration(milliseconds: 800),
      child: GestureDetector(
        onTap: () {
          setState(() {
            isExpanded = !isExpanded;
          });
        },
        child: Container(
            height: isExpanded ? null : 60,
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
                        widget.subBrands.name.format(context),
                        style: Theme.of(context).textTheme.subtitle2?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      Image.asset(
                        isExpanded ? R.assetsImagesArrowUp : R.assetsImagesArrowDown,
                      )
                    ],
                  ),
                  ViewsToolbox.emptySpaceWidget(height: 5),
                  isExpanded ? productsList(context) : Container()
                ],
              ),
            )),
      ),
    );
  }

  Widget brandImage() {
    return Container(
      height: 32,
      width: 32,
      child: ShapedRemoteImage(
          url: widget.subBrands.mediaPath,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Theme.of(context).colorScheme.primary, width: 1),
          )),
    );
  }

  Widget productsList(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.only(top: 5, bottom: 5),
      itemCount: widget.subBrands.products.length,
      itemBuilder: (context, index) {
        return TaskProductRow(
          productCaptureImageCallback: () {
            widget.captureImageCallback(productIndex: index);
          },
          products: widget.subBrands.products[index],
        );
      },
    );
  }
}
