import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/presentation/business/base/auth_view_model.dart';
import 'package:zahran/presentation/commom/asset_icon.dart';
import 'package:zahran/presentation/localization/tr.dart';
import 'package:zahran/presentation/navigation/screen_router.dart';
import 'package:zahran/r.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverOverlapInjector(
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        ),
        _buildItem(
          context: context,
          label: TR.of(context).personal_info,
          icon: R.assetsImagesPersonInfo,
          onTap: () {
            ScreenNames.USER_PROFILE.push();
          },
        ),
        _buildItem(
          context: context,
          label: TR.of(context).promotions,
          icon: R.assetsImagesPromotionIcon,
          onTap: () {
            ScreenNames.PROMOTION_LIST.push();
          },
        ),
        _buildItem(
          context: context,
          label: TR.of(context).branches,
          icon: R.assetsImagesBranchMarker,
          onTap: () {
            ScreenNames.BRANCH_LIST.push();
          },
        ),
        _buildItem(
          context: context,
          label: TR.of(context).brands_products,
          icon: R.assetsImagesBranchMarker,
          onTap: () {
            ScreenNames.BRANDS_LIST.push();
          },
        ),
        _buildItem(
          context: context,
          label: TR.of(context).report,
          icon: R.assetsImagesBranchMarker,
          onTap: () {},
        ),
        _buildItem(
          context: context,
          label: TR.of(context).check_in,
          icon: R.assetsImagesBranchMarker,
          onTap: () {},
        ),
        _buildItem(
          context: context,
          label: TR.of(context).sallary_slip,
          icon: R.assetsImagesBranchMarker,
          onTap: () {},
        ),
        _buildItem(
          context: context,
          label: TR.of(context).shared_documents,
          icon: R.assetsImagesBranchMarker,
          onTap: () {},
        ),
        _buildItem(
          context: context,
          label: TR.of(context).settings,
          icon: R.assetsImagesBranchMarker,
          onTap: () {
            ScreenNames.SETTING.push();
          },
        ),
        SliverToBoxAdapter(
          child: ListTile(
            onTap: () async {
              ScreenNames.SPLASH.pushAndRemoveAll();
              await Get.find<AuthViewModel>().removeUser();
            },
            leading: AssetIcon(R.assetsImagesLogoutIcon),
            horizontalTitleGap: 0,
            title: Text(
              TR.of(context).logout,
              style: context.bodyText1,
            ),
          ),
        )
      ],
    );
  }

  SliverToBoxAdapter _buildItem({
    required BuildContext context,
    required String label,
    required String icon,
    required VoidCallback onTap,
  }) {
    return SliverToBoxAdapter(
      child: GestureDetector(
        onTap: onTap,
        child: ListTile(
          leading: AssetIcon(icon),
          trailing: AssetIcon(R.assetsImagesArrowRight),
          horizontalTitleGap: 0,
          title: Text(
            label,
            style: context.bodyText1,
          ),
        ),
      ),
    );
  }
}
