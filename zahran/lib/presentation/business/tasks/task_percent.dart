import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:reusable/reusable.dart';

class TaskPercent extends StatelessWidget {
  final double percent;
  const TaskPercent({Key? key, required this.percent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 35.0,
      lineWidth: 3.0,
      percent: percent,
      center: SizedBox(
        width: 20,
        child: AutoSizeText("${(percent * 100).percentPattern()}",
            maxLines: 1, minFontSize: 5),
      ),
      progressColor: color(context),
      backgroundColor: color(context).withOpacity(0.25),
      animateFromLastPercent: true,
      circularStrokeCap: CircularStrokeCap.round,
    );
  }

  Color color(BuildContext context) {
    if (percent < 0.3) return context.theme.accentColor;
    if (percent < 0.6) return Color(0xFFFE9E00);
    return Color(0xFF4DA850);
  }
}
