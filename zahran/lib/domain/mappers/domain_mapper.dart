import 'package:zahran/domain/enums/visit_status.dart';
import 'package:zahran/domain/models/document.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/domain/models/question_types.enum.dart';
import 'package:zahran/presentation/business/more/promotions/promotion_view_model.dart';
import 'package:zahran/presentation/commom/media_picker/MediaFileTypes.dart';

part 'branch.dto.dart';
part 'branch_report.dto.dart';
part 'brand.dto.dart';
part 'chain.dto.dart';
part 'document.dto.dart';
part 'localized_name.dto.dart';
part 'media.dto.dart';
part 'media_upload.dto.dart';
part 'notification.dto.dart';
part 'option.dto.dart';
part 'product.dto.dart';
part 'promotion.dto.dart';
part 'question.dto.dart';
part 'report.dto.dart';
part 'salary.dto.dart';
part 'sender.dto.dart';
part 'target.dto.dart';
part 'task.dto.dart';
part 'user.dto.dart';

abstract class DtoToDomainMapper<V> {
  V dtoToDomainModel();
}

extension ToDoubleExt on String? {
  double? toDouble() {
    return double.tryParse(this?.toString().replaceAll(',', '') ?? '');
  }

  T? toEnum<T>(List<T> values) {
    if (this == null) return null;
    var items = values.where((element) {
      var _element = element
          .toString()
          .replaceAll("${element.runtimeType.toString()}.", "")
          .toLowerCase()
          .replaceAll("_", "")
          .replaceAll("-", "");
      var value = this!.toLowerCase().replaceAll("_", "").replaceAll("-", "");
      return value == _element;
    });
    if (items.length == 0) return null;
    return items.first;
  }
}
