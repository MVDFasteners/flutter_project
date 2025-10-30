import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flatten/app_constant.dart';
import 'package:flatten/controllers/auth/login_controller.dart';
import 'package:flatten/controllers/my_controller.dart';
import 'package:flatten/controllers/mycontroller/camera_controller.dart';
import 'package:flatten/controllers/other/syncfusion_charts_controller.dart';
import 'package:flatten/helpers/extensions/extensions.dart';
import 'package:flatten/helpers/services/auth_service.dart';
import 'package:flatten/helpers/theme/app_style.dart';
import 'package:flatten/images.dart';
import 'package:flatten/models/attendance.dart';
import 'package:flatten/models/customer.dart';
import 'package:flatten/models/product.dart';
import 'package:flatten/models/sales_team_summary.dart';
import 'package:flatten/models/sales_yearly_summary.dart';
import 'package:flatten/models/user.dart';
import 'package:flatten/myPages/locaiton_service.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart' hide Position;

class AttendanceController extends MyController {
  List<EmployeeLogin> employeeLoginList = [];
  EmployeeLogin employeeLogin = EmployeeLogin();
  final LoginController loginCtrl = Get.put(LoginController());
  CameraControllerNew cameraControllerNew = Get.put(CameraControllerNew());

  String? inImage;
  String? outImage;

  String? selectedYear;
  String? selectedMonth;

  String loginStatusCurrent = "IN";
  String? lastLoginId;

  final TickerProvider tickerProvider;
  int defaultIndex = 0;
  late TabController defaultTabController = TabController(
    length: 2,
    vsync: tickerProvider,
    initialIndex: defaultIndex,
  );
  String selectedImage = Images.squareImages[2];

  AttendanceController(this.tickerProvider);

  @override
  void onInit() {
    super.onInit();
    String currentMonthName = monthMap.keys.elementAt(DateTime.now().month - 1);
    selectedMonth = currentMonthName;
    selectedYear = DateTime.now().year.toString();

    defaultTabController.addListener(() {
      if (defaultIndex != defaultTabController.index) {
        defaultIndex = defaultTabController.index;
        update();
      }
    });

    Map<String, String> dateFilter = {};

    if (selectedYear != null &&
        selectedMonth != null &&
        loginCtrl.userModel.employeeId != null) {
      dateFilter = getMonthDateRange(int.parse(selectedYear!), selectedMonth!);
      print("From: ${dateFilter['fromDate']}");
      print("To: ${dateFilter['toDate']}");

      fetchLoginList(
        company: loginCtrl.userModel.company,
        fromDate: dateFilter['fromDate'],
        toDate: dateFilter['toDate'],
        employeeId: loginCtrl.userModel.employeeId,
      );
    }
  }

  void onSelectYear(String value) {
    selectedYear = value;
    Map<String, String> dateFilter = {};
    if (selectedYear != null &&
        selectedMonth != null &&
        loginCtrl.userModel.employeeId != null) {
      dateFilter = getMonthDateRange(int.parse(selectedYear!), selectedMonth!);
      print("From: ${dateFilter['fromDate']}");
      print("To: ${dateFilter['toDate']}");

      fetchLoginList(
        company: loginCtrl.userModel.company,
        fromDate: dateFilter['fromDate'],
        toDate: dateFilter['toDate'],
        employeeId: loginCtrl.userModel.employeeId,
      );
    }
    update();
  }

  void onSelectMonth(String value) {
    selectedMonth = value;

    Map<String, String> dateFilter = {};
    if (selectedYear != null &&
        selectedMonth != null &&
        loginCtrl.userModel.employeeId != null) {
      dateFilter = getMonthDateRange(int.parse(selectedYear!), selectedMonth!);
      print("From: ${dateFilter['fromDate']}");
      print("To: ${dateFilter['toDate']}");

      fetchLoginList(
        company: loginCtrl.userModel.company,
        fromDate: dateFilter['fromDate'],
        toDate: dateFilter['toDate'],
        employeeId: loginCtrl.userModel.employeeId,
      );
    }

    update();
  }

  String _formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
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

