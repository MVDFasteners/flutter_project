import 'dart:convert';
import 'dart:io';

import 'package:flatten/app_constant.dart';
import 'package:flatten/controllers/my_controller.dart';
import 'package:flatten/controllers/mycontroller/attendance_controller.dart';
import 'package:flatten/helpers/services/auth_service.dart';
import 'package:flatten/models/attendance.dart';
import 'package:flatten/models/monthly%20attendance%20model.dart';
import 'package:flatten/models/project_summary_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:windows_toast/windows_toast.dart';

class HRReportController extends MyController {
  List<ReportEmployeesLoginList> reportEmployeesLoginList = [];
  List<ReportEmployeesLoginList> allEmployeeLoginList = [];

  List<ReportEmployeesLoginList> selectedEmployees = [];

  bool isSelectMode = false;
  bool makeLock = false;

  DateTime dateTime = DateTime.now();
  String currentCompany = "MVD FASTENERS PRIVATE LIMITED";
  String attendanceStatus = "All";
  String employeeId = "";
  List<String> companyList = [];
  List<String> attendanceStatusList = ["All", "Present", "Absent", "Half"];

  String? inImage;
  String? outImage;

  TextEditingController dateController = TextEditingController(
    text: DateFormat('yyyy-MM-dd').format(DateTime.now()),
  );
  TextEditingController employeeNameCtrl = TextEditingController();
  TextEditingController employeeNameMonthCtrl = TextEditingController();

  /// this is for monthly log reportsss...

  String? selectedYear;
  String? selectedMonth;
  List<dynamic> leaveEvents = [];

  List<EmployeeAttendance> employeeLogMonthly = [];

  Future<void> onSelectYear(String value) async {
    selectedYear = value;
    Map<String, String> dateFilter = {};
    if (selectedYear != null && selectedMonth != null) {
      dateFilter = getMonthDateRange(int.parse(selectedYear!), selectedMonth!);
      print("From: ${dateFilter['fromDate']}");
      print("To: ${dateFilter['toDate']}");

      await fetchLoginListMonthly(
        company: currentCompany,
        employeeName: employeeNameMonthCtrl.text,
        fromDate: dateFilter['fromDate'],
        toDate: dateFilter['toDate'],
      );
      // await onSelectStatus();
    }
    update();
  }

  void onSelectAll() {
    for (ReportEmployeesLoginList data in reportEmployeesLoginList) {
      if (selectedEmployees.contains(data)) {
        // selectedEmployees.remove(data);
      } else {
        selectedEmployees.add(data);
      }
    }
    update();
  }

  void onSelectMonth(String value) async {
    selectedMonth = value;
    Map<String, String> dateFilter = {};
    if (selectedYear != null && selectedMonth != null) {
      dateFilter = getMonthDateRange(int.parse(selectedYear!), selectedMonth!);
      print("From: ${dateFilter['fromDate']}");
      print("To: ${dateFilter['toDate']}");
    }
    await fetchLoginListMonthly(
      company: currentCompany,
      employeeName: employeeNameMonthCtrl.text,
      fromDate: dateFilter['fromDate'],
      toDate: dateFilter['toDate'],
    );
    // await onSelectStatus();
    update();
  }

  Future<void> onCompanySelectForMonthReport(String value) async {
    currentCompany = value;
    Map<String, String> dateFilter = {};
    if (selectedYear != null && selectedMonth != null) {
      dateFilter = getMonthDateRange(int.parse(selectedYear!), selectedMonth!);
      print("From: ${dateFilter['fromDate']}");
      print("To: ${dateFilter['toDate']}");
    }

    await fetchLoginListMonthly(
      company: value,
      employeeName: employeeNameMonthCtrl.text,
      fromDate: dateFilter['fromDate'],
      toDate: dateFilter['toDate'],
    );
  }

  Future<void> onEmployeeNameTypeForMonthReport(String value) async {
    Map<String, String> dateFilter = {};
    if (selectedYear != null && selectedMonth != null) {
      dateFilter = getMonthDateRange(int.parse(selectedYear!), selectedMonth!);
      print("From: ${dateFilter['fromDate']}");
      print("To: ${dateFilter['toDate']}");
    }

    await fetchLoginListMonthly(
      company: currentCompany,
      employeeName: value,
      fromDate: dateFilter['fromDate'],
      toDate: dateFilter['toDate'],
    );
  }

