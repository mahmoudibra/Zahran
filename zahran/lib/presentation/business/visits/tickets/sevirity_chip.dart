import 'package:flutter/material.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/localization/tr.dart';

class SevirityChip extends StatelessWidget {
  final Severity severity;

  SevirityChip({required this.severity});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(decideText(context)),
      visualDensity: VisualDensity.compact,
      backgroundColor: backgroundColor(context),
      labelStyle: TextStyle(fontSize: 12, color: textColor(context)),
    );
  }

  String decideText(BuildContext context) {
    switch (severity) {
      case Severity.Low:
        return TR.of(context).low;
      case Severity.Medium:
        return TR.of(context).medium;
      case Severity.High:
        return TR.of(context).high;
    }
  }

  Color textColor(BuildContext context) {
    switch (severity) {
      case Severity.Low:
        return Colors.white;
      case Severity.Medium:
        return Colors.white;
      case Severity.High:
        return Colors.white;
    }
  }

  Color backgroundColor(BuildContext context) {
    switch (severity) {
      case Severity.Low:
        return Colors.blue;
      case Severity.Medium:
        return Colors.amber;
      case Severity.High:
        return Colors.redAccent;
    }
  }
}
