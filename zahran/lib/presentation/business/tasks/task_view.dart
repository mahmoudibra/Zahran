import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/domain/mappers/domain_mapper.dart';
import 'package:zahran/presentation/commom/asset_icon.dart';
import 'package:zahran/presentation/commom/brands_view.dart';
import 'package:zahran/presentation/localization/tr.dart';
import 'package:zahran/r.dart';

import 'task_percent.dart';

class TaskView extends StatelessWidget {
  const TaskView({Key? key}) : super(key: key);

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
                    child: Text("Regular Check", style: context.bodyText1)),
                SizedBox(width: 10),
                AssetIcon(R.assetsImagesCupponIcon),
                Text(
                  TR.of(context).promotion,
                  style: TextStyle(color: Color(0xFF4DA850)),
                )
              ],
            ),
            SizedBox(height: 7),
            Text(
                "Existence is pain to a meeseeks Jerry, and we will do anything to alleviate that pain. Ew, Grandpa, so gross! You're talking about my mom!"),
            Divider(height: 20),
            Row(
              children: [
                BrandsView(
                  brands: [
                    BrandDto.fromJson({"id": 0}).dtoToDomainModel(),
                    BrandDto.fromJson({"id": 0}).dtoToDomainModel(),
                    BrandDto.fromJson({"id": 0}).dtoToDomainModel(),
                    BrandDto.fromJson({"id": 0}).dtoToDomainModel(),
                  ],
                ),
                SizedBox(width: 20),
                Expanded(child: Text('Moulinex, Tefal,')),
                SizedBox(width: 10),
                TaskPercent(percent: 0.7)
              ],
            )
          ],
        ),
      ),
    );
  }
}
