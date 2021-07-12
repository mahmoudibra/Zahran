part of 'models.dart';

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