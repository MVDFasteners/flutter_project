import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:geocoding/geocoding.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class LocationService {
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  Future<Position?> getCurrentPosition() async {
    final hasPermission = await _handlePermission();
    if (!hasPermission) {
      print("Location permission denied.");
      return null;
    }

    try {
      final position = await Geolocator.getCurrentPosition();

      print("pos $position");
      return position;
    } catch (e) {
      print("Error getting location: $e");
      return null;
    }
  }

  Future<bool> _handlePermission() async {
    LocationPermission permission;

    // Check current permission
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      // Request it
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false; // user denied
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // User permanently denied (must go to Settings)
      return false;
    }

    // Permission granted
    return true;
  }

  Future<String> getAddressFromLatLng(double lat, double lng) async {
    try {
      if (kIsWeb) {
        final url =
            'https://nominatim.openstreetmap.org/reverse?format=json&lat=$lat&lon=$lng&zoom=18&addressdetails=1';
        final response = await http.get(Uri.parse(url));

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          final address = data['display_name'];
          return address ?? "No address found";
        } else {
          return "Error: Failed to fetch address (${response.statusCode})";
        }
      } else {
        List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
        if (placemarks.isNotEmpty) {
          final place = placemarks.first;
          return "${place.name}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
        } else {
          return "No address found";
        }
      }
    } catch (e) {
      return "Error: $e";
    }
  }
}
