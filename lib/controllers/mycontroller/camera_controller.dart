import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flatten/app_constant.dart';
import 'package:flatten/controllers/auth/login_controller.dart';
import 'package:flatten/controllers/my_controller.dart';
import 'package:flatten/controllers/other/syncfusion_charts_controller.dart';
import 'package:flatten/helpers/extensions/extensions.dart';
import 'package:flatten/helpers/services/auth_service.dart';
import 'package:flatten/helpers/theme/app_style.dart';
import 'package:flatten/images.dart';
import 'package:flatten/models/attendance.dart';
import 'package:flatten/models/customer.dart';
import 'package:flatten/models/product.dart';
import 'package:flatten/models/sales_team_summary.dart';
import 'package:flatten/models/sales_yearly_summary.dart';
import 'package:flatten/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CameraControllerNew extends MyController {
  Future<Map<String, dynamic>?> openCam({bool isFront = false}) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.front,
      // isFront ?
      //     : CameraDevice.rear,
    );

    String? fileName = pickedFile?.name;
    Map<String, dynamic> values = {};

    if (pickedFile != null && fileName != null) {
      final File originalFile = File(pickedFile.path);

      final compressedBytes = await FlutterImageCompress.compressWithFile(
        originalFile.absolute.path,
        minWidth: 800,
        minHeight: 800,
        quality: 50,
      );
      values['compressedBytes'] = compressedBytes;
      values['file_name'] = fileName;

      return values;
    }
  }

  Future<String?> uploadImageBytesToERPNext({
    required Uint8List compressedBytes,
    required String fileName,
    required String doctype,
    required String docname,
    required String fileFieldName,
    bool isPrivate = false,
    String folder = 'Home',
  }) async {
    try {
      // final getDocUrl = Uri.parse("$backendUrl/api/resource/$doctype/$docname");
      //
      // final getResponse = await http.get(
      //   getDocUrl,
      //   headers: {
      //     'Cookie': AuthService.sessionId!, // Session cookie for ERPNext
      //   },
      // );
      //
      // if (getResponse.statusCode == 200) {
      //   final docData = jsonDecode(getResponse.body);
      //   final existingImage = docData['data'][fileFieldName];
      //
      //   if (existingImage != null && existingImage.toString().isNotEmpty) {
      //     print("✅ Existing image found: $existingImage (Skipping upload)");
      //     return existingImage;
      //   }
      // } else {
      //   print("⚠️ Failed to fetch document: ${getResponse.statusCode}");
      // }

      final uploadUrl = Uri.parse("$baseUrl/api/method/upload_file");

      final request = http.MultipartRequest('POST', uploadUrl)
        ..headers['Cookie'] = AuthService.sessionId!
        ..fields['doctype'] = doctype
        ..fields['docname'] = docname
        ..fields['file_url_field'] = fileFieldName
        ..fields['is_private'] = isPrivate ? '1' : '0'
        ..fields['folder'] = folder
        ..files.add(
          http.MultipartFile.fromBytes(
            'file',
            compressedBytes,
            filename: fileName,
          ),
        );

      final response = await request.send();

      if (response.statusCode == 200) {
        final respStr = await response.stream.bytesToString();
        final data = jsonDecode(respStr);
        final uploadedUrl = data['message']['file_url'];
        print("✅ File uploaded successfully: $uploadedUrl");
        return uploadedUrl;
      } else {
        print("❌ Upload failed: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("❌ Exception during upload: $e");
      return null;
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
}
