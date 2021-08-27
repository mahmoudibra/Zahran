part of 'models.dart';

@HiveType(typeId: 42)
class ProblemDetailsModel extends HiveObject {
  @HiveField(0)
  final String? problemTitle;
  @HiveField(1)
  final String? problemType;
  @HiveField(2)
  final Severity? severity;

  ProblemDetailsModel({
    this.problemTitle,
    this.problemType,
    this.severity,
  });

  ProblemDetailsModel copyWith({
    String? problemTitle,
    String? problemType,
    Severity? severity,
  }) {
    return ProblemDetailsModel(
      problemTitle: problemTitle ?? this.problemTitle,
      problemType: problemType ?? this.problemType,
      severity: severity ?? this.severity,
    );
  }
}
