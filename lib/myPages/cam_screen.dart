import 'dart:io';
import 'dart:typed_data';

import 'package:flatten/app_constant.dart';
import 'package:flatten/helpers/theme/app_style.dart';
import 'package:flatten/helpers/utils/mixins/ui_mixin.dart';
import 'package:flatten/models/attendance.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:flatten/controllers/mycontroller/attendance_controller.dart';

class CameraPageNew extends StatefulWidget {
  const CameraPageNew({super.key});

  @override
  State<CameraPageNew> createState() => _CameraPageNewState();
}

class _CameraPageNewState extends State<CameraPageNew>
    with SingleTickerProviderStateMixin, UIMixin {
  CameraController? _camController; // ✅ make nullable
  late AttendanceController attendanceController;

  bool _isCameraInitialized = false;
  bool _isloading = false;

  @override
  void initState() {
    super.initState();
    attendanceController = Get.put(AttendanceController(this));
    _initializeCamera();
  }

  @override
  void dispose() {
    _camController?.dispose(); // ✅ dispose only if not null
    super.dispose();
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        print("❌ No cameras available on this device (simulator).");
        return;
      }

      final frontCamera = cameras.firstWhere(
        (cam) => cam.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first,
      );

      _camController = CameraController(
        frontCamera,
        ResolutionPreset.low,
        enableAudio: false,
      );
      await _camController!.initialize();
      if (mounted) {
        setState(() => _isCameraInitialized = true);
      }
    } catch (e) {
      print("Camera Error: $e");
    }
  }

  Future<Map<String, dynamic>?> _capturePhoto(BuildContext context) async {
    if (!(_camController?.value.isInitialized ?? false)) {
      toastMessage(message: "Camera is not initialized");
      setState(() => _isloading = false);
      return null;
    }

    try {
      final XFile imageFile = await _camController!.takePicture();
      File capturedImage = File(imageFile.path);

      final String fileName = capturedImage.path.split('/').last;
      print("Captured File Name: $fileName");

      final compressedBytes = await FlutterImageCompress.compressWithFile(
        capturedImage.absolute.path,
        minWidth: 800,
        minHeight: 800,
        quality: 50,
      );

      return {'fileName': fileName, 'compressedBytes': compressedBytes};
    } catch (e) {
      setState(() => _isloading = false);
      print("Error capturing image: $e");
      toastMessage(message: "Error capturing image");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        title: const Text("Face Verification"),
      ),
      body: Stack(
        children: [
          if (_isCameraInitialized && _camController != null)
            Positioned.fill(
              child: Transform.scale(
                scaleX: -1,
                child: CameraPreview(_camController!),
              ),
            )
          else
            const Center(
              child: Text(
                "Camera not available",
                style: TextStyle(color: Colors.white),
              ),
            ),
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Center(
              child: _isloading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : FloatingActionButton(
                      backgroundColor: AppTheme.primaryColor,
                      onPressed: () async {
                        setState(() => _isloading = true);
                        bool? created;

                        final value = await _capturePhoto(context);
                        showCustomToast("Photo Captured Success...", context);
                        if (value != null) {
                          created = await attendanceController
                              .saveLoginEntryDirect(
                                fileName: value['fileName'],
                                compressedBytes: value['compressedBytes'],
                                context: context,
                              );
                        }

                        setState(() => _isloading = false);
                        Navigator.pop(context, created);
                      },
                      child: const Icon(Icons.camera),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
