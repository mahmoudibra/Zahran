import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/presentation/business/more/setting/setting_view_model.dart';
import 'package:zahran/presentation/commom/scaffold_silver_app_bar.dart';
import 'package:zahran/presentation/commom/toolbox.helper.dart';
import 'package:zahran/presentation/localization/tr.dart';

class SettingScreen extends StatelessWidget {
  final ProgressButtonKey buttonKey = ProgressButtonKey();

  SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: SettingViewModel(context),
      builder: (SettingViewModel vm) {
        return ScaffoldSilverAppBar(
          content: buildCompletedForm(context, vm),
          title: TR.of(context).setting,
        );
      },
    );
  }

  Widget buildCompletedForm(BuildContext context, SettingViewModel vm) {
    return Container(
      child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        ViewsToolbox.emptySpaceWidget(height: 24),
        notificationSettingSection(context, vm),
        ViewsToolbox.emptySpaceWidget(height: 12),
        Divider(height: 1),
        ViewsToolbox.emptySpaceWidget(height: 12),
        Text(
          TR.of(context).language,
          style: Theme.of(context)
              .textTheme
              .subtitle1
              ?.copyWith(fontWeight: FontWeight.w600, color: Theme.of(context).textTheme.headline4?.color),
        ),
        ViewsToolbox.emptySpaceWidget(height: 8),
        languageSection(context),
        ViewsToolbox.emptySpaceWidget(height: 30),
        ProgressButton(
          onPressed: () => vm.submitChanges(),
          child: Text(TR.of(context).save_changes),
        ),
      ]),
    );
  }

  Widget notificationSettingSection(BuildContext context, SettingViewModel vm) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                TR.of(context).allow_notifications,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    ?.copyWith(fontWeight: FontWeight.w600, color: Theme.of(context).textTheme.headline4?.color),
              ),
              ViewsToolbox.emptySpaceWidget(height: 2),
              Text(
                TR.of(context).allow_notifications_description,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    ?.copyWith(fontWeight: FontWeight.w300, color: Theme.of(context).textTheme.headline4?.color),
              ),
            ],
          ),
        ),
        CupertinoSwitch(
          onChanged: (isOpen) => onNotificationSettingsChanged(isOpen),
          value: vm.userModel?.notificationEnabled ?? false,
          activeColor: Colors.green,
        ),
      ],
    );
  }

  Widget languageSection(BuildContext context) {
    return Row(
      children: <Widget>[
        Flexible(
          flex: 1,
          child: GestureDetector(
            onTap: () {},
            child: Container(
              height: 32,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Center(
                child: Text(
                  TR.of(context).english,
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              ),
            ),
          ),
        ),
        ViewsToolbox.emptySpaceWidget(width: 12),
        Flexible(
          flex: 1,
          child: GestureDetector(
            onTap: () {},
            child: Container(
              height: 32,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Center(
                child: Text(
                  TR.of(context).arabic,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      ?.copyWith(fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.primary),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void onNotificationSettingsChanged(bool isNotificationOn) {
    print("isNotificationOn: $isNotificationOn");
  }
}
