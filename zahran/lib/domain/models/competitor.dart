part of 'models.dart';

@HiveType(typeId: 45)
class CompetitorModel {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final LocalizedName name;
  @HiveField(2)
  final List<Product> products;
  factory CompetitorModel.withName(String name) => CompetitorModel(
        id: null,
        name: LocalizedName(ar: null, en: name),
        products: [],
      );
  CompetitorModel({
    required this.id,
    required this.name,
    required this.products,
  });
}
