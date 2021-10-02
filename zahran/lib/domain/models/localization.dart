part of 'models.dart';

@HiveType(typeId: 1)
class LocalizedName {
  @HiveField(0)
  String? ar;
  @HiveField(1)
  String? en;

  LocalizedName({this.ar, this.en});
  LocalizedName.name(String name)
      : ar = name,
        en = name;

  String format(BuildContext context) {
    var locale = context.locale;
    if (locale?.languageCode == "ar")
      return ar ?? en ?? '';
    else
      return en ?? ar ?? '';
  }

  bool contains(String? v) {
    return ar?.contains(v ?? "") == true || en?.contains(v ?? "") == true;
  }

  bool hasName(String val) {
    return en?.toLowerCase().contains(val.toLowerCase()) == true ||
        ar?.toLowerCase().contains(val.toLowerCase()) == true;
  }

  bool hasNameInLocale(BuildContext context, String val) {
    return format(context).toLowerCase().contains(val.toLowerCase());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['en'] = this.en;
    data['ar'] = this.ar;
    return data;
  }
}
