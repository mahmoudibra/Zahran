import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/data/repo/user.repo.dart';
import 'package:zahran/presentation/commom/asset_icon.dart';
import 'package:zahran/presentation/localization/tr.dart';
import 'package:zahran/r.dart';

class VisitsAppBar extends StatelessWidget {
  final double expansion;
  const VisitsAppBar({Key? key, required this.expansion}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var avatarWidth = width * 0.12;
    avatarWidth = (avatarWidth * 0.75) + (avatarWidth * 0.25 * expansion);
    return GetBuilder<AuthViewModel>(
      builder: (AuthViewModel vm) {
        return SafeArea(
          bottom: false,
          child: Container(
            alignment: AlignmentGeometryTween(
                    begin: Alignment.center, end: Alignment.bottomCenter)
                .transform(expansion),
            padding: EdgeInsets.symmetric(horizontal: 16)
                .copyWith(bottom: 15 * expansion),
            child: Row(
              children: [
                ShapedRemoteImage(
                  url: vm.profile!.media,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(avatarWidth)),
                  width: avatarWidth,
                  height: avatarWidth,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      PrimaryTextStyles.headline6(
                        child: Text(
                          TR
                              .of(context)
                              .welcome(vm.profile!.name.format(context)),
                          style: TextStyle(fontSize: 14 + 4 * expansion),
                        ),
                      ),
                      PrimaryTextStyles.caption(
                        child: Text(
                          TR.of(context).lets_get_to_work,
                          style: TextStyle(fontSize: 10 + 4 * expansion),
                        ),
                      )
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    //TODO Notififications Page
                  },
                  icon: AssetIcon(
                    R.assetsImagesNotificationIcon,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
