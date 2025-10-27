import 'dart:io';
import 'dart:typed_data';

import 'package:flatten/app_constant.dart';
import 'package:flatten/controllers/dashboard/crm_dashboard_controller.dart';
import 'package:flatten/controllers/mycontroller/camera_controller.dart';
import 'package:flatten/helpers/theme/app_style.dart';
import 'package:flatten/helpers/utils/mixins/ui_mixin.dart';
import 'package:flatten/helpers/utils/my_shadow.dart';

import 'package:flatten/helpers/widgets/my_card.dart';
import 'package:flatten/helpers/widgets/my_container.dart';
import 'package:flatten/helpers/widgets/my_flex.dart';
import 'package:flatten/helpers/widgets/my_flex_item.dart';
import 'package:flatten/helpers/widgets/my_list_extension.dart';
import 'package:flatten/helpers/widgets/my_screen_media_type.dart';
import 'package:flatten/helpers/widgets/my_spacing.dart';
import 'package:flatten/helpers/widgets/my_text.dart';
import 'package:flatten/images.dart';
import 'package:flatten/models/attendance.dart';
import 'package:flatten/myPages/cam_screen.dart';
import 'package:flatten/responsive.dart';
import 'package:flatten/views/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:flatten/helpers/extensions/string.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'package:flatten/controllers/mycontroller/attendance_controller.dart';