  Future<void> updateEmployeeLogin(EmployeeLogin login) async {
    employeeLogin = login;
    if (login.inPhoto != null) {
      await fetchImageBase64(login.inPhoto!, inPhoto: true);
    } else {
      inImage = null;
    }
    if (login.outPhoto != null) {
      await fetchImageBase64(login.outPhoto!, inPhoto: false);
    } else {
      outImage = null;
    }
    update();
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

      // final url = Uri.parse(
      //   "$backendUrl/user_image_base64?image_path=$imagePath&cookie=$sessionId",
      // );

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

  void _findInOut(List<EmployeeLogin> loginList) {
    if (loginList.isNotEmpty) {
      DateTime now = DateTime.now();
      DateTime currentDate = DateTime(now.year, now.month, now.day);
      DateTime? lastDate;

      if (loginList.first.inDate != null) {
        lastDate = DateFormat("yyyy-MM-dd").parse(loginList.first.inDate!);
      }

      if (lastDate != null && lastDate == currentDate) {
        if (loginList.first.inTime == null || loginList.first.inTime == "") {
          loginStatusCurrent = "IN";
        } else {
          loginStatusCurrent = "OUT";
        }
      } else {
        loginStatusCurrent = "IN";
      }
    } else {
      loginStatusCurrent = "IN";
    }
  }

  Future<void> fetchLoginList({
    String? company,
    String? fromDate,
    String? toDate,
    String? employeeId,
  }) async {
    if (AuthService.sessionId == null) {
      print("❌ No session found. Please login first.");
      return;
    }
    employeeLoginList = [];
    final apiUrl =
        "$baseUrl/api/method/my_api_app.api_methods.hr_modules_api.get_login_list";

    try {
      final uri = Uri.parse(apiUrl).replace(
        queryParameters: {
          if (company != null) 'company': company,
          if (fromDate != null) 'from_date': fromDate,
          if (toDate != null) 'to_date': toDate,
          if (employeeId != null) 'employee_id': employeeId,
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
        final List<dynamic> list = data['message']?['loginList'] ?? [];
        final List<dynamic> leaveList = data['message']?['eventList'] ?? [];

        employeeLoginList = list.map((e) => EmployeeLogin.fromJson(e)).toList();

        presentDays = 0;
        absentDays = 0;
        halfDays = 0;
        permissionsDays = 0;

        if (employeeLoginList.isNotEmpty) {
          _findInOut(employeeLoginList);
          _calculatePresentDetails(employeeLoginList, leaveList);
        } else {
          loginStatusCurrent = "IN";
        }

        update();
        print("✅ Login list fetched successfully");
      } else {
        print("❌ Error ${response.statusCode}: ${response.body}");
      }
    } catch (e) {
      print("⚠️ Error fetching login list: $e");
    }
  }

  // Future<void> fetchLoginList({
  //   String? company,
  //   String? fromDate,
  //   String? toDate,
  //   String? employeeId,
  // }) async {
  //   if (AuthService.sessionId == null) {
  //     print("❌ No session found. Please login first.");
  //     return;
  //   }
  //
  //   final url = Uri.parse("$backendUrl/user_login_list");
  //   employeeLoginList = [];
  //   final Map<String, dynamic> body = {
  //     'cookie': AuthService.sessionId,
  //     'company': company,
  //     'from_date': fromDate,
  //     'to_date': toDate,
  //     'employee_id': employeeId,
  //   };
  //
  //   try {
  //     final response = await http.post(
  //       url,
  //       headers: {HttpHeaders.contentTypeHeader: 'application/json'},
  //       body: jsonEncode(body),
  //     );
  //
  //     if (response.statusCode == 200) {
  //       final data = jsonDecode(response.body);
  //       final List<dynamic> list = data['message']['loginList'] ?? [];
  //       final List<dynamic> leaveList = data['message']['eventList'] ?? [];
  //
  //       employeeLoginList = list.map((e) => EmployeeLogin.fromJson(e)).toList();
  //
  //       presentDays = 0;
  //       absentDays = 0;
  //       halfDays = 0;
  //       permissionsDays = 0;
  //       if (employeeLoginList.isNotEmpty) {
  //         _findInOut(employeeLoginList);
  //         _calculatePresentDetails(employeeLoginList, leaveList);
  //       } else {
  //         loginStatusCurrent = "IN";
  //       }
  //       update();
  //     } else {
  //       print("❌ Error ${response.statusCode}: ${response.body}");
  //     }
  //   } catch (e) {
  //     print("⚠️ Error: ${e.toString()}");
  //   }
  // }

  Future<void> saveLoginEntryDirect({
    required Uint8List compressedBytes,
    required String fileName,
  }) async {
    DateTime now = DateTime.now();
    String currentDate = DateFormat('yyyy-MM-dd').format(now);
    String currentTime = DateFormat('HH:mm:ss').format(now);

    EmployeeLogin newLogin;

    if (loginStatusCurrent == "IN") {
      newLogin = EmployeeLogin();
    } else {
      newLogin = employeeLoginList.first;
    }

    Position? position = await LocationService().getCurrentPosition();
    String address = "----";

    if (position != null) {
      double lat = position.latitude;
      double long = position.longitude;
      address = await LocationService().getAddressFromLatLng(lat, long);
    }

    if (loginStatusCurrent == "IN") {
      newLogin = EmployeeLogin(
        employee: loginCtrl.userModel.employeeId,
        company: loginCtrl.userModel.company,
        user: loginCtrl.userModel.userId,
        inDate: currentDate,
        inTime: currentTime,
        inLocation: address,
      );
    } else {
      if (newLogin.id != null) {
        String? fileUrl = await cameraControllerNew.uploadImageBytesToERPNext(
          compressedBytes: compressedBytes,
          docname: newLogin.id!,
          doctype: "Employee Login",
          fileFieldName: "out_photo",
          fileName: fileName,
        );

        newLogin = EmployeeLogin(
          id: newLogin.id,
          employee: loginCtrl.userModel.employeeId,
          company: loginCtrl.userModel.company,
          user: loginCtrl.userModel.userId,
          inTime: newLogin.inTime,
          inDate: newLogin.inDate,
          inLocation: newLogin.inLocation,
          outDate: currentDate,
          outTime: currentTime,
          outLocation: address,
          inPhoto: newLogin.inPhoto,
          outPhoto: fileUrl,
        );
      } else {
        toastMessage(message: "Id not found to update logout");
        return;
      }
    }

    if (AuthService.sessionId == null) {
      print("❌ No session found. Please login first.");
      return;
    }

    // 🔹 Direct ERPNext API endpoint
    final apiUrl =
        "$baseUrl/api/method/my_api_app.api_methods.hr_modules_api.save_login_entry";

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          'Cookie': AuthService.sessionId!, // use ERPNext session cookie
        },
        body: jsonEncode({'data': newLogin.toJson()}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("✅ Saved successfully: $data");

        final loginId = data['message']?['name'];
        if (loginStatusCurrent == "IN" && loginId != null) {
          await updateLoginEntryIN(
            fileName: fileName,
            compressedBytes: compressedBytes,
            loginId: loginId,
            url: apiUrl,
          );
        }

        Map<String, String> dateFilter = {};

        if (selectedYear != null &&
            selectedMonth != null &&
            loginCtrl.userModel.employeeId != null) {
          dateFilter = getMonthDateRange(
            int.parse(selectedYear!),
            selectedMonth!,
          );
          print("From: ${dateFilter['fromDate']}");
          print("To: ${dateFilter['toDate']}");

          await fetchLoginList(
            company: loginCtrl.userModel.company,
            fromDate: dateFilter['fromDate'],
            toDate: dateFilter['toDate'],
            employeeId: loginCtrl.userModel.employeeId,
          );
        }
      } else {
        print("❌ ERPNext Error ${response.statusCode}: ${response.body}");
      }
    } catch (e) {
      print("⚠️ Error saving login: $e");
    }

    update();
  }

