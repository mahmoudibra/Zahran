import 'package:reusable/reusable.dart';
import 'package:zahran/presentation/config/configs.dart';

abstract class BaseRepositryImpl extends BaseRepositry {
  @override
  String get listTotalKey => "total_count";

  @override
  String get language => Get.locale.languageCode;

  @override
  void onError(ApiFetchException error) {}

  @override
  Uri get baseUrl {
    return Uri.parse(GeneralConfigs.BASE_URL);
  }

  @override
  Future<Map<String, String>> getHeaders(ROptions options) async {
    return {};
  }
}
