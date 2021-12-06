part of 'domain_mapper.dart';

class CompetitorDto implements DtoToDomainMapper<CompetitorModel> {
  int? id;
  LocalizedNameDto? name;
  List<ProductDto>? products;

  CompetitorDto.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = LocalizedNameDto.fromJson(json["name"] ?? {});
    products = (json["products"] as List?)
        ?.map((e) => ProductDto.fromJson(e))
        .toList();
  }

  @override
  CompetitorModel dtoToDomainModel() {
    return CompetitorModel(
      id: id!,
      name: name?.dtoToDomainModel() ?? LocalizedName(),
      products: products?.map((e) => e.dtoToDomainModel()).toList() ?? [],
    );
  }
}
