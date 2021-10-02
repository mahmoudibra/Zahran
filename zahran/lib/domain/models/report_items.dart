part of 'models.dart';

@HiveType(typeId: 42)
class ReportItem {
  @HiveField(0)
  final Product product;
  @HiveField(1)
  final CommentModel? comment;
  @HiveField(2)
  final String? reasonOfReaturn;
  @HiveField(3)
  final int? count;
  @HiveField(4)
  final double? price;
  @HiveField(5)
  DateTime createdAt;
  String get guid => createdAt.toIso8601String();
  ReportItem({
    required this.product,
    this.comment,
    this.count,
    this.price,
    this.reasonOfReaturn,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();
  Map<String, dynamic> toJson() {
    return {
      "comment": comment?.comment,
      "media_ids": comment?.media.map((e) => e.id).toList(),
      "product_id": product.id,
      "quantity": count,
      "price": price,
      "reason": reasonOfReaturn,
    }..removeWhere((key, value) => value == null);
  }

  ReportItem copyWith({
    CommentModel? comment,
    int? count,
    double? price,
    String? reasonOfReaturn,
  }) =>
      ReportItem(
        product: product,
        comment: comment ?? this.comment,
        price: price ?? this.price,
        reasonOfReaturn: reasonOfReaturn ?? this.reasonOfReaturn,
        count: count ?? this.count,
      );
}
