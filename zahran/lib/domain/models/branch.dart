part of 'models.dart';

class BranchModel {
  final int id;
  final LocationModel location;
  final double distance;
  final LocalizedName name;
  final LocalizedName address;
  final ChainModel chan;
  final int totalBrands;
  final int totalTasks;
  final int completedTasks;

  final List<BrandModel> brands;

  BranchModel({
    @required this.id,
    @required this.location,
    @required this.distance,
    @required this.name,
    @required this.address,
    @required this.chan,
    @required this.totalBrands,
    @required this.brands,
    @required this.totalTasks,
    @required this.completedTasks,
  });
}

class ChainModel {
  final int id;
  final LocalizedName title;
  final String media;

  ChainModel({this.id, this.title, this.media});
}

class BrandModel {
  final int id;
  final LocalizedName name;
  final String mediaPath;

  BrandModel({this.id, this.name, this.mediaPath});
}
