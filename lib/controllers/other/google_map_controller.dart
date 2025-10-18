import 'package:flatten/controllers/my_controller.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapPageController extends MyController {
  GoogleMapController? mapController;

  GoogleMapPageController();

  void onGoogleMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
}
