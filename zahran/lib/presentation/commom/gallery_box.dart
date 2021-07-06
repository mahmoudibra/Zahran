import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zahran/presentation/config/configs.dart';

import 'cashed_Image.component.dart';

class GalleryBox extends StatefulWidget {
  final List<String> _photoURLs;
  final BuildContext _themeContext;
  final int _selected;
  final Function _onSelectedChanged;

  GalleryBox(
      {@required List<String> photoURLs,
      @required BuildContext themeContext,
      @required Function onSelectedChanged,
      int selected = 0})
      : _photoURLs = photoURLs,
        _themeContext = themeContext,
        _onSelectedChanged = onSelectedChanged,
        _selected = selected;

  @override
  _GalleryBoxState createState() => _GalleryBoxState();
}

class _GalleryBoxState extends State<GalleryBox> with TickerProviderStateMixin {
  int _currentPhotoIndex;
  AnimationController _colorController;
  Animation<Color> _color;
  AnimationController _opacityController;
  Animation<double> _opacity;
  PageController _pageController;

  @override
  void initState() {
    _currentPhotoIndex = widget._selected;

    _pageController = PageController(initialPage: widget._selected);
    _colorController = AnimationController(duration: Duration(milliseconds: 1500), vsync: this)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _colorController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _colorController.forward();
        }
      });

    _color = ColorTween(
            begin: Theme.of(widget._themeContext).textTheme.bodyText2.color.withOpacity(0.10),
            end: Theme.of(widget._themeContext).textTheme.bodyText2.color.withOpacity(0.38))
        .animate(_colorController);
    _colorController.forward();

    _opacityController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _opacity = CurvedAnimation(parent: _opacityController, curve: Curves.easeInOut);
    _opacityController.forward();

    super.initState();
  }

  @override
  void dispose() {
    _colorController.dispose();
    _opacityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return (widget._photoURLs == null || widget._photoURLs.isEmpty) ? _drawSkeleton() : _drawGallery();
  }

  // UI Builder
  Widget _drawSkeleton() {
    return AnimatedBuilder(
        animation: _colorController,
        builder: (context, child) {
          return Stack(
            alignment: Alignment.bottomRight,
            children: <Widget>[
              ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).scaffoldBackgroundColor,
                    BlendMode.saturation,
                  ),
                  child: Container(color: _color.value)),
              SvgPicture.asset(GeneralConfigs.SVG_PATH + "logo.svg", height: 20),
            ],
          );
        });
  }

  Widget _drawGallery() {
    return FadeTransition(
        opacity: _opacity,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[_drawPhotoPager(), _drawTreatment(), _drawStepper()],
        ));
  }

  Widget _drawPhotoPager() {
    print(widget._photoURLs);
    return PageView.builder(
      itemBuilder: (cntxt, ndx) {
        return CachedImage(
          imageUrl: widget._photoURLs[ndx],
          loadingIndicatorSize: 50.0,
        );
      },
      itemCount: widget._photoURLs.length,
      physics: ClampingScrollPhysics(),
      onPageChanged: _onPhotoChanged,
      controller: _pageController,
    );
  }

  Widget _drawStepper() {
    return widget._photoURLs.length < 2
        ? Container()
        : Positioned(
            height: 6.0,
            bottom: 20.0,
            left: 0.0,
            right: 0.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (dotCntxt, dotNdx) {
                    return Container(
                      height: 6.0,
                      width: 6.0,
                      margin: EdgeInsets.symmetric(horizontal: 3.0),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(dotNdx == _currentPhotoIndex ? 1.0 : 0.4),
                          borderRadius: BorderRadius.circular(3.0)),
                    );
                  },
                  itemCount: widget._photoURLs.length,
                ),
              ],
            ));
  }

  Widget _drawTreatment() {
    return IgnorePointer(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.0, 1.0),
            end: Alignment(0.0, 0.0),
            colors: <Color>[
              Colors.black.withOpacity(0.56),
              Colors.black.withOpacity(0.24),
            ],
          ),
        ),
      ),
    );
  }

  // UI Event
  void _onPhotoChanged(int newPhotoIndex) {
    setState(() {
      _currentPhotoIndex = newPhotoIndex;
      widget._onSelectedChanged(_currentPhotoIndex);
    });

    widget._onSelectedChanged(newPhotoIndex);
  }
}
