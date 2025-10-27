import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flatten/controllers/auth/login_controller.dart';
import 'package:flatten/helpers/services/auth_service.dart';
import 'package:flatten/models/trip_list.dart';
import 'package:flatten/myPages/locaiton_service.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flatten/app_constant.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http_parser/http_parser.dart';

class TripImagesController extends GetxController {
  Trip currentTrip = Trip();
  RoutePoint routeTrip = RoutePoint();
  List<TripImage> tripImageList = [];

  double? latitude;
  double? longitude;
  String address = "----";

  void updateCurrentTrip(Trip? trip) {
    currentTrip = trip ?? Trip();
    update();
  }

  void updateCurrentRoute(RoutePoint? route) {
    routeTrip = route ?? RoutePoint();
    update();
  }

  Future<void> updateLocation() async {
    Position? position = await LocationService().getCurrentPosition();
    if (position != null) {
      latitude = position.latitude;
      longitude = position.longitude;
      double lat = position.latitude;
      double long = position.longitude;
      print(lat + long);
      address = await LocationService().getAddressFromLatLng(lat, long);
      update();
    }
  }

  // Future<String?> uploadImage({
  //   required String parentDocType,
  //   required String parentDocName,
  //   required String fieldName,
  //   required Uint8List imageBytes,
  //   required String fileName,
  // }) async {
  //   if (AuthService.sessionId == null) {
  //     print("❌ Session ID not found. Cannot proceed with upload.");
  //     return null;
  //   }
  //   try {
  //     final uploadUri = Uri.parse('$backendUrl/upload_file');
  //     var request = http.MultipartRequest('POST', uploadUri);
  //     request.headers.addAll({'Cookie': AuthService.sessionId!});
  //
  //     request.files.add(
  //       http.MultipartFile.fromBytes(
  //         'file',
  //         imageBytes,
  //         filename: fileName, // Use the proper filename
  //       ),
  //     );
  //
  //     request.fields['doctype'] = parentDocType;
  //     request.fields['docname'] = parentDocName;
  //     request.fields['file_field_name'] = fieldName;
  //     request.fields['is_private'] = '0'; // Public file
  //     request.fields['folder'] = 'Home';
  //
  //     final streamedResponse = await request.send();
  //     final response = await http.Response.fromStream(streamedResponse);
  //
  //     if (response.statusCode == 200) {
  //       final data = jsonDecode(response.body);
  //       final fileDoc = data['message'];
  //
  //       final fileUrl = fileDoc['file_url'] as String?;
  //
  //       if (fileUrl != null && routeTrip.id != null) {
  //         bool value = await saveTripImages(
  //           parentId: parentDocName,
  //           childId: routeTrip.id!,
  //           imagePath: fileUrl,
  //         );
  //         if (value) {
  //           await fetchTripImages(childId: routeTrip.id!);
  //         }
  //       }
  //
  //       print("✅ File Upload Success. ERPNext File URL: $fileUrl");
  //       return fileUrl;
  //     } else {
  //       print("❌ Upload failed with status ${response.statusCode}");
  //       print("Response Body: ${response.body}");
  //       return null;
  //     }
  //   } catch (e) {
  //     print("⚠️ An unexpected error occurred during upload: $e");
  //     return null;
  //   }
  // }

  Future<void> fetchTripImages({String? childId}) async {
    if (AuthService.sessionId == null) {
      print("❌ No session found. Please login first.");
      return;
    }
    final url = Uri.parse("$backendUrl/get_trip_images");
    final body = {
      'cookie': AuthService.sessionId,
      'parent_id': currentTrip.name,
      'child_id': childId,
    };

    try {
      final response = await http.post(
        url,
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        tripImageList = [];
        final data = jsonDecode(response.body);
        print("data $data");
        final tripsJson = data['message'] as List<dynamic>? ?? [];
        tripImageList.addAll(
          tripsJson.map((e) => TripImage.fromJson(e)).toList(),
        );
        print(
          "Travel Images length = ${tripImageList.length} , ${tripImageList}",
        );
      } else {
        print("❌ Error ${response.statusCode}: ${response.body}");
      }
    } catch (e) {
      print("⚠️ Error: ${e.toString()}");
    }
    update();
  }

  Future<bool> saveTripImages({
    required String parentId,
    required String childId,
    String? description,
    required String imagePath,
  }) async {
    TripImage tripImage = TripImage();

    tripImage = TripImage(
      parentId: parentId,
      // "sjh4bv2ee1",
      childId: childId,
      // "v2jfhsmbaj",
      description: description,
      // "naosdna",
      image: imagePath,
      // "/files/1000047124.jpg",
      id: null,
      // "43cqae8l89",
    );

    final url = Uri.parse("$backendUrl/save_trip_image");
    final Map<String, dynamic> body = {
      'cookie': AuthService.sessionId,
      'data': tripImage.toJson(),
    };

    try {
      final response = await http.post(
        url,
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['message']['name'] != null) {
          return true;
        } else {
          return false;
        }
      }
    } catch (e) {
      print("⚠️ Error: ${e.toString()}");
      return false;
    }
    return false;
  }
}
