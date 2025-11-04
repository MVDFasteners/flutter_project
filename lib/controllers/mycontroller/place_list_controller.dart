import 'dart:convert';
import 'dart:io';
import 'package:flatten/controllers/auth/login_controller.dart';
import 'package:flatten/controllers/mycontroller/trip_list_controller.dart';
import 'package:flatten/helpers/services/auth_service.dart';
import 'package:flatten/models/trip_list.dart';
import 'package:flatten/myPages/locaiton_service.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flatten/app_constant.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';

class PlaceListController extends GetxController {
  Trip currentTrip = Trip();
  List<RoutePoint> tripRouteList = [];
  List<TripEmployees> tripEmployees = [];
  TripListController tripListController = Get.put(TripListController());
  bool isFetchLoading = false;

  double? latitude;
  double? longitude;
  String address = "----";

  void updateCurrentTrip(Trip? trip) {
    currentTrip = trip ?? Trip();
    update();
  }

  Future<double?> updateLocation() async {
    isFetchLoading = true;
    update();
    Position? position = await LocationService().getCurrentPosition();
    if (position != null) {
      latitude = position.latitude;
      longitude = position.longitude;
      double lat = position.latitude;
      double long = position.longitude;
      print(lat + long);
      address = await LocationService().getAddressFromLatLng(lat, long);

      double? value = await calculateDistanceFromOldLocation(
        currentLat: lat,
        currentLong: long,
      );
      isFetchLoading = false;
      update();
      return value;
    }
  }

  Future<List<TripEmployees>> fetchTripEmployees({
    required String parentId,
  }) async {
    if (AuthService.sessionId == null) {
      print("❌ No session found. Please login first.");
      return [];
    }

    List<TripEmployees> list = [];

    final url = Uri.parse(
      "$baseUrl/api/method/my_api_app.api_methods.hr_modules_api.get_trip_employes",
    );

    final Map<String, dynamic> body = {"parent_id": parentId};

    try {
      final response = await http.post(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          "Cookie": AuthService.sessionId!, // ✅ use ERPNext session
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final tripsJson = data['message'] as List<dynamic>? ?? [];
        list.addAll(tripsJson.map((e) => TripEmployees.fromJson(e)).toList());
        print("✅ Travel Employees fetched: ${tripRouteList.length}");
      } else {
        print("❌ Error ${response.statusCode}: ${response.body}");
      }
    } catch (e) {
      print("⚠️ Error fetching travel routes: $e");
    }

    return list;
  }

  Future<void> fetchRoutesList({required String parentId}) async {
    if (AuthService.sessionId == null) {
      print("❌ No session found. Please login first.");
      return;
    }

    final url = Uri.parse(
      "$baseUrl/api/method/my_api_app.api_methods.hr_modules_api.get_travel_log_routes",
    );

    final Map<String, dynamic> body = {"parent_id": parentId};

    try {
      final response = await http.post(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          "Cookie": AuthService.sessionId!, // ✅ use ERPNext session
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        tripRouteList = [];
        final data = jsonDecode(response.body);

        final tripsJson = data['message'] as List<dynamic>? ?? [];
        tripRouteList.addAll(
          tripsJson.map((e) => RoutePoint.fromJson(e)).toList(),
        );

        print("✅ Travel Routes fetched: ${tripRouteList.length}");
      } else {
        print("❌ Error ${response.statusCode}: ${response.body}");
      }
    } catch (e) {
      print("⚠️ Error fetching travel routes: $e");
    }

    update();
  }

  // Future<void> fetchRoutesList({String? parentId}) async {
  //   if (AuthService.sessionId == null) {
  //     print("❌ No session found. Please login first.");
  //     return;
  //   }
  //
  //   final url = Uri.parse("$backendUrl/get_route_list_child");
  //   final body = {'cookie': AuthService.sessionId, 'parent_id': parentId};
  //
  //   try {
  //     final response = await http.post(
  //       url,
  //       headers: {HttpHeaders.contentTypeHeader: 'application/json'},
  //       body: jsonEncode(body),
  //     );
  //
  //     if (response.statusCode == 200) {
  //       tripRouteList = [];
  //       final data = jsonDecode(response.body);
  //       print("data $data");
  //       final tripsJson = data['message'] as List<dynamic>? ?? [];
  //       tripRouteList.addAll(
  //         tripsJson.map((e) => RoutePoint.fromJson(e)).toList(),
  //       );
  //       print(
  //         "Travel Routes length = ${tripRouteList.length} , ${tripRouteList}",
  //       );
  //     } else {
  //       print("❌ Error ${response.statusCode}: ${response.body}");
  //     }
  //   } catch (e) {
  //     print("⚠️ Error: ${e.toString()}");
  //   }
  //   update();
  // }

