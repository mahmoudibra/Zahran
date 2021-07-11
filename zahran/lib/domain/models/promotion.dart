import 'package:zahran/domain/models/product.dart';
import 'package:zahran/presentation/business/more/promotions/promotion_view_model.dart';

import 'models.dart';

class Promotion {
  int id;
  PromotionStatus status;
  String cover;
  String promotionType;
  String value;
  LocalizedName title;
  LocalizedName description;
  DateTime fromDate;
  DateTime toDate;
  List<ChainModel> chain; //TODO: should be single
  List<Product> products; //TODO: should be single

  Promotion(
      {required this.id,
      required this.status,
      required this.cover,
      required this.promotionType,
      required this.value,
      required this.title,
      required this.description,
      required this.fromDate,
      required this.toDate,
      required this.chain,
      required this.products});

  factory Promotion.empty() {
    return Promotion(
        id: 0,
        status: PromotionStatus.ALL,
        cover: "",
        promotionType: "",
        value: "",
        title: LocalizedName(),
        description: LocalizedName(),
        fromDate: DateTime.now(),
        toDate: DateTime.now(),
        chain: [],
        products: []);
  }
}
