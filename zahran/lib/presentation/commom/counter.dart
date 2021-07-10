import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';

class CounterView extends StatelessWidget {
  final int value;
  final int? of;
  final String label;
  const CounterView(
      {Key? key, required this.value, this.of, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: "$value",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: context.theme.accentColor,
              fontSize: of == null ? 14 : 16,
            ),
          ),
          if (of != null) ...[
            TextSpan(
              text: " / ",
              style: TextStyle(
                color: context.theme.accentColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: "$of",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            )
          ],
          TextSpan(text: " $label")
        ],
      ),
    );
  }
}
