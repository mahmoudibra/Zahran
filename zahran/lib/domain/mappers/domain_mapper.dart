import 'package:zahran/domain/enums/visit_status.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/business/more/promotions/promotion_view_model.dart';

part 'branch.dto.dart';
part 'brand.dto.dart';
part 'chain.dto.dart';
part 'localized_name.dto.dart';
part 'product.dto.dart';
part 'promotion.dto.dart';
part 'target.dto.dart';
part 'task.dto.dart';
part 'user.dto.dart';
part 'sallary.dto.dart';

abstract class DtoToDomainMapper<V> {
  V dtoToDomainModel();
}

extension ToDoubleExt on String? {
  double? toDouble() {
    return double.tryParse(this?.toString().replaceAll(',', '') ?? '');
  }
}
