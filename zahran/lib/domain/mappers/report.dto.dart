part of 'domain_mapper.dart';

class ReportDto implements DtoToDomainMapper<ReportModel> {
  ReportTypes? type;

  List<ReportItem>? items;

  CommentModel? comment;

  ProblemDetailsModel? problem;

  String? competitionName;
  ReportDto.fromJson(Map<String, dynamic> json) {}

  @override
  ReportModel dtoToDomainModel() {
    return ReportModel(
      type: type ?? ReportTypes.Comment,
      items: items ?? [],
      comment: comment,
      problem: problem,
    );
  }
}
