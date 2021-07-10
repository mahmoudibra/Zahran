import 'package:share/share.dart';
import 'package:zahran/presentation/external/share/share_manager.dart';

class ShareManagerImpl implements ShareManager {
  @override
  Future<void> shareContent({required String sharedContent}) {
    return Share.share(sharedContent);
  }
}
