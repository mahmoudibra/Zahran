import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/domain/enums/visit_status.dart';

part 'branch.dart';
part 'location.dart';
part 'models.g.dart';
part 'user_model.dart';

@HiveType(typeId: 1)
class LocalizedName {
  @HiveField(0)
  String? ar;
  @HiveField(1)
  String? en;

  LocalizedName({this.ar, this.en});

  String format(BuildContext context) {
    var locale = context.locale;
    if (locale?.languageCode == "ar")
      return ar ?? en ?? '';
    else
      return en ?? ar ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['en'] = this.en;
    data['ar'] = this.ar;
    return data;
  }
}
