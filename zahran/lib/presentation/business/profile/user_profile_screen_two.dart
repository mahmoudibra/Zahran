import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/presentation/business/profile/profile_view_model.dart';
import 'package:zahran/presentation/commom/media_picker/media_local.domain.dart';
import 'package:zahran/presentation/commom/media_picker/media_picker.dart';
import 'package:zahran/presentation/commom/rounded_image.dart';
import 'package:zahran/presentation/commom/toolbox.helper.dart';
import 'package:zahran/presentation/localization/tr.dart';

class UserProfileScreen extends StatelessWidget {
  final ProgressButtonKey buttonKey = ProgressButtonKey();

  UserProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: UserProfileViewModel(context),
      builder: (UserProfileViewModel vm) {
        return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: AppBar(
              elevation: 0,
              title: Text(
                TR.of(context).profile,
                style: Theme.of(context).textTheme.headline6,
              ),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              leading: BackButton(
                  color: Theme.of(context).textTheme.headline6?.color),
            ),
            body: buildCompletedForm(context, vm));
      },
    );
  }

  Widget buildCompletedForm(BuildContext context, UserProfileViewModel vm) {
    return CompletedForm(
      onPostData: vm.submitChanges,
      child: Container(
        child: Padding(
          padding: EdgeInsetsDirectional.only(start: 16, end: 16, bottom: 30),
          child: SingleChildScrollView(
            child: Column(
              key: Key(vm.lastFetch ?? ""),
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ViewsToolbox.emptySpaceWidget(height: 24),
                buildUserImage(context, vm),
                ViewsToolbox.emptySpaceWidget(height: 24),
                Text(
                  TR.of(context).username,
                  style: context.bodyText1,
                ),
                SizedBox(height: 10),
                buildUserNameTextField(context, vm),
                SizedBox(height: 20),
                Text(
                  TR.of(context).phone_number,
                  style: context.bodyText1,
                ),
                SizedBox(height: 10),
                buildPhoneNumberTextField(context, vm),
                ViewsToolbox.emptySpaceWidget(height: 16),
                buildChangePassword(context, vm),
                SizedBox(height: 30),
                ProgressButton(
                  key: buttonKey,
                  child: Text(TR.of(context).login),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildChangePassword(BuildContext context, UserProfileViewModel vm) {
    return Center(
      child: GestureDetector(
        onTap: vm.changePassword,
        child: Text(
          TR.of(context).change_password,
          style: Theme.of(context).textTheme.subtitle1?.copyWith(
                color: Theme.of(context).colorScheme.error,
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
    );
  }

  Widget buildPhoneNumberTextField(
      BuildContext context, UserProfileViewModel vm) {
    return CustomTextField(
      initialValue: vm.userModel?.phone,
      hint: TR.of(context).phone_number,
      onSaved: (v) => vm.phoneNumber = v,
      extraValidator: vm.validatePhoneNumber,
      textInputType: TextInputType.number,
      textInputAction: TextInputAction.go,
      onFieldSubmitted: (v) {
        buttonKey.onPressed();
      },
    );
  }

  Widget buildUserNameTextField(BuildContext context, UserProfileViewModel vm) {
    return CustomTextField(
        initialValue: vm.userModel?.name.format(context),
        onSaved: (v) => vm.userName = v,
        hint: TR.of(context).username,
        textInputType: TextInputType.name,
        extraValidator: vm.validateUserName);
  }

  Widget buildUserImage(BuildContext context, UserProfileViewModel vm) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Container(
            width: 150,
            height: 150,
            child: RoundedImage(
              radius: 150,
              borderSize: 2,
              borderColor: Theme.of(context).colorScheme.primary,
              imageUrl: vm.userModel?.media ?? "",
              loadingIndicatorSize: 50,
            ),
          ),
        ),
        ViewsToolbox.emptySpaceWidget(height: 8),
        GestureDetector(
          onTap: vm.selectImage,
          child: Center(
            child: Text(
              TR.of(context).change_image,
              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                    color: Theme.of(context).colorScheme.primaryVariant,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> showImageComponent(
      BuildContext context, UserProfileViewModel vm) async {
    await Future.delayed(Duration.zero);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return MediaPickerComponent(
            mediaPickerFileCallback: ({required MediaLocal? mediaModel}) {
              // widget.updateProfilePM.mediaFilePicked(mediaModel);
            },
            mediaPickerType: vm.mediaPickerType,
            onMediaDismissedCallback: () {
              vm.onMediaDismissed();
            },
          );
        });
  }
}
