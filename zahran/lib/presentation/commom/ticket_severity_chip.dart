// import 'package:flutter/material.dart';
// import 'package:zahran/domain/enums/ticket_severity.enum.dart';
// import 'package:zahran/presentation/localization/ext.dart';

// import 'rounded_chip.dart';

// class TicketSeverityChip extends StatelessWidget {
//   final String severity;

//   TicketSeverityChip({this.severity});

//   @override
//   Widget build(BuildContext context) {
//     if (severity.toLowerCase() == TicketSeverity.HIGH.value) {
//       return RoundedChip(
//         // backgroundColor: Color(themeColors.severityHigh), //TODO: uncomment this
//         chipTextColor: Theme.of(context).textTheme.headline6.color,
//         chipText: TR.of(context).ticket_severity_high,
//         backgroundColor: Colors.transparent,
//       );
//     } else if (severity.toLowerCase() == TicketSeverity.MEDIUM.value) {
//       return RoundedChip(
//         // backgroundColor: Color(themeColors.severityMedium), //TODO: uncomment this
//         chipTextColor: Theme.of(context).textTheme.headline6.color,
//         chipText: TR.of(context).ticket_severity_medium,
//         backgroundColor: Colors.transparent,
//       );
//     } else
//       return RoundedChip(
//         // backgroundColor: Color(themeColors.severityLow), //TODO: uncomment this
//         chipTextColor: Theme.of(context).textTheme.headline6.color,
//         chipText: TR.of(context).ticket_severity_low,
//         backgroundColor: Colors.transparent,
//       );
//   }
// }
