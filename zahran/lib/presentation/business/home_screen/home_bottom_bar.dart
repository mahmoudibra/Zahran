import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/r.dart';

class HomeBottomBar extends StatelessWidget {
  const HomeBottomBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabControllerLisner(builder: (int index) {
      return BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(R.assetsImagesArrowDown),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(R.assetsImagesArrowDown),
          )
        ],
      );
    });
  }
}
