part of 'models.dart';

@HiveType(typeId: 44)
class ProblemDetailsModel extends HiveObject {
  @HiveField(0)
  final String? problemTitle;
  @HiveField(1)
  final SelectItem? problemType;
  @HiveField(2)
  final Severity? severity;
  bool resolved;
  ProblemDetailsModel({
    this.problemTitle,
    this.problemType,
    this.severity,
    this.resolved = false,
  });

  ProblemDetailsModel copyWith({
    String? problemTitle,
    SelectItem? problemType,
    Severity? severity,
    bool? resolved,
  }) {
    return ProblemDetailsModel(
      problemTitle: problemTitle ?? this.problemTitle,
      problemType: problemType ?? this.problemType,
      severity: severity ?? this.severity,
      resolved: resolved ?? this.resolved,
    );
  }
}
