import 'package:flutter/src/widgets/framework.dart';
import 'package:zahran/data/repo/base.repo.dart';
import 'package:zahran/presentation/navigation/named_navigator_impl.dart';

class UserRepo extends BaseRepositryImpl {
  @override
  BuildContext get context => NamedNavigatorImpl.navigatorState.currentContext;

  @override
  mapItem(Map<String, dynamic> json) {
    // TODO: implement mapItem
    throw UnimplementedError();
  }
}