  //
  // Future<void> saveLoginEntry({
  //   required Uint8List compressedBytes,
  //   required String fileName,
  // }) async {
  //   DateTime now = DateTime.now();
  //   String currentDate = DateFormat('yyyy-MM-dd').format(now);
  //   String currentTime = DateFormat('HH:mm:ss').format(now);
  //   EmployeeLogin newLogin;
  //
  //   if (loginStatusCurrent == "IN") {
  //     newLogin = EmployeeLogin();
  //   } else {
  //     newLogin = employeeLoginList.first;
  //   }
  //
  //   Position? position = await LocationService().getCurrentPosition();
  //   String address = "----";
  //
  //   if (position != null) {
  //     double lat = position.latitude;
  //     double long = position.longitude;
  //     print(lat + long);
  //     address = await LocationService().getAddressFromLatLng(lat, long);
  //   }
  //   if (loginStatusCurrent == "IN") {
  //     newLogin = EmployeeLogin(
  //       employee: loginCtrl.userModel.employeeId,
  //       company: loginCtrl.userModel.company,
  //       user: loginCtrl.userModel.userId,
  //       inDate: currentDate,
  //       inTime: currentTime,
  //       inLocation: address,
  //       // inPhoto: fileUrl,
  //     );
  //   } else {
  //     if (newLogin.id != null) {
  //       String? fileUrl = await cameraControllerNew.uploadImageBytesToERPNext(
  //         compressedBytes: compressedBytes,
  //         docname: newLogin.id!,
  //         doctype: "Employee Login",
  //         fileFieldName: "out_photo",
  //         fileName: fileName,
  //       );
  //
  //       print(fileUrl);
  //
  //       newLogin = EmployeeLogin(
  //         id: newLogin.id,
  //         employee: loginCtrl.userModel.employeeId,
  //         company: loginCtrl.userModel.company,
  //         user: loginCtrl.userModel.userId,
  //         inTime: newLogin.inTime,
  //         inDate: newLogin.inDate,
  //         inLocation: newLogin.inLocation,
  //         outDate: currentDate,
  //         outTime: currentTime,
  //         outLocation: address,
  //         inPhoto: newLogin.inPhoto,
  //         outPhoto: fileUrl,
  //       );
  //     } else {
  //       toastMessage(message: "Id Not found to Update Log Out");
  //     }
  //   }
  //
  //   if (AuthService.sessionId == null) {
  //     print("❌ No session found. Please login first.");
  //     return;
  //   }
  //
  //   final url = Uri.parse("$backendUrl/save_user_login");
  //   final Map<String, dynamic> body = {
  //     'cookie': AuthService.sessionId,
  //     'data': newLogin.toJson(),
  //   };
  //
  //   try {
  //     final response = await http.post(
  //       url,
  //       headers: {HttpHeaders.contentTypeHeader: 'application/json'},
  //       body: jsonEncode(body),
  //     );
  //
  //     if (response.statusCode == 200) {
  //       final data = jsonDecode(response.body);
  //       String? loginId = data['message']['name'];
  //       if (loginId != null) {
  //         if (loginStatusCurrent == "IN") {
  //           await updateLoginEntryIN(
  //             fileName: fileName,
  //             compressedBytes: compressedBytes,
  //             loginId: loginId,
  //           );
  //         }
  //       }
  //
  //       Map<String, String> dateFilter = {};
  //
  //       if (selectedYear != null &&
  //           selectedMonth != null &&
  //           loginCtrl.userModel.employeeId != null) {
  //         dateFilter = getMonthDateRange(
  //           int.parse(selectedYear!),
  //           selectedMonth!,
  //         );
  //         print("From: ${dateFilter['fromDate']}");
  //         print("To: ${dateFilter['toDate']}");
  //
  //         await fetchLoginList(
  //           company: loginCtrl.userModel.company,
  //           fromDate: dateFilter['fromDate'],
  //           toDate: dateFilter['toDate'],
  //           employeeId: loginCtrl.userModel.employeeId,
  //         );
  //       }
  //
  //       if (data['message'] != null) {
  //         print(
  //           "✅ Employee Login ${data['message']['status']}: ${data['message']['name']}",
  //         );
  //       } else {
  //         print("⚠️ Response: $data");
  //       }
  //     } else {
  //       print("❌ Error ${response.statusCode}: ${response.body}");
  //     }
  //   } catch (e) {
  //     print("⚠️ Error: ${e.toString()}");
  //   }
  //   update();
  // }