  Map<String, String> getMonthDateRange(int year, String month) {
    int monthNum = monthMap[month]!;
    DateTime fromDate = DateTime(year, monthNum, 1);
    DateTime toDate = DateTime(
      year,
      monthNum + 1,
      1,
    ).subtract(const Duration(days: 1));

    return {'fromDate': _formatDate(fromDate), 'toDate': _formatDate(toDate)};
  }

  String _formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  Future<void> onSelectStatus({String? value}) async {
    if (value != null) {
      attendanceStatus = value;
      if (value == "All") {
        await fetchLoginListOneDay(
          fromDate: dateController.value.text,
          toDate: dateController.value.text,
          company: currentCompany,
          employeeName: employeeNameCtrl.value.text,
        );
      }
      update();
    }
    List<ReportEmployeesLoginList> statusFiltered = [];
    if (attendanceStatus == "All") {
      reportEmployeesLoginList = reportEmployeesLoginList;
      update();
    }

    if (attendanceStatus == "Absent") {
      statusFiltered.clear();
      for (ReportEmployeesLoginList log in allEmployeeLoginList) {
        if (log.status == "Absent") {
          statusFiltered.add(log);
        }
      }
      reportEmployeesLoginList.clear();
      reportEmployeesLoginList = statusFiltered;
      update();
    }

    if (attendanceStatus == "Present") {
      statusFiltered.clear();
      for (ReportEmployeesLoginList log in allEmployeeLoginList) {
        if (log.status == "Present") {
          statusFiltered.add(log);
        }
      }
      reportEmployeesLoginList.clear();
      reportEmployeesLoginList = statusFiltered;
      update();
    }

    if (attendanceStatus == "Half") {
      statusFiltered.clear();
      for (ReportEmployeesLoginList log in allEmployeeLoginList) {
        if (log.inTime != null && log.outTime == null) {
          statusFiltered.add(log);
        } else if (log.inTime != null && log.outTime != null) {
          Map<String, int> val = calculateWorkHours(log.inTime!, log.outTime!);
          int? hours = val['hours'];
          if (hours != null) {
            if (hours < 5) {
              statusFiltered.add(log);
            }
          }
          print(val);
        }
      }
      reportEmployeesLoginList.clear();
      reportEmployeesLoginList = statusFiltered;
      update();
    }
  }

  Future<void> onSelectDate() async {
    await fetchLoginListOneDay(
      fromDate: dateController.value.text,
      toDate: dateController.value.text,
      company: currentCompany,
      employeeName: employeeNameCtrl.value.text,
    );
    await onSelectStatus();
  }

  Future<void> onChangeDropDown(String value) async {
    currentCompany = value;
    await fetchLoginListOneDay(
      fromDate: dateController.value.text,
      toDate: dateController.value.text,
      company: value,
      employeeName: employeeNameCtrl.value.text,
    );
    await onSelectStatus();
    update();
  }

  Future<void> onTypeEmployeeName(String value) async {
    await fetchLoginListOneDay(
      fromDate: dateController.value.text,
      toDate: dateController.value.text,
      company: currentCompany,
      employeeName: employeeNameCtrl.value.text,
    );
    await onSelectStatus();
  }