  Future<void> endTrip() async {
    double totalDistance = tripRouteList.fold(
      0.0,
      (sum, item) => sum + (item.distanceFromPreviousKm ?? 0),
    );
    currentTrip.endDate = DateTime.now().toString();
    currentTrip.status = "Completed";
    currentTrip.totalDistance = totalDistance;
    // currentTrip.routes = null;

    await tripListController.saveTripParent(trip: currentTrip);
    update();
  }

  Future<bool> saveTripChild({
    String? parentId,
    String? childId,
    double? distanceKm,
  }) async {
    isFetchLoading = true;
    update();
    final String finalTime = DateFormat(
      'dd-MM-yyyy HH:mm:ss',
    ).format(DateTime.now());
    final DateFormat inputFormat = DateFormat('dd-MM-yyyy HH:mm:ss');
    final DateTime dateTime = inputFormat.parse(finalTime);
    RoutePoint tripChildRoute = RoutePoint();
    if (childId == null || childId == "") {
      tripChildRoute = RoutePoint(
        parentId: parentId ?? currentTrip.name,
        address: address,
        distanceFromPreviousKm: distanceKm,
        latitude: latitude,
        longitude: longitude,
        timestamp: dateTime.toString(),
      );
    } else {
      tripChildRoute = RoutePoint(
        id: childId,
        parentId: parentId,
        address: address,
        distanceFromPreviousKm: 0,
        latitude: latitude,
        longitude: longitude,
        timestamp: dateTime.toString(),
      );
    }
    final url = Uri.parse(
      "$baseUrl/api/method/my_api_app.api_methods.hr_modules_api.save_trip_route",
    );
    final Map<String, dynamic> body = {'data': tripChildRoute.toJson()};
    try {
      final response = await http.post(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          'Cookie': AuthService.sessionId!, // ✅ Pass session cookie here
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['message']['name'] != null) {
          if (currentTrip.name != null) {
            await fetchRoutesList(parentId: currentTrip.name!);
          }
          isFetchLoading = false;
          update();
          return true;
        } else {
          return false;
        }
      }
    } catch (e) {
      print("⚠️ Error: ${e.toString()}");
      isFetchLoading = false;
      update();
      return false;
    }
    isFetchLoading = false;
    update();
    return false;
  }

  Future<double?> calculateDistanceFromOldLocation({
    required double? currentLat,
    required double? currentLong,
  }) async {
    double? lastLat;
    double? lastLong;
    RoutePoint lastRoute = tripRouteList.last;
    double? value;

    lastLat = lastRoute.latitude;
    lastLong = lastRoute.longitude;
    double thresholdMeters = 700;

    if (lastLat != null &&
        lastLong != null &&
        currentLat != null &&
        currentLong != null) {
      double distance = Geolocator.distanceBetween(
        lastLat,
        lastLong,
        currentLat,
        currentLong,
      );

      if (distance < thresholdMeters) {
        return 0; // treat as same point
      }

      value = await calculateDrivingDistance(
        startLat: lastLat,
        startLon: lastLong,
        endLat: currentLat,
        endLon: currentLong,
      );

      print(value);
    }
    return value;
  }

  Future<double?> calculateDrivingDistance({
    required double startLat,
    required double startLon,
    required double endLat,
    required double endLon,
  }) async {
    const String geoapifyApiKey = 'fbe450c2211c4b15922b6b420f5636ec';
    final String waypoints = '$startLat,$startLon|$endLat,$endLon';

    final String apiUrl =
        'https://api.geoapify.com/v1/routing?waypoints=$waypoints&mode=drive&apiKey=$geoapifyApiKey';

    print('Calling URL: $apiUrl'); // Helpful for debugging

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        // Navigate the JSON path confirmed by your test output
        final features = data['features'] as List<dynamic>?;

        if (features != null && features.isNotEmpty) {
          final properties =
              features.first['properties'] as Map<String, dynamic>?;

          // Get the distance in meters (as confirmed by your test response)
          final double? distanceInMeters = properties?['distance']?.toDouble();

          double? value = (distanceInMeters != null)
              ? distanceInMeters / 1000
              : null;
          return value;
        }
        return null;
      } else {
        print('Geoapify API Error: ${response.statusCode}');
        print('Body: ${response.body}');
        return null;
      }
    } on SocketException {
      print('Network error: Could not connect to Geoapify.');
      return null;
    } catch (e) {
      print('An unexpected error occurred: $e');
      return null;
    }
  }
}
