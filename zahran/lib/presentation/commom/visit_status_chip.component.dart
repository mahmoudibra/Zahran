import 'package:flutter/material.dart';
import 'package:zahran/domain/enums/visit_status.dart';
import 'package:zahran/presentation/localization/tr.dart';

class VisitStatusChip extends StatelessWidget {
  final String visitStatus;

  VisitStatusChip({required this.visitStatus});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(decideVisitStatusText(context)),
      visualDensity: VisualDensity.compact,
      backgroundColor: backgroundColor(context),
      labelStyle: TextStyle(fontSize: 12, color: textColor(context)),
    );
  }

  String decideVisitStatusText(BuildContext context) {
    if (visitStatus == VisitStatus.PENDING.value) {
      return TR.of(context).visit_details_status_running;
    } else if (visitStatus == VisitStatus.COMPLETED.value) {
      return TR.of(context).visit_details_status_completed;
    } else if (visitStatus == VisitStatus.INCOMPLETE.value) {
      return TR.of(context).visit_details_status_incomplete;
    } else if (visitStatus == VisitStatus.IN_PROGRESS.value) {
      return TR.of(context).visit_status_in_progress;
    }
    return TR.of(context).visit_details_status_pending;
  }

  Color textColor(BuildContext context) {
    var state = VisitStatus(visitStatus);
    if (state == VisitStatus.PENDING || state == VisitStatus.IN_PROGRESS) {
      return Theme.of(context).accentColor;
    } else if (state == VisitStatus.COMPLETED) {
      return Colors.greenAccent;
    } else if (visitStatus == VisitStatus.INCOMPLETE.value) {
      return Color(0xFF02001E);
    }
    return Theme.of(context).primaryColor;
  }

  Color backgroundColor(BuildContext context) {
    var state = VisitStatus(visitStatus);
    if (state == VisitStatus.PENDING || state == VisitStatus.IN_PROGRESS) {
      return Theme.of(context).accentColor.withOpacity(0.1);
    } else if (state == VisitStatus.COMPLETED) {
      return Colors.greenAccent.withOpacity(0.3);
    } else if (visitStatus == VisitStatus.INCOMPLETE.value) {
      return Color(0xFFFFE0B2);
    }
    return Theme.of(context).primaryColor.withOpacity(0.3);
  }
}