  Future<void> fetchImageBase64(
    String photoPath, {
    required bool inPhoto,
  }) async {
    String? imagePath = photoPath;
    String? sessionId = AuthService.sessionId;

    if (sessionId != null && imagePath != null) {
      final url = Uri.parse(
        "$baseUrl/api/method/my_api_app.api_methods.hr_modules_api.user_image_base64?image_path=$imagePath&cookie=$sessionId",
      );

      print("url$url");
      try {
        final response = await http.get(url);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          var value = data["message"];
          print("value$value");
          if (inPhoto) {
            inImage = value['image_base64'];
          } else {
            outImage = value['image_base64'];
          }
          update();
        }
      } catch (e) {
        print("Error fetching image: $e");
      }
    }
  }

  Future<void> fetchLoginListMonthly({
    String? company,
    String? fromDate,
    String? toDate,
    String? employeeId,
    String? employeeName,
  }) async {
    if (AuthService.sessionId == null) {
      print("❌ No session found. Please login first.");
      return;
    }

    reportEmployeesLoginList = [];
    allEmployeeLoginList = [];

    final apiUrl =
        "$baseUrl/api/method/my_api_app.api_methods.hr_modules_api.monthly_employee_logs";

    try {
      final uri = Uri.parse(apiUrl).replace(
        queryParameters: {
          if (company != null) 'company': company,
          if (fromDate != null) 'from_date': fromDate,
          if (toDate != null) 'to_date': toDate,
          if (employeeId != null) 'employee_id': employeeId,
          if (employeeName != null) 'employee_name': employeeName,
        },
      );

      final response = await http.get(
        uri,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          'Cookie': AuthService.sessionId ?? '',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final List<dynamic> attendanceList =
            data['message']?['attendanceList'] ?? [];
        leaveEvents = data['message']?['eventList'] ?? [];
        employeeLogMonthly = attendanceList
            .map((e) => EmployeeAttendance.fromJson(e))
            .toList();

        update();
        print(
          "✅ Attendance list fetched successfully (${employeeLogMonthly.length} logs from)",
        );
      } else {
        print("❌ Error ${response.statusCode}: ${response.body}");
      }
    } catch (e) {
      print("⚠️ Error fetching login list: $e");
    }
  }

  Future<void> fetchLoginListOneDay({
    String? company,
    String? fromDate,
    String? toDate,
    String? employeeId,
    String? employeeName,
  }) async {
    if (AuthService.sessionId == null) {
      print("❌ No session found. Please login first.");
      return;
    }

    reportEmployeesLoginList = [];
    allEmployeeLoginList = [];

    final apiUrl =
        "$baseUrl/api/method/my_api_app.api_methods.hr_modules_api.per_day_login_list"; // ✅ updated function name

    try {
      final uri = Uri.parse(apiUrl).replace(
        queryParameters: {
          if (company != null) 'company': company,
          if (fromDate != null) 'from_date': fromDate,
          if (toDate != null) 'to_date': toDate,
          if (employeeId != null) 'employee_id': employeeId,
          if (employeeName != null) 'employee_name': employeeName,
          // ✅ new filter
        },
      );

      final response = await http.get(
        uri,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          'Cookie': AuthService.sessionId ?? '',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> attendanceList =
            data['message']?['attendanceList'] ?? [];
        final List<dynamic> eventList = data['message']?['eventList'] ?? [];
        reportEmployeesLoginList = attendanceList
            .map((e) => ReportEmployeesLoginList.fromJson(e))
            .toList();
        allEmployeeLoginList = attendanceList
            .map((e) => ReportEmployeesLoginList.fromJson(e))
            .toList();
        update();
        // print("✅ Attendance list fetched successfully (${employeeLoginList.length} records)");
      } else {
        print("❌ Error ${response.statusCode}: ${response.body}");
      }
    } catch (e) {
      print("⚠️ Error fetching login list: $e");
    }
  }

  Future<bool?> saveLoginEntryDirect({
    required ReportEmployeesLoginList log,
  }) async {
    if (AuthService.sessionId == null) {
      print("❌ No session found. Please login first.");
      return null;
    }
    final apiUrl =
        "$baseUrl/api/method/my_api_app.api_methods.hr_modules_api.save_login_entry";

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          'Cookie': AuthService.sessionId!, // use ERPNext session cookie
        },
        body: jsonEncode({'data': log.toJson()}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("✅ Saved successfully: $data");

        final loginId = data['message']?['name'];
        print(loginId);
        if (loginId != null) {
          return true;
        }
      }
    } catch (e) {
      print("⚠️ Error saving login: $e");
    }

    update();
  }

  Future<int> deleteEmployeeLog() async {
    int deletedCount = 0;
    if (AuthService.sessionId == null) {
      print("❌ No session found. Please login first.");
      return deletedCount;
    }

    if (selectedEmployees.isNotEmpty) {
      for (ReportEmployeesLoginList log in selectedEmployees) {
        final apiUrl =
            "$baseUrl/api/method/my_api_app.api_methods.hr_modules_api.delete_login_entry";

        try {
          final response = await http.post(
            Uri.parse(apiUrl),
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
              'Cookie': AuthService.sessionId!, // use ERPNext session cookie
            },
            body: jsonEncode({'name': log.loginId}),
          );

          if (response.statusCode == 200) {
            final data = jsonDecode(response.body);
            print("✅ Deleted successfully: $data");

            var status = data['message']?['status'];
            if (status == "deleted") {
              deletedCount++;
            }
          }
        } catch (e) {
          print("⚠️ Error saving login: $e");
        }
      }
      update();
      await fetchLoginListOneDay(
        fromDate: dateController.value.text,
        toDate: dateController.value.text,
        company: currentCompany,
        employeeName: employeeNameCtrl.value.text,
      );
      await onSelectStatus();
      return deletedCount;
    }
    return deletedCount;
  }

  Future<void> fetchCompanyList() async {
    if (AuthService.sessionId == null) {
      print("❌ No session found. Please login first.");
      return;
    }

    final apiUrl =
        "$baseUrl/api/method/my_api_app.api_methods.hr_modules_api.get_company_list";

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          'Cookie': AuthService.sessionId ?? '',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> companyData = data['message']?['companies'] ?? [];

        // Convert to string list
        companyList = companyData.map((e) => e['name'].toString()).toList();

        if (companyList.isNotEmpty) {
          currentCompany ??= companyList.first;
        }

        update(); // if you're using GetX
        print("✅ Company list fetched: ${companyList.length} items");
      } else {
        print("❌ Error ${response.statusCode}: ${response.body}");
      }
    } catch (e) {
      print("⚠️ Error fetching company list: $e");
    }
  }

  Future<void> showEditLoginDialog(
    BuildContext context,
    ReportEmployeesLoginList log,
    primaryColor,
    isFromMonth,
    filteredDate,
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
        return GetBuilder(
          init: this,
          builder: (controller) {
            // controller.makeLock = false;
            // controller.update();
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              title: const Text("Edit Attendance"),
              content: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: selectedEmployeesWidget(),
                      ),
                      Row(
                        children: [
                          Text(
                            log.employee ?? "---",
                            style: TextStyle(fontSize: 16, color: primaryColor),
                          ),
                          const Spacer(),
                          Text(
                            log.inDate ?? filteredDate,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        log.employeeName ?? "---",
                        style: TextStyle(fontSize: 16, color: primaryColor),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        log.company ?? "---",
                        style: TextStyle(fontSize: 16, color: primaryColor),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        log.inLocation ?? "HR Edits",
                        style: TextStyle(fontSize: 12, color: primaryColor),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        log.outLocation ?? "HR Edits",
                        style: TextStyle(fontSize: 12, color: primaryColor),
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
                                final TimeOfDay? pickedTime =
                                    await showTimePicker(
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
                                final TimeOfDay? pickedTime =
                                    await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                      builder: (context, child) {
                                        return MediaQuery(
                                          data: MediaQuery.of(context).copyWith(
                                            alwaysUse24HourFormat: false,
                                          ),
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
                      Text("Locked = ${log.makeLock}"),
                      Row(
                        children: [
                          Text("Make Lock :"),
                          Checkbox(
                            value: controller.makeLock,
                            onChanged: (value) {
                              print(value);
                              controller.makeLock = value!;
                              controller.update();
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
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
                              child: inImage != null
                                  ? Image.memory(
                                      base64Decode(inImage!.split(',')[1]),
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
                              child: outImage != null
                                  ? Image.memory(
                                      base64Decode(outImage!.split(',')[1]),
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
                    log.inDate = log.inDate ?? dateController.value.text;
                    log.outDate = log.outTime == null
                        ? null
                        : log.outDate ?? dateController.value.text;
                    log.inLocation = log.inLocation ?? "HR Edits";
                    log.outLocation = log.outLocation ?? "HR Edits";
                    log.makeLock = controller.makeLock ? 1 : 0;

                    bool? value = await saveLoginEntryDirect(log: log);
                    if (value ?? false) {
                      toastMessage(message: "Update Success");
                      if (value ?? false) {
                        if (isFromMonth) {
                          Map<String, String> dateFilter = {};
                          if (selectedYear != null && selectedMonth != null) {
                            dateFilter = getMonthDateRange(
                              int.parse(selectedYear!),
                              selectedMonth!,
                            );
                            print("From: ${dateFilter['fromDate']}");
                            print("To: ${dateFilter['toDate']}");
                          }

                          await fetchLoginListMonthly(
                            company: currentCompany,
                            employeeName: employeeNameMonthCtrl.text,

                            fromDate: dateFilter['fromDate'],
                            toDate: dateFilter['toDate'],
                          );
                        } else {
                          await fetchLoginListOneDay(
                            fromDate: dateController.value.text,
                            toDate: dateController.value.text,
                            company: currentCompany,
                            employeeName: employeeNameCtrl.value.text,
                          );
                          await onSelectStatus();
                        }
                      }
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
      },
    );
  }

  Future<void> showEditMultipleLoginDialog(
    BuildContext context,
    List<ReportEmployeesLoginList> logs,
  ) async {
    final TextEditingController inTimeCtrl = TextEditingController();
    final TextEditingController outTimeCtrl = TextEditingController();
    final TextEditingController remarks = TextEditingController();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: const Text("Edit Attendance"),
          content: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: selectedEmployeesWidget(),
                  ),
                  Text(
                    dateController.value.text,
                    style: const TextStyle(fontSize: 12, color: Colors.red),
                  ),
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
                                  data: MediaQuery.of(
                                    context,
                                  ).copyWith(alwaysUse24HourFormat: false),
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
                print("Date: ${dateController.value.text}");

                int successCount = await onMultipleSave(
                  inTimeCtrl.text,
                  outTimeCtrl.text,
                  dateController.value.text,
                  remarks.text,
                );
                if (successCount != 0) {
                  WindowsToast.show(
                    'Edited for $successCount',
                    context,
                    30,
                    textStyle: const TextStyle(color: Colors.white),
                  );
                }
                successCount = 0;
                selectedEmployees.clear();
                await fetchLoginListOneDay(
                  fromDate: dateController.value.text,
                  toDate: dateController.value.text,
                  company: currentCompany,
                  employeeName: employeeNameCtrl.value.text,
                );
                await onSelectStatus();
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

  Future<int> onMultipleSave(
    String inTime,
    String outTime,
    String inDate,
    String remarks,
  ) async {
    int successCount = 0;
    if (selectedEmployees.isNotEmpty) {
      for (ReportEmployeesLoginList log in selectedEmployees) {
        log.inTime = log.inTime ?? inTime;
        log.outTime = log.outTime ?? outTime;
        log.remarks = remarks;
        log.inDate = inDate;
        log.outDate = inDate;
        log.inLocation = "HR Edits";
        log.outLocation = "HR Edits";

        bool? value = await saveLoginEntryDirect(log: log);
        if (value ?? false) {
          successCount++;
        }
        print(value);
      }
      return successCount;
    }
    return successCount;
  }

  List<Widget> selectedEmployeesWidget() {
    List<Widget> selected = [];

    for (int i = 0; i < selectedEmployees.length; i++) {
      ReportEmployeesLoginList data = selectedEmployees[i];

      selected.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            children: [
              const Icon(Icons.person, size: 18),
              const SizedBox(width: 8),
              Text(
                data.employeeName ?? "",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return selected;
  }

  String padTime(String time) {
    List<String> parts = time.split(':');
    for (int i = 0; i < parts.length; i++) {
      parts[i] = parts[i].padLeft(2, '0');
    }
    return parts.join(':'); // "09:10:01"
  }

  int presentDays = 0;
  int absentDays = 0;
  int halfDays = 0;
  int permissionsDays = 0;

  Map<String, int>? calculatePresentDetails(EmployeeAttendance employeeDetail) {
    int presentDays = 0;
    int absentDays = 0;
    int halfDays = 0;
    int permissionsDays = 0;
    Map<String, int> value = {};

    List<String?>? leaveDateList = [];
    Set<dynamic> leaveDates = {};
    Set<String> punchedInDays = {};

    if (leaveEvents.isNotEmpty) {
      leaveDates = leaveEvents.map((e) => e['date']).toSet();
      leaveDateList = employeeDetail.logList
          .where((login) => leaveDates.contains(login.inDate))
          .map((login) => login.inDate)
          .toList();
    }

    print("date filtered list$leaveDateList");

    List<String> datList = completedDateListPerMonth();

    Set<String> dataSet = datList.toSet();

    for (ReportEmployeesLoginListMonthly log in employeeDetail.logList) {
      if (log.inDate != null) {
        punchedInDays.add(log.inDate!);
      }
    }

    Set<String> notPunchedList = dataSet.difference(punchedInDays);
    Set absentDaysSetN = notPunchedList.difference(leaveDates);

    print(absentDaysSetN);
    absentDaysSetN.toList();
    absentDays = absentDaysSetN.length;
    presentDays = leaveEvents.length;
    for (ReportEmployeesLoginListMonthly log in employeeDetail.logList) {
      if (leaveDates.contains(log.inDate)) {
        continue;
      }
      // check half days..................
      if (log.inTime != null && log.outTime == null || log.outTime == "") {
        halfDays++;
        continue;
      }
      // check present days ..................
      if (log.inTime != null && log.outTime != null || log.outTime != "") {
        Map<String, int> value = calculateWorkHours(log.inTime!, log.outTime!);
        int hours = value['hours'] ?? 0;
        int minutes = value['minutes'] ?? 0;

        if (hours < 6 || (hours == 5 && minutes < 60)) {
          print(log.inDate);
          halfDays++;
        } else if (hours > 6 && hours < 8) {
          permissionsDays++;
          presentDays++;
        } else {
          presentDays++;
        }
      }
    }

    value["presentDays"] = presentDays;
    value["absentDays"] = absentDays;
    value["halfDays"] = halfDays;
    value["permissionDays"] = permissionsDays;
    return value;
  }
}
