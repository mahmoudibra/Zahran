import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/presentation/business/more/change_password/change_password_view_model.dart';
import 'package:zahran/presentation/commom/scaffold_silver_app_bar.dart';
import 'package:zahran/presentation/commom/toolbox.helper.dart';
import 'package:zahran/presentation/localization/tr.dart';

class ChangePasswordScreen extends StatelessWidget {
  final ProgressButtonKey buttonKey = ProgressButtonKey();

  ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: ChangePasswordViewModel(context),
      builder: (ChangePasswordViewModel vm) {
        return ScaffoldSilverAppBar(
          content: buildCompletedForm(context, vm),
          title: TR.of(context).change_password,
        );
      },
    );
  }

  //
  Widget buildCompletedForm(BuildContext context, ChangePasswordViewModel vm) {
    return CompletedForm(
      onPostData: vm.saveChanges,
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ViewsToolbox.emptySpaceWidget(height: 24),
              Text(
                TR.of(context).old_password,
                style: context.bodyText1,
              ),
              SizedBox(height: 10),
              buildOldPassword(context, vm),
              SizedBox(height: 20),
              Text(
                TR.of(context).new_password,
                style: context.bodyText1,
              ),
              SizedBox(height: 10),
              buildNewPassword(context, vm),
              SizedBox(height: 20),
              Text(
                TR.of(context).confirm_new_password,
                style: context.bodyText1,
              ),
              SizedBox(height: 10),
              buildConfirmNewPassword(context, vm),
              SizedBox(height: 30),
              ProgressButton(
                key: buttonKey,
                child: Text(TR.of(context).save_changes),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildOldPassword(BuildContext context, ChangePasswordViewModel vm) {
    return CustomTextField.password(
        hint: TR.of(context).old_password, onSaved: (v) => vm.oldPassword = v, extraValidator: vm.validateOldPassword);
  }

  Widget buildNewPassword(BuildContext context, ChangePasswordViewModel vm) {
    return CustomTextField.password(
      hint: TR.of(context).new_password,
      onSaved: (v) => vm.newPassword = v,
      extraValidator: vm.validateNewPassword,
    );
  }

  Widget buildConfirmNewPassword(BuildContext context, ChangePasswordViewModel vm) {
    return CustomTextField.password(
      hint: TR.of(context).confirm_new_password,
      onSaved: (v) => vm.confirmNewPassword = v,
      extraValidator: vm.validateConfirmNewPassword,
      textInputAction: TextInputAction.go,
      onFieldSubmitted: (v) {
        buttonKey.onPressed();
      },
    );
  }
}
