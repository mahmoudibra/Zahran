import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/r.dart';

class MapView extends StatefulWidget {
  const MapView({Key? key}) : super(key: key);

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  static BitmapDescriptor? markerIcon;
  void setCustomMarker() async {
    markerIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), R.assetsImagesMarker);
    setState(() {});
  }

  @override
  void initState() {
    if (markerIcon == null) setCustomMarker();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BranchModel model =
        ModalRoute.of(context)!.settings.arguments as BranchModel;
    var latlng = LatLng(model.location.lat, model.location.lang);
    var color = Theme.of(context).accentColor;
    double radius = 15000;
    return GoogleMap(
      mapType: MapType.normal,
      myLocationButtonEnabled: false,
      compassEnabled: false,
      initialCameraPosition: CameraPosition(
        target: latlng,
        zoom: 8,
      ),
      circles: [
        Circle(
            circleId: CircleId("1"),
            center: latlng,
            radius: radius,
            fillColor: color.withOpacity(0.15),
            strokeWidth: 0,
            zIndex: 0),
        Circle(
            circleId: CircleId("2"),
            center: latlng,
            radius: radius * 0.75,
            fillColor: color.withOpacity(0.3),
            strokeWidth: 0,
            zIndex: 2),
        Circle(
            circleId: CircleId("3"),
            center: latlng,
            radius: radius * 0.5,
            fillColor: color.withOpacity(0.45),
            strokeWidth: 0,
            zIndex: 3),
        Circle(
          circleId: CircleId("4"),
          center: latlng,
          radius: radius * 0.25,
          fillColor: color,
          strokeWidth: 0,
          zIndex: 4,
        ),
      ].toSet(),
      zoomControlsEnabled: false,
      zoomGesturesEnabled: false,
      onMapCreated: (GoogleMapController controller) {},
    );
  }
}
