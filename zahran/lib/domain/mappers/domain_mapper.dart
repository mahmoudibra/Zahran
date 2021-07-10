import 'package:zahran/domain/models/models.dart';

part 'user.dto.dart';
part 'branch.dto.dart';
part 'chain.dto.dart';
part 'localized_name.dto.dart';
part 'brand.dto.dart';

abstract class DtoToDomainMapper<V> {
  V dtoToDomainModel();
}
