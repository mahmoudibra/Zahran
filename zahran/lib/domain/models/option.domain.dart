part of 'models.dart';

class Option {
  int id;
  String value;

  Option({required this.id, required this.value});

  @override
  String toString() {
    return '''Option( 
    id: $id,
    value: $value
    )''';
  }
}
