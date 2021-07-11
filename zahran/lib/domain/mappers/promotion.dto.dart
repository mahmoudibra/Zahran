import 'package:zahran/domain/mappers/domain_mapper.dart';
import 'package:zahran/domain/mappers/product.dto.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/domain/models/promotion.dart';
import 'package:zahran/presentation/business/more/promotions/promotion_view_model.dart';

class PromotionDto extends DtoToDomainMapper<Promotion> {
  int? id;
  // String? status;
  String? cover;
  String? promotionType;
  String? value;
  LocalizedNameDto? title;
  LocalizedNameDto? description;
  String? fromDate;
  String? toDate;
  List<ChainDto>? chain;
  List<ProductDto>? products;

  PromotionDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    // status = json['status'];
    cover = json['cover'];
    promotionType = json['promotion_type'];
    value = json['value'];
    title = LocalizedNameDto.fromJson(json["title"] ?? {});
    description = LocalizedNameDto.fromJson(json["description"] ?? {});
    fromDate = json['from_date'];
    toDate = json['to_date'];
    chain = (json["chain"] as List?)?.map((e) => ChainDto.fromJson(e)).toList() ?? [];
    products = (json["products"] as List?)?.map((e) => ProductDto.fromJson(e)).toList() ?? [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    // data['status'] = this.status;
    data['cover'] = this.cover;
    data['promotion_type'] = this.promotionType;
    data['value'] = this.value;
    data['title'] = title?.tojson();
    data['description'] = this.description?.tojson();
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    data['chain'] = this.chain?.map((v) => v.toJson()).toList();
    data['products'] = this.products?.map((v) => v.toJson()).toList();
    return data;
  }

  @override
  Promotion dtoToDomainModel() {
    return Promotion(
        id: id!,
        status: PromotionStatus.ALL, //TODO: change again once it's changed from the backend side
        cover: cover ?? "",
        promotionType: promotionType!,
        value: value ?? "0",
        title: title?.dtoToDomainModel() ?? LocalizedName(),
        description: description?.dtoToDomainModel() ?? LocalizedName(),
        fromDate: DateTime.tryParse(fromDate!) ?? DateTime.now(),
        toDate: DateTime.tryParse(toDate!) ?? DateTime.now(),
        chain: chain?.map((e) => e.dtoToDomainModel()).toList() ?? [],
        products: products?.map((e) => e.dtoToDomainModel()).toList() ?? []);
  }
}
