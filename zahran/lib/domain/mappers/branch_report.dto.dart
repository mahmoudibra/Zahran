part of 'domain_mapper.dart';

class BranchReportDto implements DtoToDomainMapper<BranchReport> {
  BranchDto? branch;
  DateTime? date;
  int? id;
  int? reportCount;
  BranchReportDto.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    reportCount = int.parse(json['report_count'].toString());
    date = DateTime.parse(json['date']);
    branch = BranchDto.fromJson(json["branch"]);
  }

  @override
  BranchReport dtoToDomainModel() {
    return BranchReport(
      branch: branch!.dtoToDomainModel(),
      date: date!,
      id: id!,
      reportCount: reportCount!,
    );
  }
}
