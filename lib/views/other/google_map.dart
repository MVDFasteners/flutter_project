import 'package:flatten/controllers/other/google_map_controller.dart';
import 'package:flatten/helpers/extensions/string.dart';
import 'package:flatten/helpers/theme/app_style.dart';
import 'package:flatten/helpers/utils/mixins/ui_mixin.dart';
import 'package:flatten/helpers/widgets/my_breadcrumb.dart';
import 'package:flatten/helpers/widgets/my_breadcrumb_item.dart';
import 'package:flatten/helpers/widgets/my_container.dart';
import 'package:flatten/helpers/widgets/my_spacing.dart';
import 'package:flatten/helpers/widgets/my_text.dart';
import 'package:flatten/views/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapPage extends StatefulWidget {
  const GoogleMapPage({super.key});

  @override
  _GoogleMapPageState createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage>
    with SingleTickerProviderStateMixin, UIMixin {
  late GoogleMapPageController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(GoogleMapPageController());
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
        child: GetBuilder<GoogleMapPageController>(
            init: controller,
            builder: (controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: MySpacing.x(flexSpacing),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyText.titleMedium(
                          "google_map".tr().capitalizeWords,
                          fontSize: 18,
                          fontWeight: 600,
                        ),
                        MyBreadcrumb(
                          children: [
                            MyBreadcrumbItem(name: 'Maps'.tr()),
                            MyBreadcrumbItem(
                                name: 'Google Map'.tr(), active: true),
                          ],
                        ),
                      ],
                    ),
                  ),
                  MySpacing.height(flexSpacing),
                  Padding(
                      padding: MySpacing.x(flexSpacing),
                      child: MyContainer.none(
                        borderRadiusAll: 4,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        height: 600,
                        child: GoogleMap(
                          onMapCreated: controller.onGoogleMapCreated,
                          mapType: MapType.hybrid,
                          initialCameraPosition: CameraPosition(
                            target:
                                LatLng(37.42796133580664, -122.085749655962),
                            zoom: 14.4746,
                          ),
                        ),
                      )),
                  MySpacing.height(flexSpacing),
                  Padding(
                      padding: MySpacing.x(flexSpacing),
                      child: MyContainer.none(
                        borderRadiusAll: 4,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                      )),
                ],
              );
            }));
  }
}
