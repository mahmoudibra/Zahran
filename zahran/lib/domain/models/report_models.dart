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
  Return_Report,
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
  int? id;
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
  DateTime? date;
  ReportModel({
    this.id,
    this.date,
    required this.type,
    List<ReportItem>? items,
    this.comment,
    this.problem,
    this.competitionName,
  }) : items = items ?? List.empty(growable: true);

  Map<String, dynamic> toJson() {
    if (type == ReportTypes.Problem) {
      return {
        "title": problem?.problemTitle,
        "description": comment?.comment,
        "severity": problem?.severity
            ?.toString()
            .replaceAll("Severity.", "")
            .toLowerCase(),
        "ticket_type_id": problem?.problemType?.id,
        "media": comment?.media.map((e) => e.id).toList(),
        "products": items.map((e) => e.product.id).toList(),
      }..removeWhere((key, value) => value == null);
    } else {
      return {
        if (id != null && id! > 0) "id": id,
        "comment": comment?.comment,
        "media_ids": comment?.media.map((e) => e.id).toList(),
        "reports": items.map((e) => e.toJson()).toList(),
        "competition_name": competitionName
      }..removeWhere((key, value) => value == null);
    }
  }

  ReportModel copyWith({
    int? id,
    ReportTypes? type,
    List<ReportItem>? items,
    CommentModel? comment,
    ProblemDetailsModel? problem,
    String? competitionName,
    DateTime? date,
  }) {
    return ReportModel(
      id: id ?? this.id,
      type: type ?? this.type,
      items: items ?? this.items,
      comment: comment ?? this.comment,
      problem: problem ?? this.problem,
      competitionName: competitionName ?? this.competitionName,
      date: date ?? this.date,
    );
  }
}

class BranchReport {
  final BranchModel branch;
  final DateTime date;
  final int id;
  final int reportCount;

  BranchReport({
    required this.branch,
    required this.date,
    required this.id,
    required this.reportCount,
  });
}
