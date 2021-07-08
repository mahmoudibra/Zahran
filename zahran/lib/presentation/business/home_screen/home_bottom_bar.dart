import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/presentation/localization/ext.dart';
import 'package:zahran/r.dart';

class HomeBottomBar extends StatelessWidget {
  const HomeBottomBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabControllerLisner(builder: (int index) {
      return Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
                blurRadius: 8, offset: Offset(0, -4), color: Color(0xFFEDEDF3))
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: index,
          elevation: 0,
          onTap: (i) {
            DefaultTabController.of(context).index = i;
          },
          items: [
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage(R.assetsImagesCallIcon)),
              label: TR.of(context).visits,
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage(R.assetsImagesCallIcon)),
              label: TR.of(context).profile,
            )
          ],
        ),
      );
    });
  }
}
