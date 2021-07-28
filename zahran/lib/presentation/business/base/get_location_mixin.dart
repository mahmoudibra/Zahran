import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/presentation/commom/pop_up/permission_popup.component.dart';
import 'package:zahran/presentation/external/permission/permission_handler.manager.dart';
import 'package:zahran/presentation/localization/tr.dart';

mixin GetLocationMixin on GetxController {
  BuildContext get context;
  bool? _serviceEnabled;
  bool get serviceEnabled => _serviceEnabled == true;
  LocationPermission? _permission;
  LocationPermission get permission => _permission ?? LocationPermission.denied;
  bool get permissionGranted =>
      permission == LocationPermission.whileInUse ||
      permission == LocationPermission.always;

  Future checkEnabled() async {
    _serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled)
      return Future.error(TR.of(context).permission_access_location_message);
    _permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      _permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error(TR.of(context).permission_access_location_message);
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(TR.of(context).permission_access_location_message);
    }
  }

  Future<Position> getCurrentPosition([bool showPopUp = true]) async {
    try {
      await checkEnabled();
    } catch (e) {
      if (showPopUp) {
        await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) {
              return PermissionPopUp(
                service: PermissionType.Location,
                isMandatory: true,
                onOpenSettings: () async {
                  WidgetsBinding.instance?.addObserver(_Observer(_, this));
                  await Geolocator.openLocationSettings();
                },
              );
            });
        await checkEnabled();
      }
    }
    return await Geolocator.getCurrentPosition();
  }
}

class _Observer extends WidgetsBindingObserver {
  final BuildContext context;
  final GetLocationMixin vm;

  _Observer(this.context, this.vm);
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      await vm.checkEnabled();
      if (vm.serviceEnabled && vm.permissionGranted) {
        Navigator.of(context).pop();
        WidgetsBinding.instance?.removeObserver(this);
      }
    }
  }
}
