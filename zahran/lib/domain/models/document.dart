import 'models.dart';

class Document {
  final int id;
  final LocalizedName name;
  final String type;
  final String documentUrl;

  Document({required this.id, required this.name, required this.type, required this.documentUrl});
}
