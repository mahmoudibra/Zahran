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
  final bool comment;
  final bool competitionSellOut;
  final bool competitionStockCount;
  final bool sellOut;
  final bool stockCount;
  final bool returnReport;
  final bool supplyOrder;

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
    required this.comment,
    required this.competitionSellOut,
    required this.competitionStockCount,
    required this.sellOut,
    required this.stockCount,
    required this.returnReport,
    required this.supplyOrder,
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
    bool? comment,
    bool? competitionSellOut,
    bool? competitionStockCount,
    bool? sellOut,
    bool? stockCount,
    bool? returnReport,
    bool? supplyOrder,
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
      comment: comment ?? this.comment,
      competitionSellOut: competitionSellOut ?? this.competitionSellOut,
      competitionStockCount:
          competitionStockCount ?? this.competitionStockCount,
      sellOut: sellOut ?? this.sellOut,
      returnReport: returnReport ?? this.returnReport,
      supplyOrder: supplyOrder ?? this.supplyOrder,
      stockCount: stockCount ?? this.stockCount,
    );
  }
}
