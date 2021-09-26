part of 'domain_mapper.dart';

class ReportDto implements DtoToDomainMapper<ReportModel> {
  int? id;
  ReportTypes? type;

  List<ReportItem>? items;

  CommentModelDto? comment;

  ProblemDetailsModelDto? problem;

  String? competitionName;
  DateTime? date;
  ReportDto.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json["id"]?.toString() ?? "");
    type = json["type"]?.toString().toEnum(ReportTypes.values);
    items = (json["products"] as List?)
        ?.map((e) => ReportItemDto.fromJson(e).dtoToDomainModel())
        .toList();
    comment = json["comment"] == null ? null : CommentModelDto.fromJson(json);
    date = DateTime.tryParse(json["date"]?.toString() ?? "");
    problem = json["problem"] == null
        ? null
        : ProblemDetailsModelDto.fromJson(json["problem"] ?? {});

    competitionName = json["competition_name"] ?? "";
  }

  @override
  ReportModel dtoToDomainModel() {
    return ReportModel(
      id: id,
      type: type ?? ReportTypes.Comment,
      items: items ?? [],
      date: date,
      comment: comment?.dtoToDomainModel(),
      problem: problem?.dtoToDomainModel(),
      competitionName: competitionName,
    );
  }
}

class ReportItemDto implements DtoToDomainMapper<ReportItem> {
  ProductDto? product;
  CommentModelDto? comment;
  String? reasonOfReaturn;
  int? count;
  double? price;
  DateTime? createdAt;
  ReportItemDto.fromJson(Map<String, dynamic> json) {
    reasonOfReaturn = json["reason"];
    count = int.tryParse(json["quantity"]?.toString() ?? "");
    price = double.tryParse(json["price"]?.toString() ?? "");
    createdAt = DateTime.tryParse(json["created_at"]?.toString() ?? "");
    product = ProductDto.fromReportJson(json);
    comment = json["comment"] == null
        ? null
        : CommentModelDto.fromJson(json["comment"] ?? {});
  }

  @override
  ReportItem dtoToDomainModel() {
    return ReportItem(
      product: product!.dtoToDomainModel(),
      comment: comment?.dtoToDomainModel(),
      reasonOfReaturn: reasonOfReaturn,
      count: count,
      price: price,
      createdAt: createdAt,
    );
  }
}

class CommentModelDto implements DtoToDomainMapper<CommentModel> {
  String? comment;
  List<Media>? media;
  CommentModelDto.fromJson(Map<String, dynamic> json) {
    comment = json["comment"];
    media = (json["media"] as List?)
        ?.map((e) => MediaDto.fromJson(e).dtoToDomainModel())
        .toList();
  }

  @override
  CommentModel dtoToDomainModel() {
    return CommentModel(
      comment: comment ?? "",
      media: media ?? [],
    );
  }
}

class ProblemDetailsModelDto implements DtoToDomainMapper<ProblemDetailsModel> {
  String? problemTitle;
  String? problemType;
  Severity? severity;
  ProblemDetailsModelDto.fromJson(Map<String, dynamic> json) {
    problemTitle = json["problem_title"];
    problemType = json["problem_type"];
    severity = json["severity"]?.toString().toEnum(Severity.values);
  }

  @override
  ProblemDetailsModel dtoToDomainModel() {
    return ProblemDetailsModel(
      problemTitle: problemTitle,
      problemType: problemType,
      severity: severity,
    );
  }
}
