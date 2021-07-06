import 'package:flutter/material.dart';

class RoundedChip extends StatelessWidget {
  final Color chipTextColor;
  final Color backgroundColor;
  final String chipText;

  RoundedChip({
    @required this.chipTextColor,
    @required this.backgroundColor,
    @required this.chipText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      child: Center(
        child: Chip(
          labelPadding: EdgeInsets.only(top: -4, right: 0, left: 0, bottom: 0),
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          label: Text(
            chipText,
            style: Theme.of(context).textTheme.caption.copyWith(
                  color: chipTextColor,
                  fontWeight: FontWeight.w400,
                ),
          ),
          padding: EdgeInsetsDirectional.only(
            start: 16,
            end: 16,
          ),
        ),
      ),
    );
  }
}
