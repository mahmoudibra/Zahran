part of 'models.dart';

class BrandModel {
  final int id;
  final LocalizedName name;
  final String mediaPath;
  final List<Product> products;
  BrandModel({required this.id, required this.name, required this.mediaPath, required this.products});
}
