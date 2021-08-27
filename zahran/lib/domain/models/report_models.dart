part of 'models.dart';

@HiveType(typeId: 70)
enum ReportTypes {
  @HiveField(0)
  Comment,
  @HiveField(1)
  Problem,
  @HiveField(2)
  Competition_Sell_OUT,
  @HiveField(3)
  Competition_Stock_Count,
  @HiveField(4)
  Sell_OUT,
  @HiveField(5)
  Stock_Count,
  @HiveField(6)
  Return,
  @HiveField(7)
  Supply_Order
}

@HiveType(typeId: 71)
enum Severity {
  @HiveField(0)
  Low,
  @HiveField(1)
  Medium,
  @HiveField(2)
  High
}

@HiveType(typeId: 41)
class ReportModel extends HiveObject {
  @HiveField(0)
  final ReportTypes type;
  @HiveField(1)
  final List<ReportItem> items;
  @HiveField(2)
  CommentModel? comment;
  @HiveField(3)
  ProblemDetailsModel? problem;
  @HiveField(4)
  String? competitionName;
  ReportModel({
    required this.type,
    List<ReportItem>? items,
    this.comment,
    this.problem,
    this.competitionName,
  }) : items = items ?? List.empty(growable: true);

  Map<String, dynamic> toJson() {
    return {
      "comment": comment?.comment,
      "media_ids": comment?.media.map((e) => e.id).toList(),
      "reports": items.map((e) => e.toJson()).toList()
    }..removeWhere((key, value) => value == null);
  }
}
