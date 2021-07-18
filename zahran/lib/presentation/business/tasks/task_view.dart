import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/commom/brands_view.dart';

class TaskView extends StatelessWidget {
  final TaskModel task;
  const TaskView({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                    child: Text(task.title.format(context),
                        style: context.bodyText1)),
                if (task.status) ...[
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
            SizedBox(height: 7),
            Text(task.description.format(context)),
            Divider(height: 20),
            Row(
              children: [
                BrandsView(brands: task.brands),
                SizedBox(width: 10),
                Expanded(child: Text(task.instructions.format(context))),
                // if (showProgress) ...[
                //   SizedBox(width: 10),
                //   TaskPercent(percent: 0.7)
                // ],
              ],
            )
          ],
        ),
      ),
    );
  }
}
