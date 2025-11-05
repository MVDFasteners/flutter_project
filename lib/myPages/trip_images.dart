import 'dart:io';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flatten/app_constant.dart';
import 'package:flatten/controllers/mycontroller/attendance_controller.dart';
import 'package:flatten/controllers/mycontroller/camera_controller.dart';
import 'package:flatten/controllers/mycontroller/trip_images_controller.dart';
import 'package:flatten/views/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class TripImages extends StatelessWidget {
  const TripImages({super.key});

  @override
  Widget build(BuildContext context) {
    CameraControllerNew cameraControllerNew = Get.put(CameraControllerNew());
    return Layout(
      leadingWidget: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back),
      ),
      floatingAction: GetBuilder<TripImagesController>(
        builder: (controller) {
          return FloatingActionButton(
            onPressed: () async {
              Uint8List? compressedBytes;
              String? fileName;
              Map<String, dynamic>? value = await cameraControllerNew.openCam();
              if (value != null) {
                compressedBytes = value['compressedBytes'];
                fileName = value['file_name'];
              }

              if (fileName != null && compressedBytes != null) {
                final uploadedUrl = await cameraControllerNew
                    .uploadImageBytesToERPNext(
                      compressedBytes: compressedBytes,
                      fileName: fileName,
                      doctype: "Employee Trip",
                      docname: controller.currentTrip.name!,
                      fileFieldName: "image",
                    );

                if (uploadedUrl != null &&
                    controller.routeTrip.id != null &&
                    controller.currentTrip.name != null) {
                  bool value = await TripImagesController.saveTripImages(
                    parentId: controller.currentTrip.name!,
                    childId: controller.routeTrip.id!,
                    imagePath: uploadedUrl,
                  );
                  if (value) {
                    await controller.fetchTripImages(
                      childId: controller.routeTrip.id!,
                    );
                  }
                }
                print("Uploaded image URL: $uploadedUrl");
              } else {
                toastMessage(message: "Photo Not Captured");
              }
            },
            child: Icon(Icons.upload),
          );
        },
      ),
      scrollNeed: false,
      child: GetBuilder<TripImagesController>(
        builder: (controller) {
          return controller.tripImageList.isEmpty
              ? Center(
                  child: Text(
                    "Upload Images Here",
                    style: TextStyle(fontSize: 30),
                  ),
                )
              : GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // 2 images per row (good for phone)
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 1, // square tiles
                  ),
                  itemCount: controller.tripImageList.length,
                  itemBuilder: (context, index) {
                    final imgPath = controller.tripImageList[index].image;
                    final fullUrl = (imgPath != null && imgPath.isNotEmpty)
                        ? '$baseUrl$imgPath'
                        : null;

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey[300], // fallback background
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: fullUrl != null
                            ? Image.network(
                                fullUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(
                                      Icons.broken_image,
                                      size: 50,
                                      color: Colors.grey,
                                    ),
                              )
                            : const Icon(
                                Icons.image_not_supported,
                                size: 50,
                                color: Colors.grey,
                              ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
