import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';

part 'user_model.dart';

class LocalizedName {
  String ar;
  String en;

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
