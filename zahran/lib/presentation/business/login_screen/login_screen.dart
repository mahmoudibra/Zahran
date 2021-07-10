import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/presentation/business/login_screen/login_view_model.dart';
import 'package:zahran/presentation/commom/gradient_container.dart';
import 'package:zahran/presentation/commom/scaffold_with_bottom_sheet.dart';
import 'package:zahran/presentation/localization/tr.dart';
import 'package:zahran/r.dart';

class LoginScreen extends StatelessWidget {
  final ProgressButtonKey buttonKey = ProgressButtonKey();
  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: LoginViewModel(context, false),
      builder: (LoginViewModel vm) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: CompletedForm(
            onPostData: vm.login,
            child: GradientContainer(
              child: ScafoldWithBottomSheet(
                background: Colors.transparent,
                body: (offset) {
                  return Container(
                    height: MediaQuery.of(context).size.height * (1 - offset),
                    alignment: Alignment.center,
                    child: Image.asset(R.assetsImagesAppLogo),
                  );
                },
                bottom: (scrollController, offset) => _LoginSheet(
                    buttonKey: buttonKey, scrollController: scrollController),
              ),
            ),
          ),
        );
      },
    );
  }
}

class LoginSheet extends StatelessWidget {
  final ProgressButtonKey buttonKey = ProgressButtonKey();
  LoginSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: LoginViewModel(context, true),
      builder: (LoginViewModel vm) {
        return CompletedForm(
          onPostData: vm.login,
          child: _LoginSheet(buttonKey: buttonKey),
        );
      },
    );
  }
}

class _LoginSheet extends StatelessWidget {
  _LoginSheet({
    Key? key,
    required this.buttonKey,
    this.scrollController,
  }) : super(key: key);

  final ProgressButtonKey buttonKey;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    var vm = Get.find<LoginViewModel>();
    bool isBottomSheet = ModalRoute.of(context) is PopupRoute;
    return ListView(
      controller: scrollController,
      padding: const EdgeInsets.all(20).copyWith(
          bottom: 20 +
              (isBottomSheet ? MediaQuery.of(context).viewInsets.bottom : 0)),
      shrinkWrap: true,
      children: [
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
          maxLength: 8,
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
    );
  }
}
