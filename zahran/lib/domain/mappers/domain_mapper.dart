import 'package:zahran/domain/models/localization.domain.dart';
import 'package:zahran/domain/models/login_model.domain.dart';
import 'package:zahran/domain/models/target_model.domain.dart';

part 'localization.dto.dart';
part 'login.dto.dart';
part 'target.dto.dart';
part 'user.dto.dart';

abstract class DtoToDomainMapper<V> {
  V dtoToDomainModel();
}
