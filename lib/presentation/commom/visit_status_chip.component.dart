import 'package:flutter/material.dart';
import 'package:zahran/domain/enums/visit_status.dart';
import 'package:zahran/presentation/localization/ext.dart';

class VisitStatusChip extends StatelessWidget {
  final String visitStatus;

  VisitStatusChip({@required this.visitStatus});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      child: Center(
        child: Chip(
          labelPadding: EdgeInsets.only(top: -4, right: 0, left: 0, bottom: 0),
          backgroundColor: decideVisitStatusColor(context),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          label: Text(
            decideVisitStatusText(context),
            style: Theme.of(context).textTheme.caption.copyWith(
                  color: Theme.of(context).textTheme.headline6.color,
                  fontWeight: FontWeight.w400,
                ),
          ),
          padding: EdgeInsetsDirectional.only(
            start: 12,
            end: 12,
          ),
        ),
      ),
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

  Color decideVisitStatusColor(BuildContext context) {
    if (visitStatus == VisitStatus.PENDING.value || visitStatus == VisitStatus.IN_PROGRESS.value) {
      // return Color(themeColors.lightGreen); //TODO: uncomment this
    } else if (visitStatus == VisitStatus.COMPLETED.value) {
      // return Color(themeColors.transparentBlueColor);  //TODO: uncomment this
    } else if (visitStatus == VisitStatus.INCOMPLETE.value) {
      // return Color(themeColors.lightOrange);  //TODO: uncomment this
    }
    // return Color(themeColors.lightGreen);  //TODO: uncomment this
  }
}
