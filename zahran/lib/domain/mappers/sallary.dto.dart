part of 'domain_mapper.dart';

class SallaryDto implements DtoToDomainMapper<SallaryModel> {
  int? id;
  LocalizedNameDto? name;
  EmployeeInfoDto? employeeInfo;
  double? netSalary;
  double? earning;
  double? desiccation;
  List<TrackValueDto>? earnings;
  List<TrackValueDto>? desiccations;
  String? paymentType;
  SallaryDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    paymentType = json['payment_type'];
    name = LocalizedNameDto.fromJson(json["name"] ?? {});
    employeeInfo = EmployeeInfoDto.fromJson(json["employee_info"] ?? {});
    netSalary = json["net_salary"]?.toString().toDouble();
    desiccation = json["desiccation"]?.toString().toDouble();
    earning = json["eraning"]?.toString().toDouble();
    earnings = (json["earnings"] as List?)
        ?.map((e) => TrackValueDto.fromJson(e))
        .toList();
    desiccations = (json["desiccations"] as List?)
        ?.map((e) => TrackValueDto.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name?.tojson(),
    };
  }

  @override
  SallaryModel dtoToDomainModel() {
    return SallaryModel(
      id: id!,
      title: name?.dtoToDomainModel() ?? LocalizedName(),
      desiccation: desiccation ?? 0,
      employeeInfo:
          (employeeInfo ?? EmployeeInfoDto.fromJson({})).dtoToDomainModel(),
      earning: earning ?? 0,
      netSalary: netSalary ?? 0,
      desiccations:
          desiccations?.map((e) => e.dtoToDomainModel()).toList() ?? [],
      earnings: earnings?.map((e) => e.dtoToDomainModel()).toList() ?? [],
      paymentType: paymentType ?? "",
    );
  }
}

class EmployeeInfoDto extends DtoToDomainMapper<EmployeeInfo> {
  String? sabNumber;
  String? department;
  String? bank;
  EmployeeInfoDto.fromJson(Map<String, dynamic> json) {
    sabNumber = json['sab_number'];
    department = json["department"];
    bank = json["bank"];
  }

  Map<String, dynamic> toJson() {
    return {"sab_number": sabNumber, "department": department, "bank": bank};
  }

  @override
  EmployeeInfo dtoToDomainModel() {
    return EmployeeInfo(sabNumber ?? "", department ?? "", bank ?? "");
  }
}

class TrackValueDto extends DtoToDomainMapper<TrackValue> {
  LocalizedNameDto? title;
  double? amount;
  double? rate;

  TrackValueDto.fromJson(Map<String, dynamic> json) {
    title = LocalizedNameDto.fromJson(json['title'] ?? {});
    amount = json["amount"]?.toString().toDouble();
    rate = json["rate"].toString().toDouble();
  }

  Map<String, dynamic> toJson() {
    return {"rate": rate, "amount": amount, "title": title};
  }

  @override
  TrackValue dtoToDomainModel() {
    return TrackValue(
        title?.dtoToDomainModel() ?? LocalizedName(), amount ?? 0, rate);
  }
}
