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
          icon: R.assetsImgsPerson,
          onTap: () {
            ScreenNames.USER_PROFILE.push();
          },
        ),
        _buildItem(
          context: context,
          label: TR.of(context).promotions,
          icon: R.assetsImgsPromotions,
          onTap: () {
            ScreenNames.PROMOTION_LIST.push();
          },
        ),
        _buildItem(
          context: context,
          label: TR.of(context).branches,
          icon: R.assetsImgsBranchs,
          onTap: () {
            ScreenNames.BRANCH_LIST.push();
          },
        ),
        _buildItem(
          context: context,
          label: TR.of(context).brands_products,
          icon: R.assetsImgsBrands,
          onTap: () {
            ScreenNames.BRANDS_LIST.push();
          },
        ),
        _buildItem(
          context: context,
          label: TR.of(context).report,
          icon: R.assetsImgsReport,
          onTap: () {},
        ),
        _buildItem(
          context: context,
          label: TR.of(context).check_in,
          icon: R.assetsImgsCheckIn,
          onTap: () {},
        ),
        _buildItem(
          context: context,
          label: TR.of(context).sallary_slip,
          icon: R.assetsImgsSallary,
          onTap: () {
            ScreenNames.Sallery_LIST.push();
          },
        ),
        _buildItem(
          context: context,
          label: TR.of(context).shared_documents,
          icon: R.assetsImgsSharedDocumnets,
          onTap: () {},
        ),
        _buildItem(
          context: context,
          label: TR.of(context).settings,
          icon: R.assetsImgsSettings,
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
            leading: AssetIcon(R.assetsImgsLogout),
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
