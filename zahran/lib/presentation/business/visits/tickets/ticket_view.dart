import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/commom/media_view/media_view.dart';
import 'package:zahran/presentation/navigation/screen_router.dart';

class TicketView extends StatelessWidget {
  final ReportModel model;
  final bool loading;
  const TicketView({Key? key, required this.model, required this.loading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var problem = model.problem!;
    return ShimmerView(
      loading: loading,
      child: Card(
        child: InkWell(
          onTap: () {
            ScreenNames.TICKET_DETAILS.push(model);
          },
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Text(problem.problemTitle ?? "",
                            style: context.bodyText1)),
                    if (problem.resolved) ...[
                      SizedBox(width: 10),
                      CircleAvatar(
                        backgroundColor: Color(0xFF4DA850),
                        foregroundColor: Colors.white,
                        radius: 10,
                        child: Icon(Icons.check, size: 15),
                      ),
                    ],
                  ],
                ),
                if (model.comment != null) ...[
                  SizedBox(height: 7),
                  Text(model.comment?.comment ?? ""),
                  Divider(height: 20),
                  MediaView(media: model.comment!.media),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
