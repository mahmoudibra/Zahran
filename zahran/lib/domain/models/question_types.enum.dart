import 'package:zahran/presentation/helpers/enums/enumeration.dart';

class QuestionTypes extends Enum<String> {
  const QuestionTypes(String val) : super(val);
  static const QuestionTypes TEXT = const QuestionTypes('text');
  static const QuestionTypes NUMBER = const QuestionTypes('number');
  static const QuestionTypes MEDIA = const QuestionTypes('media');
  static const QuestionTypes DATE = const QuestionTypes('date');
  static const QuestionTypes SELECT = const QuestionTypes('select');
}
