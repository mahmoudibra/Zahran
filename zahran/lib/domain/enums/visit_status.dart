import 'package:zahran/presentation/helpers/enums/enumeration.dart';

class VisitStatus extends Enum<String> {
  const VisitStatus(String val) : super(val);
  static const VisitStatus PENDING = const VisitStatus('pending');
  static const VisitStatus INCOMPLETE = const VisitStatus('incomplete');
  static const VisitStatus IN_PROGRESS = const VisitStatus('in-progress');
  static const VisitStatus COMPLETED = const VisitStatus('completed');

  bool get isPending => value == PENDING.value;
  bool get isIncomplete => value == INCOMPLETE.value;
  bool get isInProgress => value == IN_PROGRESS.value;
  bool get isCompleted => value == COMPLETED.value;
  @override
  bool operator ==(covariant Object other) {
    if (other is VisitStatus)
      return other.value == this.value;
    else if (other is String) return other == this.value;
    return this == other;
  }
}
