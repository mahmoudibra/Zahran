import 'package:zahran/presentation/helpers/enums/enumeration.dart';

class VisitStatus extends Enum<String> {
  const VisitStatus(String val) : super(val);
  static const VisitStatus PENDING = const VisitStatus('pending');
  static const VisitStatus INCOMPLETE = const VisitStatus('incomplete');
  static const VisitStatus IN_PROGRESS = const VisitStatus('in progress');
  static const VisitStatus COMPLETED = const VisitStatus('completed');
}
