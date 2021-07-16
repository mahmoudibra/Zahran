part of 'models.dart';

class BranchModel {
  final int id;
  final LocationModel location;
  final double distance;
  final LocalizedName name;
  final LocalizedName address;
  final ChainModel chain;
  final int totalBrands;
  final int totalTasks;
  final int completedTasks;
  final int incompletedTasks;
  final VisitStatus visitStatus;
  final List<BrandModel> brands;
  final List<TaskModel> tasks;

  BranchModel({
    required this.id,
    required this.location,
    required this.distance,
    required this.name,
    required this.address,
    required this.chain,
    required this.totalBrands,
    required this.brands,
    required this.totalTasks,
    required this.completedTasks,
    required this.visitStatus,
    required this.tasks,
    required this.incompletedTasks,
  });
  BranchModel copyWith({
    LocationModel? location,
    double? distance,
    LocalizedName? name,
    LocalizedName? address,
    ChainModel? chan,
    int? totalBrands,
    int? totalTasks,
    int? completedTasks,
    int? incompletedTasks,
    VisitStatus? visitStatus,
    List<BrandModel>? brands,
    List<TaskModel>? tasks,
  }) {
    return BranchModel(
      id: id,
      location: location ?? this.location,
      distance: distance ?? this.distance,
      incompletedTasks: incompletedTasks ?? this.incompletedTasks,
      name: name ?? this.name,
      address: address ?? this.address,
      chain: chan ?? this.chain,
      totalBrands: totalBrands ?? this.totalBrands,
      brands: brands ?? this.brands,
      totalTasks: totalTasks ?? this.totalTasks,
      completedTasks: completedTasks ?? this.completedTasks,
      visitStatus: visitStatus ?? this.visitStatus,
      tasks: tasks ?? this.tasks,
    );
  }
}
