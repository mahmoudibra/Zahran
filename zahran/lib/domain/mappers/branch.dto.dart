part of 'domain_mapper.dart';

class BranchDto implements DtoToDomainMapper<BranchModel> {
  int id;
  LocationModel location;
  double distance;
  LocalizedNameDto name;
  LocalizedNameDto address;
  ChainDto chan;
  int totalBrands;
  int totalTasks;
  int completedTasks;
  List<BrandDto> brands;
  BranchDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = LocalizedNameDto.fromJson(json["name"] ?? {});
    distance = double.tryParse(json['distance']?.toString() ?? '') ?? 0;
    location = LocationModel.fromJson(json["location"] ?? {});
    address = LocalizedNameDto.fromJson(json["address"] ?? {});
    chan = ChainDto.fromJson(json["chain"] ?? {});
    totalBrands = int.tryParse(json["total_brands"]?.toString() ?? "") ?? 0;
    totalTasks = int.tryParse(json["total_tasks"]?.toString() ?? "") ?? 0;
    completedTasks =
        int.tryParse(json["completed_tasks"]?.toString() ?? "") ?? 0;
    brands =
        (json["brands"] as List).map((e) => BrandDto.fromJson(e))?.toList() ??
            [];
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
      "brands": brands?.map((e) => e.toJson())?.toList(),
    };
  }

  @override
  BranchModel dtoToDomainModel() {
    return BranchModel(
      id: id,
      name: name?.dtoToDomainModel(),
      location: location,
      chan: chan.dtoToDomainModel(),
      totalBrands: totalBrands,
      totalTasks: totalTasks,
      address: address?.dtoToDomainModel(),
      brands: brands?.map((e) => e.dtoToDomainModel())?.toList(),
      completedTasks: completedTasks,
      distance: distance,
    );
  }
}
