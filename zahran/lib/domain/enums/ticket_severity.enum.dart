import 'package:zahran/presentation/helpers/enums/enumeration.dart';

class TicketSeverity extends Enum<String> {
  const TicketSeverity(String val) : super(val);
  static const TicketSeverity HIGH = const TicketSeverity('high');
  static const TicketSeverity MEDIUM = const TicketSeverity('medium');
  static const TicketSeverity LOW = const TicketSeverity('low');
}
