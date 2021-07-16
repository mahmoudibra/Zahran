import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';

class Search {
  final String title;
  final bool enabled;
  final String? intialValue;
  final ValueChanged<String?> onChanged;

  Search({
    required this.title,
    required this.onChanged,
    required this.intialValue,
    required this.enabled,
  });
}

class PreferedSizeTitle extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final Search? search;
  const PreferedSizeTitle({Key? key, required this.title, this.search})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      padding: EdgeInsets.symmetric(horizontal: 20),
      alignment: AlignmentGeometryTween(
        begin: AlignmentDirectional.centerStart,
        end: AlignmentDirectional.center,
      ).transform(context.appBarExpansionPercent),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: context.headline2,
          ),
          if (search != null) ...[
            SizedBox(height: 10),
            CustomTextField(
              hint: search!.title,
              onChanged: search!.onChanged,
              initialValue: search!.intialValue,
              enabled: search!.enabled,
              suffixIcon: Icon(Icons.search),
            )
          ]
        ],
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight * (search == null ? 1 : 2));
}
