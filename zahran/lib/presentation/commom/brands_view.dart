import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/domain/models/models.dart';

class BrandsView extends StatelessWidget {
  final List<BrandModel> brands;
  final int max;
  final bool reversed;
  const BrandsView(
      {Key? key, required this.brands, this.max = 3, this.reversed = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var min = math.min(max, brands.length);
    if (min == max) min++;
    return SizedBox(
      height: 30,
      width: min * 25 + 5,
      child: Stack(
        children: reversed ? _items : _items.reversed.toList(),
      ),
    );
  }

  List<Widget> get _items {
    return [
      if (brands.length > 3 && !reversed) _buildCounter(),
      for (var i = math.min(brands.length, max) - 1; i >= 0; i--)
        PositionedDirectional(
          end: reversed ? (25.0 * (brands.length > 3 ? (i + 1) : i)) : null,
          start: !reversed ? (25.0 * i) : null,
          width: 30,
          height: 30,
          top: 0,
          child: ShapedRemoteImage.aspectRatio(
            url: brands[i].mediaPath,
            fit: BoxFit.contain,
            decoration: _buildDecoration(),
          ),
        ),
      if (brands.length > 3 && reversed) _buildCounter()
    ];
  }

  PositionedDirectional _buildCounter() {
    return PositionedDirectional(
      end: reversed ? 0 : null,
      start: !reversed ? 75 : null,
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
    );
  }

  BoxDecoration _buildDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(50),
      color: Color(0xffF6F6F9),
      border: Border.all(color: Color(0xFFF3F3F6)),
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
