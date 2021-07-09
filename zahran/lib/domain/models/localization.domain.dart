import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:reusable/reusable.dart';

@HiveType(typeId: 1)
class LocalizedName {
  @HiveField(0)
  String ar;
  @HiveField(1)
  String en;

  LocalizedName({this.ar, this.en});

  String format(BuildContext context) {
    var locale = context.locale;
    if (locale.languageCode == "ar")
      return ar ?? en ?? '';
    else
      return en ?? ar ?? '';
  }
}
