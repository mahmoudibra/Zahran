import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/commom/flare_component.dart';
import 'package:zahran/presentation/commom/pop_up/pop_up.component.dart';
import 'package:zahran/presentation/localization/tr.dart';
import 'package:zahran/r.dart';

import 'report_view_model.dart';

class BaseReportScreen extends StatefulWidget {
  final String title;
  final ReportTypes type;
  final bool showPlaceholder;
  final Future Function(ReportViewModel vm) callBack;
  final List<Widget> Function(ReportViewModel vm) slivers;
  const BaseReportScreen({
    Key? key,
    required this.title,
    required this.slivers,
    required this.type,
    this.showPlaceholder = true,
    required this.callBack,
  }) : super(key: key);

  @override
  _BaseReportScreenState createState() => _BaseReportScreenState();
}

class _BaseReportScreenState extends State<BaseReportScreen> {
  late ScrollController _controller;
  bool hide = false;
  Timer? timer;
  void _scrollListener() {
    timer?.cancel();
    timer = Timer(Duration(milliseconds: 700), () {
      if (hide)
        setState(() {
          hide = false;
        });
    });
    var direction = _controller.position.userScrollDirection;
    if (direction == ScrollDirection.forward ||
        direction == ScrollDirection.idle) {
      if (hide)
        setState(() {
          hide = false;
        });
    }
    if (direction == ScrollDirection.reverse) {
      if (!hide) {
        setState(() {
          hide = true;
        });
      }
    }
  }

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: KeyBoadUnfocusAction(
        child: GetBuilder<ReportViewModel>(
          init: ReportViewModel(widget.type, context),
          builder: (ReportViewModel vm) {
            return Stack(
              children: [
                _buildBody(context, vm),
                if (MediaQuery.of(context).viewInsets.bottom == 0)
                  AnimatedPositioned(
                    curve: Curves.easeInOut,
                    left: 20,
                    right: 20,
                    bottom: hide ? -100 : 20,
                    duration: Duration(milliseconds: 800),
                    child: SafeArea(
                      child: _buildButton(vm, context),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  ProgressButton _buildButton(ReportViewModel vm, BuildContext context) {
    return ProgressButton(
      onPressed: vm.hasItems.onTrue(() async {
        showDialog(
            context: context,
            builder: (_) {
              return PopUp(
                context: context,
                message: TR.of(context).sendReportPopUpContent,
                onDismissedAction: () {},
                title: widget.title,
                actions: {
                  TR.of(context).send: () {
                    Navigator.of(context).pop();
                    FlareAnimation.show(
                      action: widget.callBack(vm),
                      context: context,
                    );
                  },
                },
              );
            });
      }),
      child: Text(TR.of(context).send),
    );
  }

  CustomScrollView _buildBody(BuildContext context, ReportViewModel vm) {
    return CustomScrollView(
      controller: _controller,
      slivers: [
        SliverAppBar(
          pinned: true,
          floating: true,
          backgroundColor: Theme.of(context).backgroundColor,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: Container(
              height: kToolbarHeight,
              width: MediaQuery.of(context).size.width,
              alignment: AlignmentDirectional.topStart,
              padding: EdgeInsets.symmetric(horizontal: 17),
              child: Text(widget.title, style: context.headline2),
            ),
          ),
        ),
        if (vm.box?.isOpen == true)
          ...widget.slivers(vm)
        else
          SliverFillRemaining(
            child: Center(child: CupertinoActivityIndicator()),
          ),
        if (vm.report.items.length == 0 && widget.showPlaceholder) ...[
          SliverFillRemaining(
            fillOverscroll: true,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    R.assetsImgsEmptyProducts,
                    width: 100,
                  ),
                  SizedBox(height: 20),
                  Text(
                    TR.of(context).add_product_hint,
                    style: context.headline6,
                  ),
                  SizedBox(height: 10),
                  Text(TR.of(context).add_product_hint_2)
                ],
              ),
            ),
          ),
        ],
        if (MediaQuery.of(context).viewInsets.bottom > 0)
          SliverPaddingBox(
            padding: EdgeInsets.all(20),
            child: _buildButton(vm, context),
          )
      ],
    );
  }
}
