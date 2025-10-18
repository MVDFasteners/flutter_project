import 'dart:convert';
import 'dart:io';

import 'package:flatten/app_constant.dart';
import 'package:flatten/controllers/auth/login_controller.dart';
import 'package:flatten/controllers/my_controller.dart';
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
        company: "MVD FASTENERS PRIVATE LIMITED",
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
        company: "MVD FASTENERS PRIVATE LIMITED",
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

  void updateEmployeeLogin(EmployeeLogin login) {
    employeeLogin = login;
    if (login.inPhoto != null) {
      fetchImageBase64(login.inPhoto!, inPhoto: true);
    } else {
      inImage = null;
    }
    if (login.outPhoto != null) {
      fetchImageBase64(login.outPhoto!, inPhoto: false);
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
        "$backendUrl/user_image_base64?image_path=$imagePath&cookie=$sessionId",
      );

      print("url$url");
      try {
        final response = await http.get(url);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          if (inPhoto) {
            inImage = data['image_base64'];
          } else {
            outImage = data['image_base64'];
          }

          update();
        }
      } catch (e) {
        print("Error fetching image: $e");
      }
    }
  }

  _findInOut(List<EmployeeLogin> loginList) {
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
    update();
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

    final url = Uri.parse("$backendUrl/user_login_list");
    employeeLoginList = [];
    final Map<String, dynamic> body = {
      'cookie': AuthService.sessionId,
      'company': company,
      'from_date': fromDate,
      'to_date': toDate,
      'employee_id': employeeId,
    };

    try {
      final response = await http.post(
        url,
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> list = data['message'] ?? [];
        employeeLoginList = list.map((e) => EmployeeLogin.fromJson(e)).toList();
        presentDays = 0;
        absentDays = 0;
        halfDays = 0;
        permissionsDays = 0;
        _calculatePresentDetails(employeeLoginList);
        _findInOut(employeeLoginList);
        print("✅ Total Logins: ${employeeLoginList.length}");
        for (var item in employeeLoginList) {
          print("${item.employeeName} - ${item.inDate} - ${item.inTime}");
        }
        update();
      } else {
        print("❌ Error ${response.statusCode}: ${response.body}");
      }
    } catch (e) {
      print("⚠️ Error: ${e.toString()}");
    }
  }

  Future<void> saveLoginEntry({File? value}) async {
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
      print(lat + long);
      address = await LocationService().getAddressFromLatLng(lat, long);
    }

    String? photoUrl;
    if (value != null) {
      photoUrl = await uploadImageToERPNext(value);
    }

    if (loginStatusCurrent == "IN") {
      newLogin = EmployeeLogin(
        employee: loginCtrl.userModel.employeeId,
        company: loginCtrl.userModel.company,
        user: loginCtrl.userModel.userId,
        inDate: currentDate,
        inTime: currentTime,
        inLocation: "address",
        inPhoto: photoUrl,
      );
    } else {
      if (newLogin.id != null) {
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
          outLocation: "address",
          inPhoto: newLogin.inPhoto,
          outPhoto: photoUrl,
        );
      } else {
        toastMessage(message: "Id Not found to Update Log Out");
      }
    }

    if (AuthService.sessionId == null) {
      print("❌ No session found. Please login first.");
      return;
    }

    final url = Uri.parse("$backendUrl/save_user_login");
    final Map<String, dynamic> body = {
      'cookie': AuthService.sessionId,
      'data': newLogin.toJson(),
    };

    try {
      final response = await http.post(
        url,
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

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

        if (data['message'] != null) {
          print(
            "✅ Employee Login ${data['message']['status']}: ${data['message']['name']}",
          );
        } else {
          print("⚠️ Response: $data");
        }
      } else {
        print("❌ Error ${response.statusCode}: ${response.body}");
      }
    } catch (e) {
      print("⚠️ Error: ${e.toString()}");
    }
    update();
  }

  Future<String?> uploadImageToERPNext(File imageFile) async {
    final url = Uri.parse("$backendUrl/upload_file");
    final request = http.MultipartRequest('POST', url);
    request.headers['Cookie'] = AuthService.sessionId!;
    request.fields['is_private'] = '0'; // or '1' for private files
    request.fields['folder'] = 'Home'; // optional: specify folder

    request.files.add(
      await http.MultipartFile.fromPath('file', imageFile.path),
    );

    final response = await request.send();
    print(response);

    if (response.statusCode == 200) {
      final respStr = await response.stream.bytesToString();
      final data = jsonDecode(respStr);
      return data['message']['file_url'];
    } else {
      print("❌ Image upload failed: ${response.statusCode}");
      return null;
    }
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

  void _calculatePresentDetails(List<EmployeeLogin> loginList) {
    for (EmployeeLogin log in loginList) {
      if (log.isLeave == 1) {
        presentDays++;
        continue;
      }

      if (log.inTime == null || log.inTime == "") {
        absentDays++;
        continue; // skip to next log
      }

      if (log.inTime != null && log.outTime == null || log.outTime == "") {
        halfDays++;
        continue;
      }

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
}
