part of 'models.dart';

class SalaryModel {
  final int id;
  final LocalizedName title;
  final EmployeeInfo employeeInfo;
  final double netSalary;
  final double earning;
  final double desiccation;
  final List<TrackValue> earnings;
  final List<TrackValue> desiccations;
  final String paymentType;
  SalaryModel({
    required this.id,
    required this.title,
    required this.employeeInfo,
    required this.netSalary,
    required this.earning,
    required this.desiccation,
    required this.earnings,
    required this.desiccations,
    required this.paymentType,
  });
}

class EmployeeInfo {
  final String sabNumber;
  final String department;
  final String bank;

  EmployeeInfo(this.sabNumber, this.department, this.bank);
}

class TrackValue {
  final LocalizedName title;
  final double amount;
  final double? rate;

  TrackValue(this.title, this.amount, this.rate);
}
