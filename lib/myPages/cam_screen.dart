import 'dart:io';
import 'package:flatten/app_constant.dart';
import 'package:flatten/helpers/theme/app_style.dart';
import 'package:flatten/helpers/utils/mixins/ui_mixin.dart';
import 'package:flatten/models/attendance.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
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
  late CameraController _camController;
  late AttendanceController _attendanceCtrl;

  bool _isCameraInitialized = false;
  bool _isloading = false;

  @override
  void initState() {
    super.initState();
    _attendanceCtrl = Get.put(AttendanceController(this));
    _initializeCamera();
  }

  @override
  void dispose() {
    _camController.dispose();
    super.dispose();
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      final frontCamera = cameras.firstWhere(
        (cam) => cam.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first,
      );

      _camController = CameraController(
        frontCamera,
        ResolutionPreset.low,
        enableAudio: false,
      );
      await _camController.initialize();
      if (mounted) {
        setState(() => _isCameraInitialized = true);
      }
    } catch (e) {
      print("Camera Error: $e");
    }
  }

  Future<File?> _capturePhoto(BuildContext context) async {
    if (!_camController.value.isInitialized) {
      toastMessage(message: "Camera is not initialized");
      setState(() => _isloading = false);
      return null;
    }
    try {
      final XFile imageFile = await _camController.takePicture();
      File capturedImage = File(imageFile.path);
      toastMessage(
        message: "Photo captured successfully. Please wait, verifying...",
      );
      return capturedImage;
    } catch (e) {
      setState(() => _isloading = false);
      print("Error capturing image: $e");
      toastMessage(message: "Error capturing image");
      return null;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        title: Text("Face Verification"),
      ),
      body: Stack(
        children: [
          if (_isCameraInitialized)
            Positioned.fill(
              child: Transform.scale(
                scaleX: -1, // Flip horizontally for front camera
                child: CameraPreview(_camController),
              ),
            ),
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Center(
              child: _isloading
                  ? CircularProgressIndicator(color: Colors.white)
                  : FloatingActionButton(
                      backgroundColor: AppTheme.primaryColor,
                      onPressed: () async {
                        setState(() => _isloading = true);
                        File? value = await _capturePhoto(context);
                        if (value != null) {
                          await _attendanceCtrl.saveLoginEntry(value: value);
                          setState(() => _isloading = false);
                          Navigator.pop(context, value);
                        } else {
                          Navigator.pop(context, value);
                        }
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
