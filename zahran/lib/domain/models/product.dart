part of 'models.dart';

@HiveType(typeId: 7)
class Product {
  @HiveField(0)
  int id;
  @HiveField(1)
  int moduleNum;
  @HiveField(2)
  int serialNum;
  @HiveField(3)
  LocalizedName name;
  @HiveField(4)
  String media;

  Product({
    required this.id,
    required this.moduleNum,
    required this.serialNum,
    required this.name,
    required this.media,
  });

  Product copy() => Product(
        id: id,
        moduleNum: moduleNum,
        serialNum: serialNum,
        name: name,
        media: media,
      );
}
