import 'dart:convert';

import 'package:flatten/controllers/dashboard/crm_dashboard_controller.dart';
import 'package:flatten/helpers/theme/app_style.dart';
import 'package:flatten/helpers/utils/mixins/ui_mixin.dart';
import 'package:flatten/helpers/utils/my_shadow.dart';
import 'package:flatten/helpers/utils/utils.dart';
import 'package:flatten/controllers/mycontroller/attendance_controller.dart';
import 'package:flatten/helpers/widgets/my_breadcrumb.dart';
import 'package:flatten/helpers/widgets/my_breadcrumb_item.dart';
import 'package:flatten/helpers/widgets/my_card.dart';
import 'package:flatten/helpers/widgets/my_container.dart';
import 'package:flatten/helpers/widgets/my_flex.dart';
import 'package:flatten/helpers/widgets/my_flex_item.dart';
import 'package:flatten/helpers/widgets/my_list_extension.dart';
import 'package:flatten/helpers/widgets/my_spacing.dart';
import 'package:flatten/helpers/widgets/my_text.dart';
import 'package:flatten/images.dart';
import 'package:flatten/models/attendance.dart';
import 'package:flatten/views/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:flatten/helpers/extensions/string.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class CheckinDetails extends StatefulWidget {
  const CheckinDetails({super.key});

  @override
  State<CheckinDetails> createState() => _CheckinDetailsState();
}

