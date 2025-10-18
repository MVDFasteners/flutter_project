import 'package:flatten/controllers/my_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:latlong2/latlong.dart';

class LeafletController extends MyController {
  MapController? mapController;

  bool isCircleShowing = false;
  bool isLineShowing = false;
  bool isImageShowing = false;

  MapOptions getMapOption() {
    return MapOptions(
      onMapReady: () {
        mapController!.mapEventStream.listen((evt) {});
      },
      // center: LatLng(39.5389039, -94.4817994),
      // zoom: 6,
    );
  }

  List<CircleMarker> getCircleMarkers() {
    return [
      CircleMarker(
        point: LatLng(40.5389039, -94.4817994),
        radius: 10000,
        color: Colors.transparent,
        useRadiusInMeter: true,
        borderStrokeWidth: 4,
        borderColor: Colors.black,
      )
    ];
  }

  List<Polyline> getPolyLines() {
    return [
      Polyline(
        // isDotted: true,
        strokeWidth: 16,
        strokeCap: StrokeCap.square,
        points: [
          LatLng(39.5389039, -94.4817994),
          LatLng(36.5389039, -94.4817994),
          LatLng(37.5389039, -94.4817994),
        ],
        color: Colors.blue,
      ),
    ];
  }

  List<Marker> getMarkerLayers() {
    return [
      Marker(
        width: 80,
        point: LatLng(38.5389039, -90.4817994),
        height: 80,
        rotate: true,
        // builder: (context) => FlutterLogo(),
        child: FlutterLogo(),
      ),
    ];
  }

  void onChangeCircleShowing() {
    isCircleShowing = !isCircleShowing;
    update();
  }

  void onChangeLineShowing() {
    isLineShowing = !isLineShowing;
    update();
  }

  void onChangeImageShowing() {
    isImageShowing = !isImageShowing;
    update();
  }

  @override
  void onInit() {
    mapController = MapController();
    super.onInit();
  }
}
