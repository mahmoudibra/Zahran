import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/presentation/business/base/auth_view_model.dart';
import 'package:zahran/presentation/localization/tr.dart';

class ProfileTabsAppBar extends StatelessWidget {
  final double expansion;

  const ProfileTabsAppBar({Key? key, required this.expansion})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var avatarWidth = width * 0.12;
    avatarWidth = (avatarWidth * 0.6) + (avatarWidth * 0.4 * expansion);
    return GetBuilder<AuthViewModel>(
      builder: (AuthViewModel vm) {
        return SafeArea(
          bottom: false,
          child: Container(
            alignment: AlignmentGeometryTween(
                    begin: Alignment.center, end: Alignment.bottomCenter)
                .transform(expansion),
            padding: EdgeInsets.symmetric(horizontal: 16)
                .copyWith(bottom: 15 * expansion, top: 15 * expansion),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _profile(vm, avatarWidth, context, expansion),
                Opacity(
                  opacity: expansion,
                  child: Transform.translate(
                    offset: Offset(0, 1),
                    child: Container(
                      alignment: AlignmentDirectional.topEnd,
                      padding: EdgeInsetsDirectional.only(end: 30),
                      child: CustomPaint(
                        painter: TrianglePainter(),
                        child: SizedBox(
                          width: avatarWidth * 1.25,
                          height: 15 * expansion,
                        ),
                      ),
                    ),
                  ),
                ),
                Opacity(
                  opacity: expansion,
                  child: FittedBox(
                    child: Card(
                      margin: EdgeInsets.zero,
                      child: ClipRect(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Container(
                          height: kToolbarHeight * 2.5 * expansion,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(15 * expansion),
                          alignment: AlignmentDirectional.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                children: [
                                  Spacer(flex: 1),
                                  _counter(
                                      context,
                                      vm.profile!.target.totalSellOut.toInt(),
                                      TR.of(context).total_sell_out),
                                  Spacer(flex: 3),
                                  _counter(
                                      context,
                                      vm.profile!.target.target.toInt(),
                                      TR.of(context).target),
                                  Spacer(flex: 1),
                                ],
                              ),
                              Spacer(),
                              AutoSizeText(
                                DateFormat.yMMMMd()
                                    .format(vm.profile!.lastVisit),
                                style: context.headline6,
                                maxLines: 1,
                                textAlign: TextAlign.center,
                              ),
                              AutoSizeText(
                                TR.of(context).last_visit,
                                style: context.caption,
                                maxLines: 1,
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Column _counter(BuildContext context, int v, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("${v}", style: context.headline6, maxLines: 1),
        Text(label, style: context.caption, maxLines: 1),
      ],
    );
  }

  Row _profile(AuthViewModel vm, double avatarWidth, BuildContext context,
      double expansion) {
    var progressWidth = avatarWidth + (0.25 * avatarWidth * expansion);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShapedRemoteImage(
          url: vm.profile!.media,
          decoration:
              BoxDecoration(borderRadius: BorderRadius.circular(avatarWidth)),
          width: avatarWidth,
          height: avatarWidth,
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 5 * (1 - expansion)),
              PrimaryTextStyles.headline6(
                child: Text(
                  TR.of(context).welcome(vm.profile!.name.format(context)),
                  style: TextStyle(fontSize: 14 + 4 * expansion),
                ),
              ),
              SizedBox(height: 5 * expansion),
              PrimaryTextStyles.caption(
                child: Text(
                  TR.of(context).user_id("${vm.profile?.id}"),
                  style: TextStyle(fontSize: 16 * expansion),
                ),
              )
            ],
          ),
        ),
        CircleAvatar(
          radius: progressWidth / 2,
          backgroundColor: Colors.white,
          child: CircularPercentIndicator(
            radius: progressWidth,
            lineWidth: 3.0 + 4.0 * expansion,
            percent: vm.targetPercentage,
            center: SizedBox(
              width: avatarWidth - 10,
              child: AutoSizeText(
                "${(vm.targetPercentage * 100).percentPattern()}",
                maxLines: 1,
                minFontSize: 5,
                style: TextStyle(color: context.theme.colorScheme.secondary),
              ),
            ),
            progressColor: context.theme.colorScheme.secondary,
            backgroundColor:
                context.theme.colorScheme.secondary.withOpacity(0.15),
            animateFromLastPercent: true,
            circularStrokeCap: CircularStrokeCap.round,
          ),
        ),
        SizedBox(width: 30)
      ],
    );
  }
}

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 0
      ..style = PaintingStyle.fill;
    var path = Path()
      ..moveTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..lineTo(size.width * 0.25, 0)
      ..arcToPoint(Offset(size.width * 0.75, 0),
          radius: Radius.circular(size.width / 2), clockwise: false)
      ..lineTo(size.width, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(TrianglePainter oldDelegate) {
    return false;
  }
}
