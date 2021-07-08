import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/presentation/business/login_screen/login_view_model.dart';
import 'package:zahran/presentation/commom/gradiant_container.dart';
import 'package:zahran/presentation/commom/scaffold_with_bottom_sheet.dart';
import 'package:zahran/presentation/localization/ext.dart';
import 'package:zahran/r.dart';

class LoginScreen extends StatelessWidget {
  final ProgressButtonKey buttonKey = ProgressButtonKey();
  LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: LoginViewModel(context),
      builder: (LoginViewModel vm) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: CompletedForm(
            onPostData: vm.login,
            child: GradiantContainer(
              child: ScafoldWithBottomSheet(
                background: Colors.transparent,
                body: (offset) {
                  return Container(
                    height: MediaQuery.of(context).size.height * (1 - offset),
                    alignment: Alignment.center,
                    child: Image.asset(R.assetsImagesAppLogo),
                  );
                },
                bottom: [
                  AutoSizeText(
                    TR.of(context).login_title,
                    style: context.headline4,
                  ),
                  AutoSizeText(TR.of(context).login_sub_title),
                  SizedBox(height: 30),
                  Text(
                    TR.of(context).sab_number,
                    style: context.bodyText1,
                  ),
                  SizedBox(height: 10),
                  CustomTextField(
                    onSaved: (v) => vm.sab = v,
                    textInputType: TextInputType.number,
                    extraValidator: vm.validateSab,
                  ),
                  SizedBox(height: 20),
                  Text(
                    TR.of(context).password,
                    style: context.bodyText1,
                  ),
                  SizedBox(height: 10),
                  CustomTextField(
                    onSaved: (v) => vm.password = v,
                    extraValidator: vm.validatePassword,
                    textInputAction: TextInputAction.go,
                    onFieldSubmitted: (v) {
                      buttonKey.onPressed();
                    },
                  ),
                  SizedBox(height: 30),
                  ProgressButton(
                    key: buttonKey,
                    child: Text(TR.of(context).login),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
