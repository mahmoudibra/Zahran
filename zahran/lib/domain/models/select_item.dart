part of 'models.dart';

@HiveType(typeId: 8)
class SelectItem {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final LocalizedName name;
  SelectItem({
    required this.id,
    required this.name,
  });
}