  Future<bool?> updateLoginEntryIN({
    required String loginId,
    required Uint8List compressedBytes,
    required String fileName,
    required String url,
  }) async {
    // 🔹 Upload image first to ERPNext File
    String? fileUrl = await cameraControllerNew.uploadImageBytesToERPNext(
      compressedBytes: compressedBytes,
      docname: loginId,
      doctype: "Employee Login",
      fileFieldName: "in_photo",
      fileName: fileName,
    );

    if (fileUrl == null) {
      print("⚠️ Image upload failed — no file URL returned.");
      return false;
    }

    final Map<String, dynamic> body = {
      'data': {'name': loginId, 'in_photo': fileUrl},
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          'Cookie': AuthService.sessionId ?? '',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final status = data['message']?['status'];
        if (status == "updated") {
          print("✅ Employee Login updated successfully: $loginId");
          return true;
        } else {
          print("⚠️ Unexpected response: $data");
        }
      } else {
        print("❌ ERPNext Error ${response.statusCode}: ${response.body}");
      }
    } catch (e) {
      print("⚠️ Exception while updating: $e");
    }

    update();
    return false;
  }

  // Future<bool?> updateLoginEntryIN({
  //   required String loginId,
  //   required Uint8List compressedBytes,
  //   required String fileName,
  // }) async {
  //   String? fileUrl = await cameraControllerNew.uploadImageBytesToERPNext(
  //     compressedBytes: compressedBytes,
  //     docname: loginId,
  //     doctype: "Employee Login",
  //     fileFieldName: "in_photo",
  //     fileName: fileName,
  //   );
  //
  //   if (fileUrl != null) {
  //     final url = Uri.parse("$backendUrl/save_user_login");
  //     final Map<String, dynamic> body = {
  //       'cookie': AuthService.sessionId,
  //       'data': {'name': loginId, 'in_photo': fileUrl},
  //     };
  //
  //     try {
  //       final response = await http.post(
  //         url,
  //         headers: {HttpHeaders.contentTypeHeader: 'application/json'},
  //         body: jsonEncode(body),
  //       );
  //
  //       if (response.statusCode == 200) {
  //         final data = jsonDecode(response.body);
  //         String? value = data['message']['status'];
  //         if (value != null && value == "updated") {
  //           return true;
  //         }
  //       } else {
  //         print("❌ Error ${response.statusCode}: ${response.body}");
  //       }
  //     } catch (e) {
  //       print("⚠️ Error: ${e.toString()}");
  //     }
  //   }
  //
  //   update();
  // }

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

  void _calculatePresentDetails(
    List<EmployeeLogin> loginList,
    List<dynamic> leaveList,
  ) {
    print("indate form loginlist${loginList[0].inDate}");

    // print("indate form loginlist${leaveList[0]['date']}");
    List<String?>? leaveDateList = [];
    Set<dynamic> leaveDates = {};
    Set<String> punchedInDays = {};

    if (leaveList.isNotEmpty) {
      leaveDates = leaveList.map((e) => e['date']).toSet();
      leaveDateList = loginList
          .where((login) => leaveDates.contains(login.inDate))
          .map((login) => login.inDate)
          .toList();
    }

    print("date filtered list$leaveDateList");

    List<String> datList = completedDateListPerMonth();

    Set<String> dataSet = datList.toSet();

    for (EmployeeLogin log in loginList) {
      if (log.inDate != null) {
        punchedInDays.add(log.inDate!);
      }
    }

    Set<String> notPunchedList = dataSet.difference(punchedInDays);
    Set absentDaysSetN = notPunchedList.difference(leaveDates);

    print(absentDaysSetN);
    absentDaysSetN.toList();
    absentDays = absentDaysSetN.length;
    presentDays = leaveList.length;
    for (EmployeeLogin log in loginList) {
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

    print("presentDays: $presentDays");
    print("absentDays: $absentDays");
    print("halfDays: $halfDays");
    print("permissionDays: $permissionsDays");
  }

  List<String> completedDateListPerMonth() {
    DateTime today = DateTime.now();
    int year = today.year;
    int month = today.month;
    int date = today.day;
    List<String> completedDates = [];
    for (int day = 1; day <= date; day++) {
      completedDates.add("$year-$month-$day");
    }
    print("Days completed in month: ${completedDates.length}");
    print("List of completed dates:");
    return completedDates;
  }
}
