import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:hive/hive.dart';
part 'user_model.dart';
part 'models.g.dart';

@HiveType(typeId: 1)
class LocalizedName {
  @HiveField(0)
  String ar;
  @HiveField(1)
  String en;
  LocalizedName({this.ar, this.en});
  LocalizedName.fromJson(Map<String, dynamic> json) {
    ar = json["ar"];
    en = json["en"];
  }
  String format(BuildContext context) {
    var locale = context.locale;
    if (locale.languageCode == "ar")
      return ar ?? en ?? '';
    else
      return en ?? ar ?? '';
  }

  Map<String, dynamic> tojson() {
    return {
      "ar": ar,
      "en": en,
    };
  }
}
