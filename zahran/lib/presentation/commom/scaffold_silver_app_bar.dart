import 'package:flutter/material.dart';

class ScaffoldSilverAppBar extends StatelessWidget {
  final String title;
  final Widget content;

  ScaffoldSilverAppBar({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          child: CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: <Widget>[
              SliverAppBar(
                elevation: 0.0,
                pinned: true,
                floating: true,
                stretch: true,
                centerTitle: false,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                expandedHeight: 100,
                leading: BackButton(color: Theme.of(context).textTheme.headline6?.color),
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: EdgeInsetsDirectional.only(start: 22, top: 0),
                  centerTitle: false,
                  title: Text(
                    title,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  stretchModes: [StretchMode.zoomBackground],
                ),
              ),
              SliverFillRemaining(
                child: content,
              )
            ],
          ),
        ));
  }
}
