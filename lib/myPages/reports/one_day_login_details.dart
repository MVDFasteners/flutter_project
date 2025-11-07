import 'dart:convert';

import 'package:flatten/controllers/dashboard/project_controller.dart';
import 'package:flatten/controllers/mycontroller/hr_report_controller.dart';
import 'package:flatten/helpers/theme/app_style.dart';
import 'package:flatten/helpers/utils/mixins/ui_mixin.dart';
import 'package:flatten/helpers/utils/my_shadow.dart';
import 'package:flatten/helpers/utils/utils.dart';
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
import 'package:flatten/models/chart_model.dart';
import 'package:flatten/models/task_list_model.dart';
import 'package:flatten/views/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flatten/app_constant.dart';

class PerDayLogin extends StatefulWidget {
  const PerDayLogin({super.key});

  @override
  State<PerDayLogin> createState() => _PerDayLoginState();
}

class _PerDayLoginState extends State<PerDayLogin> with UIMixin {
  HRReportController controller = Get.put(HRReportController());

  @override
  void initState() {
    super.initState();
    _initialFetch();
  }

  void _initialFetch() async {
    await controller.fetchCompanyList();

    await controller.fetchLoginListOneDay(
      company: controller.currentCompany,
      fromDate: controller.dateController.value.text,
      toDate: controller.dateController.value.text,
    );
    await controller.onSelectStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        tag: 'hr_report',
        builder: (controller) {
          return hrReport(controller);
        },
      ),
    );
  }

  Widget hrReport(HRReportController controller) {
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
              // 📅 Date Picker Field
              SizedBox(
                height: 60,
                width: 150,
                child: TextFormField(
                  readOnly: true,
                  controller: controller.dateController,
                  decoration: InputDecoration(
                    labelText: "Select Date",
                    prefixIcon: const Icon(Icons.calendar_today),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                  onTap: () async {
                    final DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2030),
                    );
                    if (pickedDate != null) {
                      final formattedDate =
                          "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                      controller.dateController.text = formattedDate;
                      await controller.onSelectDate();
                    }
                  },
                ),
              ),

              const SizedBox(width: 8),

              // 👤 Employee Name Text Field
              Expanded(
                child: SizedBox(
                  height: 60,
                  child: TextFormField(
                    controller: controller.employeeNameCtrl,
                    onChanged: (value) async {
                      await Future.delayed(
                        const Duration(milliseconds: 300),
                        () async {
                          await controller.onTypeEmployeeName(value);
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

              // 🏢 Company Dropdown — styled like TextField
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
                          (item) => DropdownMenuItem<String>(
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
                        await controller.onChangeDropDown(value);
                      }
                    },
                  ),
                ),
              ),

              const SizedBox(width: 8),

              // 🟢 Attendance Status Dropdown — styled same
              SizedBox(
                height: 60,
                width: 130,
                child: DropdownButtonFormField<String>(
                  value: controller.attendanceStatus,
                  dropdownColor: Colors.white,
                  decoration: InputDecoration(
                    labelText: "Status",
                    prefixIcon: const Icon(Icons.check_circle_outline),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                  items: controller.attendanceStatusList
                      .map(
                        (item) => DropdownMenuItem<String>(
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
                      await controller.onSelectStatus(value: value);
                    }
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  controller.reportEmployeesLoginList.isEmpty
                      ? "0"
                      : controller.reportEmployeesLoginList.length.toString(),
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
              columnSpacing: 60,
              onSelectAll: (_) => {},
              headingRowColor: WidgetStatePropertyAll(
                contentTheme.primary.withAlpha(40),
              ),
              dataRowMaxHeight: 60,

              showBottomBorder: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              border: TableBorder.all(
                borderRadius: BorderRadius.circular(4),
                style: BorderStyle.solid,
                width: .4,
                color: Colors.grey,
              ),
              columns: [
                DataColumn(
                  label: MyText.labelLarge(
                    'Employee Name',
                    color: contentTheme.primary,
                  ),
                ),
                DataColumn(
                  label: MyText.labelLarge(
                    'Punch IN',
                    color: contentTheme.primary,
                  ),
                ),
                DataColumn(
                  label: MyText.labelLarge(
                    'Punch OUT',
                    color: contentTheme.primary,
                  ),
                ),
                DataColumn(
                  label: MyText.labelLarge(
                    'Work Hrs',
                    color: contentTheme.primary,
                  ),
                ),
                DataColumn(
                  label: MyText.labelLarge(
                    'Remarks',
                    color: contentTheme.primary,
                  ),
                ),
              ],
              rows: controller.reportEmployeesLoginList.mapIndexed((
                index,
                data,
              ) {
                String workHrs = "0 Hrs 0 Min";
                if (data.inTime != null && data.outTime != null) {
                  Map<String, int> value = calculateWorkHours(
                    data.inTime!,
                    data.outTime!,
                  );
                  String hours = (value['hours'] ?? 0).toString();
                  String minutes = (value['minutes'] ?? 0).toString();
                  workHrs = "$hours Hrs $minutes Min";
                }
                return DataRow(
                  onSelectChanged: (selected) async {
                    if (selected ?? false) {
                      controller.inImage = null;
                      controller.outImage = null;
                      if (data.inPhoto != null && data.inPhoto != '') {
                        await controller.fetchImageBase64(
                          data.inPhoto!,
                          inPhoto: true,
                        );
                      }
                      if (data.outPhoto != null && data.outPhoto != '') {
                        await controller.fetchImageBase64(
                          data.outPhoto!,
                          inPhoto: false,
                        );
                      }
                      await controller.showEditLoginDialog(
                        context,
                        data,
                        contentTheme.primary,
                        false,
                        controller.dateController.value.text,
                      );
                      print("Tapped: ${data.employeeName}");
                    }
                  },
                  cells: [
                    DataCell(
                      MyText.bodyMedium(
                        data.employeeName ?? "",
                        fontWeight: 600,
                      ),
                    ),
                    DataCell(
                      SizedBox(
                        height: 200,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (data.inTime != null && data.inTime != "")
                              Row(
                                children: [
                                  Icon(
                                    Icons.timer,
                                    size: 14,
                                    color: contentTheme.primary,
                                  ),
                                  SizedBox(width: 3),
                                  Text(
                                    data.inTime == null || data.inTime == ""
                                        ? "---"
                                        : "${timeStringToStringWithAmPM(railwayTime: data.inTime!)}",
                                  ),
                                ],
                              ),
                            if (data.inLocation != null) SizedBox(height: 8),
                            if (data.inLocation != null)
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: 14,
                                    color: contentTheme.primary,
                                  ),
                                  SizedBox(width: 3),
                                  SizedBox(
                                    width: 200,
                                    child: Text(
                                      data.inLocation ?? "Null",
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                    DataCell(
                      SizedBox(
                        height: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (data.outTime != null && data.outTime != "")
                              Row(
                                children: [
                                  Icon(
                                    Icons.timer,
                                    size: 14,
                                    color: contentTheme.primary,
                                  ),
                                  SizedBox(width: 3),
                                  Text(
                                    data.outTime == null || data.outTime == ""
                                        ? "---"
                                        : "${timeStringToStringWithAmPM(railwayTime: data.outTime!)}",
                                  ),
                                ],
                              ),
                            if (data.outLocation != null) SizedBox(height: 8),
                            if (data.outLocation != null)
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: 14,
                                    color: contentTheme.primary,
                                  ),
                                  SizedBox(width: 3),
                                  SizedBox(
                                    width: 200,
                                    child: Text(
                                      data.outLocation ?? "Null",
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                    DataCell(MyText.bodyMedium(workHrs, fontWeight: 600)),
                    DataCell(
                      SizedBox(
                        width: 170,
                        child: MyText.bodyMedium(
                          data.remarks ?? "",
                          fontWeight: 600,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> showEditLoginDialog(
    BuildContext context,
    ReportEmployeesLoginList log,
  ) async {
    final TextEditingController inTimeCtrl = TextEditingController(
      text: log.inTime ?? "",
    );
    final TextEditingController outTimeCtrl = TextEditingController(
      text: log.outTime ?? "",
    );
    final TextEditingController remarks = TextEditingController(
      text: log.remarks ?? "",
    );

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: const Text("Edit Attendance"),
          content: SingleChildScrollView(
            // ✅ prevents overflow
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Text(
                        log.employee ?? "---",
                        style: TextStyle(
                          fontSize: 16,
                          color: contentTheme.primary,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        log.inDate ?? controller.dateController.value.text,
                        style: const TextStyle(fontSize: 12, color: Colors.red),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    log.employeeName ?? "---",
                    style: TextStyle(fontSize: 16, color: contentTheme.primary),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    log.company ?? "---",
                    style: TextStyle(fontSize: 16, color: contentTheme.primary),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    log.inLocation ?? "HR Edits",
                    style: TextStyle(fontSize: 12, color: contentTheme.primary),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    log.outLocation ?? "HR Edits",
                    style: TextStyle(fontSize: 12, color: contentTheme.primary),
                  ),
                  const SizedBox(height: 12),

                  // 🕒 Time Pickers Row
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          readOnly: true,
                          controller: inTimeCtrl,
                          decoration: const InputDecoration(
                            labelText: "In Time",
                            prefixIcon: Icon(Icons.access_time),
                            border: OutlineInputBorder(),
                          ),
                          onTap: () async {
                            final TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                              builder: (context, child) {
                                return MediaQuery(
                                  data: MediaQuery.of(context).copyWith(
                                    alwaysUse24HourFormat: false,
                                  ), // ✅ Force 12-hour format
                                  child: child!,
                                );
                              },
                            );
                            if (pickedTime != null) {
                              String time = pickedTime.format(context);
                              inTimeCtrl.text = "$time:00";
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: TextFormField(
                          readOnly: true,
                          controller: outTimeCtrl,
                          decoration: const InputDecoration(
                            labelText: "Out Time",
                            prefixIcon: Icon(Icons.access_time_filled),
                            border: OutlineInputBorder(),
                          ),
                          onTap: () async {
                            final TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                              builder: (context, child) {
                                return MediaQuery(
                                  data: MediaQuery.of(
                                    context,
                                  ).copyWith(alwaysUse24HourFormat: false),
                                  child: child!,
                                );
                              },
                            );
                            if (pickedTime != null) {
                              String time = pickedTime.format(context);
                              outTimeCtrl.text = "$time:00";
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: remarks,
                    decoration: const InputDecoration(
                      labelText: "Remarks",
                      prefixIcon: Icon(Icons.note_alt),
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 200,
                          color: Colors.red.withOpacity(0.2),
                          alignment: Alignment.center,
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
                      const SizedBox(width: 8),
                      Expanded(
                        child: Container(
                          height: 200,
                          color: Colors.blue.withOpacity(0.2),
                          alignment: Alignment.center,
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
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),

            ElevatedButton.icon(
              onPressed: () async {
                print("In Time: ${inTimeCtrl.text}");
                print("Out Time: ${outTimeCtrl.text}");
                print("Remarks: ${remarks.text}");

                log.inTime = inTimeCtrl.text;
                log.outTime = outTimeCtrl.text;
                log.remarks = remarks.text;
                log.inDate = log.inDate ?? controller.dateController.value.text;
                log.outDate = log.outTime == null
                    ? null
                    : log.outDate ?? controller.dateController.value.text;
                log.inLocation = log.inLocation ?? "HR Edits";
                log.outLocation = log.outLocation ?? "HR Edits";

                bool? value = await controller.saveLoginEntryDirect(log: log);
                if (value ?? false) {
                  toastMessage(message: "Update Success");
                }
                Navigator.pop(context);
              },
              icon: const Icon(Icons.save),
              label: const Text("Save"),
            ),
          ],
        );
      },
    );
  }
}
