import 'package:zahran/domain/models/models.dart';

part 'user.dto.dart';

abstract class DtoToDomainMapper<V> {
  V dtoToDomainModel();
}