class Attendance extends StatefulWidget {
  const Attendance({super.key});

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance>
    with SingleTickerProviderStateMixin, UIMixin {
  late AttendanceController controller;
  CameraControllerNew cameraControllerNew = Get.put(CameraControllerNew());

  @override
  void initState() {
    controller = Get.put(AttendanceController(this));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      floatingAction: GetBuilder(
        init: controller,
        builder: (controller) {
          return FloatingActionButton(
            backgroundColor: AppTheme.primaryColor,
            child: Text(
              controller.loginStatusCurrent,
              style: TextStyle(fontSize: 22),
            ),
            onPressed: () async {
              // Uint8List? compressedBytes;
              // String? fileUrl;
              // Map<String, dynamic>? value = await cameraControllerNew.openCam(
              //   isFront: true,
              // );
              //
              // if (value != null) {
              //   compressedBytes = value['compressedBytes'];
              //   fileUrl = value['file_name'];
              // }
              //
              // if (fileUrl != null && compressedBytes != null) {
              //   controller.saveLoginEntry(
              //     fileName: fileUrl,
              //     compressedBytes: compressedBytes,
              //   );
              // }

              File? value = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CameraPageNew()),
              );

              print(value);
            },
          );
        },
      ),
      scrollNeed: false,
      child: GetBuilder(
        init: controller,
        builder: (controller) {
          return Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            MyText.titleMedium(
                              "ATTENDANCE".tr(),
                              fontSize: 18,
                              fontWeight: 600,
                            ),
                            Spacer(),
                            IconButton(
                              onPressed: () async {
                                // if (controller.selectedYear != null &&
                                //     controller.selectedMonth != null ) {
                                //   Map<String, String> dateFilter = {};
                                //   dateFilter = controller.getMonthDateRange(int.parse(controller.selectedYear!), controller.selectedMonth!);
                                //   print("From: ${dateFilter['fromDate']}");
                                //   print("To: ${dateFilter['toDate']}");
                                //
                                //   controller.fetchLoginList(
                                //     company: "MVD FASTENERS PRIVATE LIMITED",
                                //     fromDate: dateFilter['fromDate'],
                                //     toDate: dateFilter['toDate'],
                                //     employeeId: "8122140852",
                                //   );
                                // }

                                // controller.calculatePresentDetails(
                                //   controller.employeeLoginList,
                                // );
                              },
                              icon: Icon(Icons.refresh),
                            ),
                            _popUpMenuBuilderForYearlySummary(controller),
                            MySpacing.width(flexSpacing),
                            _popUpMenuBuilderForMonthlySummary(controller),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            if (Responsive.isMobile(context))
                              Row(children: [..._presentAbsent()])
                            else
                              _responsiveTitleHead(),
                            MySpacing.height(flexSpacing),
                            if (Responsive.isMobile(context))
                              Row(children: [..._halfPermission()]),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: controller.employeeLoginList.isEmpty
                    ? Center(
                        child: Text(
                          "No Records Found",
                          style: TextStyle(fontSize: 20),
                        ),
                      )
                    : ListView.builder(
                        padding: MySpacing.xy(8, 0),
                        shrinkWrap: true,
                        itemCount: controller.employeeLoginList.length,
                        itemBuilder: (context, index) {
                          EmployeeLogin employeeDetails =
                              controller.employeeLoginList[index];

                          String inTime =
                              employeeDetails.inTime == null ||
                                  employeeDetails.inTime == ""
                              ? "No Time"
                              : _formatTime(employeeDetails.inTime!);

                          String outTime =
                              employeeDetails.outTime == null ||
                                  employeeDetails.outTime == ""
                              ? "No Time"
                              : _formatTime(employeeDetails.outTime!);

                          String workHrs =
                              employeeDetails.inTime != null &&
                                  employeeDetails.outTime != null
                              ? _calculateWorkHours(
                                  employeeDetails.inTime!,
                                  employeeDetails.outTime!,
                                )
                              : "0 hrs 0 min";

                          return InkWell(
                            onTap: () {
                              controller.updateEmployeeLogin(
                                controller.employeeLoginList[index],
                              );
                              Get.toNamed('/login_details');
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: stateCardDetail(
                                date: employeeDetails.inDate ?? "No Date",
                                location:
                                    employeeDetails.inLocation ?? "Not Found",
                                time: "IN: $inTime | OUT: $outTime",
                                workHours: workHrs,
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  List<Widget> _presentAbsent() {
    return [
      Expanded(
        child: buildTopSeller("Present", controller.presentDays.toString()),
      ),
      Expanded(
        child: buildTopSeller("Absent", controller.absentDays.toString()),
      ),
    ];
  }

  List<Widget> _halfPermission() {
    return [
      Expanded(
        child: buildTopSeller("Half Day", controller.halfDays.toString()),
      ),
      Expanded(
        child: buildTopSeller(
          "Permission",
          controller.permissionsDays.toString(),
        ),
      ),
    ];
  }

  Widget _responsiveTitleHead() {
    return Row(children: [..._presentAbsent(), ..._halfPermission()]);
  }

  Widget _popUpMenuBuilderForMonthlySummary(AttendanceController controller) {
    String currentMonthName = monthMap.keys.elementAt(DateTime.now().month - 1);
    controller.selectedMonth ??= currentMonthName;
    return PopupMenuButton<String>(
      onSelected: controller.onSelectMonth,
      itemBuilder: (BuildContext context) {
        return monthMap.keys.map((month) {
          return PopupMenuItem<String>(
            value: month,
            height: 32,
            child: MyText.bodySmall(
              month,
              color: Theme.of(context).colorScheme.onSurface,
              fontWeight: 600,
            ),
          );
        }).toList();
      },
      color: theme.cardTheme.color,
      child: MyContainer.bordered(
        padding: MySpacing.xy(12, 4),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            MyText.labelMedium(
              controller.selectedMonth ?? monthMap.keys.first,
              color: contentTheme.onBackground,
            ),
            MySpacing.width(4),
            Icon(
              LucideIcons.chevron_down,
              size: 20,
              color: contentTheme.onBackground,
            ),
          ],
        ),
      ),
    );
  }

  Widget _popUpMenuBuilderForYearlySummary(AttendanceController controller) {
    final currentYear = DateTime.now().year;
    final startYear = 2024;

    final List<String> yearList = [
      for (int y = startYear; y <= currentYear; y++) "$y",
    ];

    controller.selectedYear ??= currentYear.toString();

    return PopupMenuButton<String>(
      onSelected: controller.onSelectYear,
      itemBuilder: (BuildContext context) {
        return yearList.map((yrs) {
          return PopupMenuItem<String>(
            value: yrs,
            height: 32,
            child: MyText.bodySmall(
              yrs,
              color: Theme.of(context).colorScheme.onSurface,
              fontWeight: 600,
            ),
          );
        }).toList();
      },
      color: theme.cardTheme.color,
      child: MyContainer.bordered(
        padding: MySpacing.xy(12, 4),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            MyText.labelMedium(
              controller.selectedYear ?? yearList.first,
              color: contentTheme.onBackground,
            ),
            MySpacing.width(4),
            Icon(
              LucideIcons.chevron_down,
              size: 20,
              color: contentTheme.onBackground,
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(String inTime) {
    DateTime parsedTime = DateFormat("HH:mm:ss").parse(inTime);
    return DateFormat("hh.mm a").format(parsedTime);
  }

  String _calculateWorkHours(String startTime, String endTime) {
    Map<String, int> value = calculateWorkHours(startTime, endTime);

    int? hours = value['hours'];
    int? minutes = value['minutes'];

    return "${hours} hrs ${minutes} min";
  }

  Widget buildTopSeller(String title, String value) {
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
            child: Icon(
              Icons.date_range,
              size: 50,
              color: AppTheme.primaryColor,
            ),

            // Icon(Icons.absent, size: 70),
          ),
          MySpacing.width(16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText.bodyMedium(title, fontWeight: 700, fontSize: 16),
              MyText.bodyMedium(value, muted: true, fontSize: 16),
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
