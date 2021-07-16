import 'package:flutter/material.dart';
import 'package:zahran/presentation/commom/media_picker/MediaFileTypes.dart';
import 'package:zahran/presentation/external/permission/permission_handler.manager.dart';
import 'package:zahran/presentation/localization/tr.dart';
import 'package:zahran/r.dart';

import '../toolbox.helper.dart';

class PermissionPopUp extends StatelessWidget {
  final PermissionType service;
  final MediaFileTypes? mediaType;
  final VoidCallback? onOpenSettings;
  final VoidCallback? onDismiss;
  final bool isMandatory;

  PermissionPopUp({
    required this.service,
    this.onOpenSettings,
    this.mediaType,
    this.onDismiss,
    this.isMandatory = false,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(25.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset(_getArt()),
            Padding(
              padding: EdgeInsets.only(top: 40, bottom: 16.0),
              child: Text(
                _getTitle(context),
                style: Theme.of(context).textTheme.headline6,
                textAlign: TextAlign.center,
              ),
            ),
            Text(
              _getMessage(context),
              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                  color: Theme.of(context).textTheme.bodyText2?.color),
              textAlign: TextAlign.center,
            ),
            ElevatedButton(
              child:
                  Text(TR.of(context).permission_access_change_settings_button),
              onPressed: onOpenSettings,
            ),
            isMandatory
                ? ViewsToolbox.emptyWidget()
                : OutlinedButton(
                    child:
                        Text(TR.of(context).permission_access_dismiss_button),
                    onPressed: onDismiss,
                  )
          ],
        ),
      ),
    );
  }

  // Helpers
  String _getTitle(BuildContext context) {
    String title = '';
    switch (service) {
      case PermissionType.Microphone:
        title = TR.of(context).permission_access_microphone_title;
        break;
      case PermissionType.Camera:
        title = TR.of(context).permission_access_camera_title;
        break;
      case PermissionType.Gallery:
        title = TR.of(context).permission_access_gallery_title;
        break;
      case PermissionType.Location:
        title = TR.of(context).permission_access_location_title;
        break;
    }
    return title;
  }

  String _getMessage(BuildContext context) {
    String message = '';
    switch (service) {
      case PermissionType.Microphone:
        message = TR.of(context).permission_access_microphone_message;
        break;
      case PermissionType.Camera:
        {
          switch (mediaType) {
            case MediaFileTypes.IMAGE:
              message = TR.of(context).permission_access_camera_message;
              break;
            case MediaFileTypes.VIDEO:
              message = TR.of(context).permission_access_video_camera_message;
              break;
          }
          break;
        }
      case PermissionType.Gallery:
        switch (mediaType) {
          case MediaFileTypes.IMAGE:
            message = TR.of(context).permission_access_gallery_message;
            break;
          case MediaFileTypes.VIDEO:
            message = TR.of(context).permission_access_video_gallery_message;
            break;
        }
        break;
      case PermissionType.Location:
        message = TR.of(context).permission_access_location_message;
        break;
    }
    return message;
  }

  String _getArt() {
    String path = '';
    switch (service) {
      case PermissionType.Microphone:
        path = R.assetsImgsMicAccess;
        break;
      case PermissionType.Camera:
        path = R.assetsImgsCameraAccess;
        break;
      case PermissionType.Gallery:
        path = R.assetsImgsGalleryAccess;
        break;
      case PermissionType.Location:
        path = R.assetsImgsLocationAccess;
        break;
    }
    return path;
  }
}
