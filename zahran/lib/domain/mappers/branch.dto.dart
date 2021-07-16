part of 'domain_mapper.dart';

class BranchDto implements DtoToDomainMapper<BranchModel> {
  int? id;
  LocationModel? location;
  double? distance;
  LocalizedNameDto? name;
  LocalizedNameDto? address;
  ChainDto? chan;
  int? totalBrands;
  int? totalTasks;
  int? completedTasks;
  int? incompletedTasks;
  List<BrandDto>? brands;
  List<TaskDto>? tasks;
  VisitStatus? visitStatus;
  BranchDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = LocalizedNameDto.fromJson(json["name"] ?? {});
    distance = json['distance']?.toString().toDouble();
    location = LocationModel.fromJson(json["location"] ?? {});
    address = LocalizedNameDto.fromJson(json["address"] ?? {});
    chan = ChainDto.fromJson(json["chain"] ?? {});
    totalBrands = int.tryParse(json["total_brands"]?.toString() ?? "") ?? 0;
    totalTasks = int.tryParse(json["total_tasks"]?.toString() ?? "") ?? 0;
    completedTasks =
        int.tryParse(json["completed_tasks"]?.toString() ?? "") ?? 0;
    incompletedTasks =
        int.tryParse(json["incompleted_tasks"]?.toString() ?? "") ?? 0;
    brands =
        (json["brands"] as List?)?.map((e) => BrandDto.fromJson(e)).toList();
    tasks = (json["tasks"] as List?)?.map((e) => TaskDto.fromJson(e)).toList();
    visitStatus = VisitStatus(json['visit_status']);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name?.tojson(),
      "location": location?.toJson(),
      "distance": distance,
      "address": address?.tojson(),
      "chan": chan?.toJson(),
      "total_brands": totalBrands,
      "total_tasks": totalTasks,
      "completed_tasks": completedTasks,
      "brands": brands?.map((e) => e.toJson()).toList(),
      "tasks": tasks?.map((e) => e.toJson()).toList(),
    };
  }

  @override
  BranchModel dtoToDomainModel() {
    return BranchModel(
      id: id!,
      incompletedTasks: incompletedTasks ?? 0,
      visitStatus: visitStatus ?? VisitStatus.PENDING,
      name: name?.dtoToDomainModel() ?? LocalizedName(),
      location: location ?? LocationModel(lat: 0, lang: 0),
      chain: (chan ?? ChainDto.fromJson({})).dtoToDomainModel(),
      totalBrands: totalBrands ?? 0,
      totalTasks: totalTasks ?? 0,
      address: address?.dtoToDomainModel() ?? LocalizedName(),
      brands: brands?.map((e) => e.dtoToDomainModel()).toList() ?? [],
      tasks: tasks?.map((e) => e.dtoToDomainModel()).toList() ?? [],
      completedTasks: completedTasks ?? 0,
      distance: distance ?? 0,
    );
  }
}
