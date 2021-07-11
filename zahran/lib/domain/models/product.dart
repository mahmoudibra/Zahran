part of 'models.dart';

class Product {
  int id;
  int moduleNum;
  int serialNum;
  LocalizedName name;
  String media;

  Product({
    required this.id,
    required this.moduleNum,
    required this.serialNum,
    required this.name,
    required this.media,
  });
}
