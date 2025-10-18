import 'package:flatten/controllers/other/leaflet_controller.dart';
import 'package:flatten/helpers/theme/app_style.dart';
import 'package:flatten/helpers/utils/mixins/ui_mixin.dart';
import 'package:flatten/helpers/widgets/my_breadcrumb.dart';
import 'package:flatten/helpers/widgets/my_breadcrumb_item.dart';
import 'package:flatten/helpers/widgets/my_button.dart';
import 'package:flatten/helpers/widgets/my_container.dart';
import 'package:flatten/helpers/widgets/my_spacing.dart';
import 'package:flatten/helpers/widgets/my_text.dart';
import 'package:flatten/views/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class LeafletPage extends StatefulWidget {
  const LeafletPage({super.key});

  @override
  State<LeafletPage> createState() => _LeafletPageState();
}

class _LeafletPageState extends State<LeafletPage>
    with SingleTickerProviderStateMixin, UIMixin {
  late LeafletController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(LeafletController());
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        builder: (controller) {
          return Column(
            children: [
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText.titleMedium(
                      "Leaflet",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'Maps'),
                        MyBreadcrumbItem(name: 'Leaflet', active: true),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Column(
                  children: [
                    MyContainer.none(
                      borderRadiusAll: 4,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      height: 600,
                      child: FlutterMap(
                        mapController: controller.mapController,
                        options: controller.getMapOption(),
                        // nonRotatedChildren: [
                        //   RichAttributionWidget(
                        //     showFlutterMapAttribution: true,
                        //     attributions: [
                        //       TextSourceAttribution(
                        //         'OpenStreetMap contributors',
                        //         onTap: () => launchUrl(Uri.parse(
                        //             'https://openstreetmap.org/copyright')),
                        //       ),
                        //     ],
                        //   ),
                        // ],
                        children: [
                          TileLayer(
                            urlTemplate:
                                'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                            userAgentPackageName: 'com.example.app',
                          ),
                          CircleLayer(
                            circles: controller.isCircleShowing
                                ? controller.getCircleMarkers()
                                : controller.getCircleMarkers(),
                          ),
                          PolylineLayer(
                            polylines: controller.isLineShowing
                                ? controller.getPolyLines()
                                : controller.getPolyLines(),
                          ),
                          MarkerLayer(
                            markers: controller.isImageShowing
                                ? controller.getMarkerLayers()
                                : [],
                          ),
                        ],
                      ),
                    ),
                    MySpacing.height(flexSpacing),
                    Row(
                      children: [
                        MyButton(
                          onPressed: () {
                            controller.onChangeCircleShowing();
                          },
                          elevation: 0,
                          padding: MySpacing.xy(20, 16),
                          backgroundColor: contentTheme.primary,
                          borderRadiusAll: AppStyle.buttonRadius.medium,
                          child: MyText.bodyMedium(
                            !controller.isCircleShowing
                                ? "Circle Show"
                                : "Circle Hide",
                            color: contentTheme.onPrimary,
                          ),
                        ),
                        MySpacing.width(16),
                        MyButton(
                            onPressed: () {
                              controller.onChangeLineShowing();
                            },
                            elevation: 0,
                            padding: MySpacing.xy(20, 16),
                            backgroundColor: contentTheme.primary,
                            borderRadiusAll: AppStyle.buttonRadius.medium,
                            child: MyText.bodyMedium(
                              !controller.isLineShowing
                                  ? "Line Show"
                                  : "Line Hide",
                              color: contentTheme.onPrimary,
                            )),
                        MySpacing.width(16),
                        MyButton(
                          onPressed: () {
                            controller.onChangeImageShowing();
                          },
                          elevation: 0,
                          padding: MySpacing.xy(20, 16),
                          backgroundColor: contentTheme.primary,
                          borderRadiusAll: AppStyle.buttonRadius.medium,
                          child: Visibility(
                            child: MyText.bodyMedium(
                              !controller.isImageShowing
                                  ? "Image Show"
                                  : "Image Hide",
                              color: contentTheme.onPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
