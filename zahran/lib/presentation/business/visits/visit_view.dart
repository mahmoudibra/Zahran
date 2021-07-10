import 'dart:math';

import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/commom/asset_icon.dart';
import 'package:zahran/presentation/commom/counter.dart';
import 'package:zahran/presentation/commom/progress_gradiant.dart';
import 'package:zahran/presentation/localization/ext.dart';
import 'package:zahran/r.dart';

class VisitView extends StatelessWidget {
  final BranchModel model;
  const VisitView({Key key, @required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _firstRow(context),
                SizedBox(height: 10),
                _secondRow(context),
                Divider(),
                _thirdRow(context, model.brands),
              ],
            ),
          ),
          ProgressGradiant(progress: model.completedTasks / model.totalTasks),
        ],
      ),
    );
  }

  Row _firstRow(BuildContext context) {
    Color color = Color(0xFFF90000);
    String label = TR.of(context).running;
    return Row(
      children: [
        Expanded(
          child: Text(model.name.format(context), style: context.headline6),
        ),
        SizedBox(width: 10),
        Chip(
          label: Text(label),
          visualDensity: VisualDensity.compact,
          backgroundColor: color.withOpacity(0.15),
          labelStyle: TextStyle(fontSize: 12, color: color),
        )
      ],
    );
  }

  Widget _thirdRow(BuildContext context, List<BrandModel> brands) {
    return Row(
      children: [
        CounterView(
          value: model.completedTasks,
          of: model.totalTasks,
          label: TR.of(context).tasks,
        ),
        SizedBox(width: 10),
        Expanded(
          child: SizedBox(
            height: 30,
            child: Stack(
              children: [
                for (var i = min(brands.length, 3) - 1; i >= 0; i--)
                  PositionedDirectional(
                    end: 25.0 * (brands.length > 3 ? (i + 1) : i),
                    width: 30,
                    height: 30,
                    top: 0,
                    child: ShapedRemoteImage.aspectRatio(
                      url: brands[i].mediaPath,
                      fit: BoxFit.contain,
                      decoration: _buildDecoration(),
                    ),
                  ),
                if (brands.length > 3)
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
                          "+${brands.length - 3}",
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

  Row _secondRow(BuildContext context) {
    return Row(
      children: [
        AssetIcon(R.assetsImagesLocationInRangeIcon),
        SizedBox(width: 5),
        Expanded(
          child: Text(
            model.address.format(context),
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
