import 'dart:convert';
import 'package:flatten/controllers/mycontroller/hr_report_controller.dart';
import 'package:flatten/helpers/theme/app_style.dart';
import 'package:flatten/helpers/utils/mixins/ui_mixin.dart';
import 'package:flatten/helpers/utils/my_shadow.dart';
import 'package:flatten/helpers/widgets/my_card.dart';
import 'package:flatten/helpers/widgets/my_container.dart';
import 'package:flatten/helpers/widgets/my_list_extension.dart';
import 'package:flatten/helpers/widgets/my_spacing.dart';
import 'package:flatten/helpers/widgets/my_text.dart';
import 'package:flatten/models/attendance.dart';
import 'package:flatten/models/monthly%20attendance%20model.dart';
import 'package:flatten/myPages/reports/pdf_formate.dart';
import 'package:flatten/views/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get/get.dart';
import 'package:flatten/app_constant.dart';

class MonthlyLoginDetails extends StatefulWidget {
  const MonthlyLoginDetails({super.key});

  @override
  State<MonthlyLoginDetails> createState() => _MonthlyLoginDetailsState();
}

class _MonthlyLoginDetailsState extends State<MonthlyLoginDetails>
    with UIMixin {
  HRReportController controller = Get.put(HRReportController());

  @override
  void initState() {
    super.initState();
    _initialFetch();
  }

  void _initialFetch() async {
    await controller.fetchCompanyList();
    await controller.fetchLoginListMonthly(
      company: controller.currentCompany,
      fromDate: "2025-11-06",
      toDate: "2025-11-06",
    );
    await controller.onSelectStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        tag: 'monthly_log_report',
        builder: (controller) {
          return projectSummary(controller);
        },
      ),
    );
  }

  Widget projectSummary(HRReportController controller) {
    return MyCard.bordered(
      borderRadiusAll: 4,
      border: Border.all(color: Colors.grey.withValues(alpha: .2)),
      shadow: MyShadow(elevation: 1, position: MyShadowPosition.bottom),
      paddingAll: 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _popUpMenuBuilderForYearlySummary(controller),
              const SizedBox(width: 4),
              _popUpMenuBuilderForMonthlySummary(controller),
              const SizedBox(width: 8),
              Expanded(
                child: SizedBox(
                  height: 60,
                  child: TextFormField(
                    controller: controller.employeeNameMonthCtrl,
                    onChanged: (value) async {
                      await Future.delayed(
                        const Duration(milliseconds: 500),
                            () async {
                          await controller.onEmployeeNameTypeForMonthReport(
                            value,
                          );
                        },
                      );
                    },
                    decoration: InputDecoration(
                      labelText: "Employee Name",
                      prefixIcon: const Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 8),
              Expanded(
                child: SizedBox(
                  height: 60,
                  child: DropdownButtonFormField<String>(
                    value: controller.currentCompany,
                    dropdownColor: Colors.white,
                    decoration: InputDecoration(
                      labelText: "Company",
                      prefixIcon: const Icon(Icons.apartment),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                    items: controller.companyList
                        .map(
                          (item) =>
                          DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(fontSize: 15),
                            ),
                          ),
                    )
                        .toList(),
                    onChanged: (value) async {
                      if (value != null) {
                        await controller.onCompanySelectForMonthReport(value);
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  controller.employeeLogMonthly.isEmpty
                      ? "0"
                      : controller.employeeLogMonthly.length.toString(),
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          MySpacing.height(24),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              sortAscending: true,
              columnSpacing: 10,
              onSelectAll: (_) => {},
              headingRowColor: WidgetStatePropertyAll(
                contentTheme.primary.withAlpha(40),
              ),
              dataRowMaxHeight: 100,
              showBottomBorder: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              border: TableBorder.all(
                borderRadius: BorderRadius.circular(4),
                style: BorderStyle.solid,
                width: .4,
                color: Colors.grey,
              ),

              columns: [..._daysColumn(controller)],
              rows: controller.employeeLogMonthly.map((employee) {
                List<DataCell> cells = [];
                cells.add(
                  DataCell(
                    onTap: () async {
                      Map<String, int>? presentStatus = controller
                          .calculatePresentDetails(employee);

                      if (presentStatus != null) {
                        await showLogInformation(presentStatus, employee);
                      }
                    },
                    Text(
                      employee.employeeName ?? '',
                      style: TextStyle(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
                int year = int.parse(controller.selectedYear ?? "2025");
                int? month = monthMap[controller.selectedMonth ?? "Jan"];
                int endDate = getDaysInMonth(year, month!);
                for (int day = 1; day <= endDate; day++) {
                  String currentDate =
                      "$year-${month.toString().padLeft(2, '0')}-${day
                      .toString().padLeft(2, '0')}";
                  var log = employee.logList.firstWhere(
                        (log) => log.inDate == currentDate,
                    orElse: () => ReportEmployeesLoginListMonthly(),
                  );

                  String workHrs = "0 Hrs 0 Min";
                  if (log.inTime != null && log.outTime != null) {
                    Map<String, int> value = calculateWorkHours(
                      log.inTime!,
                      log.outTime!,
                    );
                    String hours = (value['hours'] ?? 0).toString();
                    String minutes = (value['minutes'] ?? 0).toString();
                    workHrs = "$hours Hrs $minutes Min";
                  }

                  cells.add(
                    DataCell(
                      onTap: () async {
                        controller.inImage = null;
                        controller.outImage = null;
                        if (log.inPhoto != null && log.inPhoto != '') {
                          await controller.fetchImageBase64(
                            log.inPhoto!,
                            inPhoto: true,
                          );
                        }
                        if (log.outPhoto != null && log.outPhoto != '') {
                          await controller.fetchImageBase64(
                            log.outPhoto!,
                            inPhoto: false,
                          );
                        }

                        ReportEmployeesLoginList employeeLog =
                        ReportEmployeesLoginList();
                        employeeLog.inTime = log.inTime;
                        employeeLog.outTime = log.outTime;
                        employeeLog.outDate = log.outDate ?? currentDate;
                        employeeLog.inLocation = log.inLocation;
                        employeeLog.outLocation = log.outLocation;
                        employeeLog.inDate = log.inDate ?? currentDate;
                        employeeLog.loginId = log.loginId;
                        employeeLog.remarks = log.remarks;
                        employeeLog.inPhoto = log.inPhoto;
                        employeeLog.outPhoto = log.outPhoto;
                        employeeLog.employee = employee.employeeId;
                        employeeLog.employeeName = employee.employeeName;
                        employeeLog.company = employee.company;

                        await controller.showEditLoginDialog(
                          context,
                          employeeLog,
                          contentTheme.primary,
                          true,
                          currentDate,
                        );
                      },
                      SizedBox(
                        height: 400,
                        width: 200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "IN :",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "OUT :",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "Work Hrs :",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      log.inTime == null || log.inTime == ""
                                          ? "---"
                                          : "${timeStringToStringWithAmPM(
                                          railwayTime: log.inTime!)}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                      ),
                                    ),
                                    Text(
                                      log.outTime == null || log.outTime == ""
                                          ? "---"
                                          : "${timeStringToStringWithAmPM(
                                          railwayTime: log.outTime!)}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                      ),
                                    ),
                                    Text(
                                      workHrs,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            // SizedBox(height: 4),

                            // SizedBox(height: 4),
                            // Text("Work Hrs : ")
                          ],
                        ),
                      ),
                      // Column(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Text(
                      //       log.inTime != null && log.inTime!.isNotEmpty
                      //           ? "In: ${log.inTime}"
                      //           : "-",
                      //       style: TextStyle(fontSize: 12),
                      //     ),
                      //     Text(
                      //       log.outTime != null && log.outTime!.isNotEmpty
                      //           ? "Out: ${log.outTime}"
                      //           : "-",
                      //       style: TextStyle(fontSize: 12),
                      //     ),
                      //   ],
                      // ),
                    ),
                  );
                }
                return DataRow(cells: cells);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  int getDaysInMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }

  List<DataColumn> _daysColumn(HRReportController controller) {
    int year = int.parse(controller.selectedYear ?? "2025");
    int? month = monthMap[controller.selectedMonth ?? "Jan"];
    List<DataColumn> list = [];
    if (month == null) {
      print("⚠️ Invalid month: ${controller.selectedMonth}");
      return list;
    }
    int endDate = getDaysInMonth(year, month);
    list.add(
      DataColumn(
        label: MyText.labelLarge('Employee', color: contentTheme.primary),
      ),
    );
    for (int i = 1; i <= endDate; i++) {
      list.add(
        DataColumn(
          label: MyText.labelLarge('Day $i', color: contentTheme.primary),
        ),
      );
    }

    return list;
  }

  Widget _popUpMenuBuilderForYearlySummary(HRReportController controller) {
    final currentYear = DateTime
        .now()
        .year;
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
              color: Theme
                  .of(context)
                  .colorScheme
                  .onSurface,
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

  Widget _popUpMenuBuilderForMonthlySummary(HRReportController controller) {
    String currentMonthName = monthMap.keys.elementAt(DateTime
        .now()
        .month - 1);
    controller.selectedMonth ??= currentMonthName;
    return PopupMenuButton<String>(
      onSelected: controller.onSelectMonth,
      itemBuilder: (BuildContext context) {
        return monthMap.keys.map((month) {
          return PopupMenuItem<String>(
            value: month,
            height: 36,
            child: MyText.bodySmall(
              month,
              color: Theme
                  .of(context)
                  .colorScheme
                  .onSurface,
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

  Future<void> showLogInformation(Map<String, int> status,
      EmployeeAttendance employee,) async {
    int presentDays = status['presentDays'] ?? 0;
    int absentDays = status['absentDays'] ?? 0;
    int halfDays = status['halfDays'] ?? 0;
    int permissionsDays = status['permissionsDays'] ?? 0;
    String name = employee.employeeName ?? "---";
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: const Text("Status"),
          content: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: SizedBox(
              height: 150,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("$name"),
                      SizedBox(height: 8),
                      Text(
                        "Present Days : ",
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        "Absent Days : ",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        "Half Days : ",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        "Permissions Days : ",
                        style: TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        presentDays.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        absentDays.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        halfDays.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        permissionsDays.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute<void>(
                //     builder: (context) =>
                //         AttendancePdfFormat(monthlyLogList: employee.logList),
                //   ),
                // );
              },
              child: Text("PDF Records"),
            ),
          ],
        );
      },
    );
  }
}