class _CheckinDetailsState extends State<CheckinDetails>
    with SingleTickerProviderStateMixin, UIMixin {
  late AttendanceController controller;

  @override
  void initState() {
    controller = Get.put(AttendanceController(this));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      scrollNeed: false,
      child: GetBuilder(
        init: controller,
        builder: (controller) {
          return MyContainer.bordered(
            padding: MySpacing.x(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TabBar(
                  controller: controller.defaultTabController,
                  isScrollable: true,
                  tabs: [
                    Tab(
                      icon: MyText.bodyLarge(
                        "LOGIN",
                        fontWeight: controller.defaultIndex == 0 ? 600 : 500,
                        color: controller.defaultIndex == 0
                            ? contentTheme.primary
                            : null,
                      ),
                    ),
                    Tab(
                      icon: MyText.bodyLarge(
                        "LOGOUT",
                        fontWeight: controller.defaultIndex == 1 ? 600 : 500,
                        color: controller.defaultIndex == 1
                            ? contentTheme.primary
                            : null,
                      ),
                    ),
                  ],
                  // controller: _tabController,
                  indicatorSize: TabBarIndicatorSize.tab,
                ),
                MySpacing.height(8),
                Expanded(
                  child: TabBarView(
                    controller: controller.defaultTabController,
                    children: [
                      SingleChildScrollView(
                        child: MyFlex(
                          contentPadding: false,
                          children: [
                            MyFlexItem(
                              sizes: 'lg-10 md-5',
                              child: MyContainer(
                                child: Column(
                                  children: [
                                    buildEmployeeIndex(
                                      Icons.person,
                                      contentTheme.primary,
                                      controller.employeeLogin.employeeName
                                          .toString(),
                                      contentTheme.primary,
                                    ),
                                    Divider(height: 20),
                                    buildEmployeeIndex(
                                      Icons.date_range,
                                      contentTheme.primary,
                                      controller.employeeLogin.inDate
                                          .toString(),
                                      contentTheme.primary,
                                    ),
                                    Divider(height: 20),
                                    buildEmployeeIndex(
                                      LucideIcons.timer,
                                      contentTheme.primary,
                                      _formatTime(
                                        controller.employeeLogin.inTime
                                            .toString(),
                                      ),
                                      contentTheme.primary,
                                    ),
                                    Divider(height: 20),
                                    buildEmployeeIndex(
                                      isSmallText: true,
                                      Icons.location_on,
                                      contentTheme.primary,
                                      controller.employeeLogin.inLocation ??
                                          "No Location Found !",
                                      contentTheme.primary,
                                    ),
                                    Divider(height: 20),
                                    buildEmployeeIndex(
                                      isSmallText: true,
                                      Icons.edit,
                                      contentTheme.primary,
                                      controller.employeeLogin.remarks ??
                                          "No Remarks Found !",
                                      contentTheme.primary,
                                    ),
                                    Divider(height: 20),
                                  ],
                                ),
                              ),
                            ),
                            MyFlexItem(
                              child: MyContainer(
                                borderRadiusAll: 8,
                                paddingAll: 0,

                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: controller.inImage != null
                                    ? Image.memory(
                                        base64Decode(
                                          controller.inImage!.split(',')[1],
                                        ),
                                        fit: BoxFit.cover,
                                      )
                                    : Container(
                                        color: Colors.grey[200],
                                        child: Icon(Icons.person, size: 50),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: MySpacing.x(flexSpacing),
                        child: SingleChildScrollView(
                          child: MyFlex(
                            contentPadding: false,
                            children: [
                              MyFlexItem(
                                sizes: 'lg-10',
                                child: MyContainer(
                                  child: Column(
                                    children: [
                                      buildEmployeeIndex(
                                        Icons.person,
                                        contentTheme.primary,
                                        controller.employeeLogin.employeeName
                                            .toString(),
                                        contentTheme.primary,
                                      ),
                                      Divider(height: 20),
                                      buildEmployeeIndex(
                                        Icons.date_range,
                                        contentTheme.primary,
                                        controller.employeeLogin.outDate
                                            .toString(),
                                        contentTheme.primary,
                                      ),
                                      Divider(height: 20),
                                      Row(
                                        children: [
                                          buildEmployeeIndex(
                                            LucideIcons.timer,
                                            contentTheme.primary,
                                            _formatTime(
                                              controller.employeeLogin.outTime
                                                  .toString(),
                                            ),
                                            contentTheme.primary,
                                          ),
                                          Spacer(),
                                          buildEmployeeIndex(
                                            Icons.work,
                                            contentTheme.primary,
                                            _calculateWorkHours(
                                              controller.employeeLogin.inTime
                                                  .toString(),
                                              controller.employeeLogin.outTime
                                                  .toString(),
                                            ),
                                            contentTheme.primary,
                                          ),
                                        ],
                                      ),
                                      Divider(height: 20),
                                      buildEmployeeIndex(
                                        isSmallText: true,
                                        Icons.location_on,
                                        contentTheme.primary,
                                        controller.employeeLogin.outLocation ??
                                            "No Location Found !",
                                        contentTheme.primary,
                                      ),
                                      Divider(height: 20),
                                      buildEmployeeIndex(
                                        isSmallText: true,
                                        Icons.edit,
                                        contentTheme.primary,
                                        controller.employeeLogin.remarks ??
                                            "No Remarks Found !",
                                        contentTheme.primary,
                                      ),
                                      Divider(height: 20),
                                    ],
                                  ),
                                ),
                              ),
                              MyFlexItem(
                                child: MyContainer(
                                  borderRadiusAll: 8,
                                  paddingAll: 0,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: controller.outImage != null
                                      ? Image.memory(
                                          base64Decode(
                                            controller.outImage!.split(',')[1],
                                          ),
                                          fit: BoxFit.cover,
                                        )
                                      : Container(
                                          color: Colors.grey[200],
                                          child: Icon(Icons.person, size: 50),
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildEmployeeIndex(
    IconData icon,
    Color iconColor,
    String title,
    Color color, {
    bool isSmallText = false,
  }) {
    return Row(
      children: [
        MyContainer(
          height: 32,
          width: 32,
          paddingAll: 0,
          color: iconColor.withAlpha(36),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Icon(icon, size: 16, color: iconColor),
        ),
        MySpacing.width(12),
        isSmallText
            ? Expanded(
                child: TextField(
                  controller: TextEditingController(text: title ?? ''),
                  readOnly: true,
                  maxLines: 3,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true,
                  ),
                ),
              )
            : MyText.titleMedium(
                title,
                fontWeight: 600,
                overflow: TextOverflow.ellipsis,
              ),
      ],
    );
  }

  String _formatTime(String? inTime) {
    if (inTime == "null" || inTime == "" || inTime == null) {
      return "Not Yet";
    }
    DateTime parsedTime = DateFormat("HH:mm:ss").parse(inTime);
    return DateFormat("hh.mm a").format(parsedTime);
  }

  String _calculateWorkHours(String startTime, String endTime) {
    if (startTime == "null" ||
        startTime == "" ||
        startTime == null ||
        endTime == "null" ||
        endTime == "") {
      return "---";
    }

    DateTime start = DateFormat("HH:mm:ss").parse(startTime);
    DateTime end = DateFormat("HH:mm:ss").parse(endTime);

    Duration diff = end.difference(start);
    int hours = diff.inHours;
    int minutes = diff.inMinutes.remainder(60);

    return "${hours} hrs ${minutes} min";
  }

  Widget buildTopSeller(String avatar, String sellerName, String sellerPrice) {
    return MyCard(
      shadow: MyShadow(elevation: 1),
      paddingAll: 8,
      margin: MySpacing.right(5),
      borderRadiusAll: AppStyle.buttonRadius.medium,
      // width: 300,
      child: Row(
        children: [
          MyContainer.none(
            borderRadiusAll: AppStyle.buttonRadius.medium,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Icon(Icons.person, size: 70),
          ),
          MySpacing.width(16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText.bodyMedium(sellerName, fontWeight: 700, fontSize: 16),
              MyText.bodyMedium(sellerPrice, muted: true, fontSize: 16),
            ],
          ),
        ],
      ),
    );
  }

  Widget stateCardDetail({
    required String date,
    required String time,
    required String location,
    required String workHours,
  }) {
    return MyContainer(
      height: 150,
      paddingAll: 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MyText.titleMedium(date, fontWeight: 600),
          MyText.titleLarge(time, fontWeight: 700),
          Row(
            children: [
              Icon(Icons.location_on),
              MyText.bodyMedium(location, fontWeight: 600),
              Spacer(),
              MyContainer(
                paddingAll: 8,
                color: contentTheme.success.withAlpha(36),
                child: MyText.bodySmall(
                  workHours,
                  fontWeight: 700,
                  color: contentTheme.success,
                ),
              ),
            ],
          ),
        ],
      ),
    );
    //   MyFlexItem(
    //   sizes: 'lg-2 md-4 sm-4',
    //   child:
    // );
  }
}
