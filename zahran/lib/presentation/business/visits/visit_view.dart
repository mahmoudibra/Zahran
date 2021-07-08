import 'dart:math';

import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/presentation/commom/asset_icon.dart';
import 'package:zahran/presentation/commom/counter.dart';
import 'package:zahran/presentation/commom/progress_gradiant.dart';
import 'package:zahran/presentation/localization/ext.dart';
import 'package:zahran/r.dart';

class VisitView extends StatelessWidget {
  const VisitView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var images = List.filled(10,
        'https://placeholder.com/wp-content/uploads/2018/10/placeholder.com-logo1.png');
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text("Carrefour", style: context.headline6),
                SizedBox(height: 10),
                _firstRow(context),
                Divider(),
                _secondRow(context, images),
              ],
            ),
          ),
          ProgressGradiant(
            progress: 24 / 40,
          ),
        ],
      ),
    );
  }

  Row _secondRow(BuildContext context, List<String> images) {
    return Row(
      children: [
        CounterView(
          value: 24,
          of: 40,
          label: TR.of(context).tasks,
        ),
        SizedBox(width: 10),
        Expanded(
          child: SizedBox(
            height: 30,
            child: Stack(
              children: [
                for (var i = min(images.length, 2); i >= 0; i--)
                  PositionedDirectional(
                    end: 25.0 * (images.length > 2 ? (i + 1) : i),
                    width: 30,
                    height: 30,
                    top: 0,
                    child: ShapedRemoteImage.aspectRatio(
                      url: images[i],
                      fit: BoxFit.contain,
                      outerDecoration: _buildDecoration(),
                      outerPadding: EdgeInsets.all(3),
                    ),
                  ),
                PositionedDirectional(
                  end: 0,
                  width: 30,
                  height: 30,
                  top: 0,
                  child: Container(
                    decoration: _buildDecoration(),
                    padding: EdgeInsets.all(5),
                    child: Center(
                      child: AutoSizeText(
                        "+${images.length - 3}",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFBDBCD1),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Row _firstRow(BuildContext context) {
    return Row(
      children: [
        AssetIcon(R.assetsImagesLocationInRangeIcon),
        SizedBox(width: 5),
        Expanded(
          child: Text(
            "24th Street, Al Khobar Branch",
            style: context.overline,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(width: 5),
        Text('2.3KM Away', style: context.overline)
      ],
    );
  }

  BoxDecoration _buildDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(50),
      border: Border.all(color: Color(0xFFF3F3F6)),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Color(0xffF6F6F9),
          blurRadius: 2,
          offset: Offset(0, 2),
        )
      ],
    );
  }
}
