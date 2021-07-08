import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';

class ProgressGradiant extends StatelessWidget {
  final double progress;
  const ProgressGradiant({Key key, @required this.progress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 7,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Color(0xFFBDBCD1),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
      ),
      alignment: AlignmentDirectional.centerStart,
      child: LayoutBuilder(
        builder: (context, constrains) {
          return Container(
            height: 7,
            width: constrains.maxWidth * progress,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
              gradient: LinearGradient(colors: [
                context.theme.colorScheme.secondaryVariant,
                context.theme.colorScheme.secondary,
              ]),
            ),
          );
        },
      ),
    );
  }
}
