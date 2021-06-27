import 'package:flutter/material.dart';
import 'package:zahran/presentation/commom/media_picker/MediaFileTypes.dart';
import 'package:zahran/presentation/external/permission/permission_handler.manager.dart';

import '../toolbox.helper.dart';

class PermissionPopUp extends StatelessWidget {
  final PermissionType service;
  final MediaFileTypes mediaType;
  final Function onOpenSettings;
  final Function onDismiss;
  final bool isMandatory;

  PermissionPopUp(
      {@required this.service,
      this.onOpenSettings,
      @required this.mediaType,
      this.onDismiss,
      this.isMandatory = false});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        decoration:
            BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor, borderRadius: BorderRadius.circular(25.0)),
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
              style: Theme.of(context).textTheme.subtitle1.copyWith(color: Theme.of(context).textTheme.bodyText2.color),
              textAlign: TextAlign.center,
            ),
            ViewsToolbox.mainButton(
                context: context, text: 'permission_access_change_settings_button', callback: onOpenSettings),
            isMandatory
                ? ViewsToolbox.emptyWidget()
                : ViewsToolbox.secondaryButton(
                    context: context, text: 'permission_access_dismiss_button', callback: onDismiss)
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
        title = 'permission_access_microphone_title';
        break;
      case PermissionType.Camera:
        title = 'permission_access_camera_title';
        break;
      case PermissionType.Gallery:
        title = 'permission_access_gallery_title';
        break;
      case PermissionType.Location:
        title = 'permission_access_location_title';
        break;
    }
    return title;
  }

  String _getMessage(BuildContext context) {
    String message = '';
    switch (service) {
      case PermissionType.Microphone:
        message = 'permission_access_microphone_message';
        break;
      case PermissionType.Camera:
        {
          switch (mediaType) {
            case MediaFileTypes.IMAGE:
              message = 'permission_access_camera_message';
              break;
            case MediaFileTypes.VIDEO:
              message = 'permission_access_video_camera_message';
              break;
          }
          break;
        }
      case PermissionType.Gallery:
        switch (mediaType) {
          case MediaFileTypes.IMAGE:
            message = 'permission_access_gallery_message';
            break;
          case MediaFileTypes.VIDEO:
            message = 'permission_access_video_gallery_message';
            break;
        }
        break;
      case PermissionType.Location:
        message = 'permission_access_location_message';
        break;
    }
    return message;
  }

  String _getArt() {
    String path = '';
    switch (service) {
      case PermissionType.Microphone:
        path = 'assets/images/mic-access.png';
        break;
      case PermissionType.Camera:
        path = 'assets/images/camera-access.png';
        break;
      case PermissionType.Gallery:
        path = 'assets/images/gallery-access.png';
        break;
      case PermissionType.Location:
        path = 'assets/images/location-access.png';
        break;
    }
    return path;
  }
}
