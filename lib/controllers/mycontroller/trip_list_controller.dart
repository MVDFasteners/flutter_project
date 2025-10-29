import 'dart:convert';
import 'dart:io';
import 'package:flatten/controllers/auth/login_controller.dart';
import 'package:flatten/helpers/services/auth_service.dart';
import 'package:flatten/models/trip_list.dart';
import 'package:flatten/myPages/locaiton_service.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flatten/app_constant.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';

class TripListController extends GetxController {
  List<Trip> travelLogs = [];
  Trip currentTrip = Trip();
  bool isFetchLoading = false;

  bool isLoading = false;
  bool hasMore = true;
  int limit = 20;
  int offset = 0;

  double? latitude;
  double? longitude;
  String address = "----";

  int currentStep = 0;

  TextEditingController dateCtrl = TextEditingController();
  TextEditingController locationCtrl = TextEditingController();

  String tripStatus = "All";

  String? selectedYear;
  String? selectedMonth;

  final ScrollController scrollController = ScrollController();
  final LoginController loginCtrl = Get.put(LoginController());

  @override
  void onInit() {
    super.onInit();
    String currentMonthName = monthMap.keys.elementAt(DateTime.now().month - 1);
    selectedMonth = currentMonthName;
    selectedYear = DateTime.now().year.toString();
    Map<String, String> dateFilter = {};
    if (selectedYear != null &&
        selectedMonth != null &&
        loginCtrl.userModel.employeeId != null) {
      dateFilter = getMonthDateRange(int.parse(selectedYear!), selectedMonth!);
      print("From: ${dateFilter['fromDate']}");
      print("To: ${dateFilter['toDate']}");

      fetchTripList(
        company: loginCtrl.userModel.company,
        fromDate: dateFilter['fromDate'],
        toDate: dateFilter['toDate'],
        employeeId: loginCtrl.userModel.employeeId,
        limitStart: offset,
        limitPageLength: limit,
        tripStatus: tripStatus,
      );
    }

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 200 &&
          !isLoading) {
        fetchTripList(
          company: loginCtrl.userModel.company,
          fromDate: dateFilter['fromDate'],
          toDate: dateFilter['toDate'],
          employeeId: loginCtrl.userModel.employeeId,
          limitStart: offset,
          limitPageLength: limit,
          tripStatus: tripStatus,
        );
      } else {
        print("Not triggered");
      }
    });
  }

  void updateCurrentTrip(Trip trip) {
    currentTrip = trip;
    // tripRouteList = currentTrip.routes ?? [];
    update();
  }

  Future<void> initLoadDateLocation() async {
    isFetchLoading = true;
    update();
    String dateTime = calculateTime(null);
    dateCtrl.text = dateTime;
    Position? position = await LocationService().getCurrentPosition();

    if (position != null) {
      latitude = position.latitude;
      longitude = position.longitude;

      double lat = position.latitude;
      double long = position.longitude;
      print(lat + long);
      address = await LocationService().getAddressFromLatLng(lat, long);
      locationCtrl.text = address;
      print("address $address");
      isFetchLoading = false;
      update();
    }
    isFetchLoading = false;
  }

  Future<void> updateLocation() async {
    Position? position = await LocationService().getCurrentPosition();
    if (position != null) {
      latitude = position.latitude;
      longitude = position.longitude;
      double lat = position.latitude;
      double long = position.longitude;
      print(lat + long);
      address = await LocationService().getAddressFromLatLng(lat, long);
      update();
    }
  }

  Future<void> togglePending() async {
    if (tripStatus == "All" || tripStatus == "Completed") {
      tripStatus = "Pending";
    } else if (tripStatus == "Pending") {
      tripStatus = "All";
    }
    await fetchTripListWithFilters();
    update();
  }

  Future<void> toggleCompleted() async {
    if (tripStatus == "All" || tripStatus == "Pending") {
      tripStatus = "Completed";
    } else if (tripStatus == "Completed") {
      tripStatus = "All";
    }
    await fetchTripListWithFilters();
    update();
  }

  Future<void> fetchTripListWithFilters() async {
    String currentMonthName = monthMap.keys.elementAt(DateTime.now().month - 1);
    selectedMonth = currentMonthName;
    selectedYear = DateTime.now().year.toString();
    Map<String, String> dateFilter = {};
    if (selectedYear != null &&
        selectedMonth != null &&
        loginCtrl.userModel.employeeId != null) {
      dateFilter = getMonthDateRange(int.parse(selectedYear!), selectedMonth!);
      print("From: ${dateFilter['fromDate']}");
      print("To: ${dateFilter['toDate']}");

      await fetchTripList(
        company: loginCtrl.userModel.company,
        fromDate: dateFilter['fromDate'],
        toDate: dateFilter['toDate'],
        employeeId: loginCtrl.userModel.employeeId,
        // limitStart: offset,
        // limitPageLength: limit,
        tripStatus: tripStatus,
      );
      update();
    }
  }


  Future<void> fetchTripList({
    String? company,
    String? fromDate,
    String? toDate,
    String? employeeId,
    int limitStart = 0,
    int limitPageLength = 20,
    String? name,
    required String tripStatus,
  }) async {
    if (AuthService.sessionId == null) {
      print("❌ No session found. Please login first.");
      return;
    }

    final url = Uri.parse(
      "http://208.115.124.12:8000/api/method/my_api_app.api_methods.hr_modules_api.get_trip_list",
    );

    final Map<String, dynamic> body = {
      "company": company,
      "from_date": fromDate,
      "to_date": toDate,
      "employee_id": employeeId,
      "limit_start": limitStart,
      "limit_page_length": limitPageLength,
      "status": tripStatus == "All" ? null : tripStatus,
      "name": name,
    };

    try {
      final response = await http.post(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          "Cookie": AuthService.sessionId!, // ✅ ERPNext session cookie
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final tripsJson = data["message"] as List<dynamic>? ?? [];

        if (limitStart == 0) {
          travelLogs.clear();
        }

        travelLogs.addAll(
          tripsJson.map((e) => Trip.fromJson(e)).toList(),
        );

        offset += tripsJson.length;
        hasMore = tripsJson.length == limitPageLength;

        print("✅ Trip List fetched: ${travelLogs.length} trips");
      } else {
        print("❌ Error ${response.statusCode}: ${response.body}");
      }
    } catch (e) {
      print("⚠️ Error fetching trip list: $e");
    }

    isLoading = false;
    update();
  }


  // Future<void> fetchTripList({
  //   String? company,
  //   String? fromDate,
  //   String? toDate,
  //   String? employeeId,
  //   int limitStart = 0,
  //   int limitPageLength = 20,
  //   String? name,
  //   required String tripStatus,
  // }) async {
  //   if (AuthService.sessionId == null) {
  //     print("❌ No session found. Please login first.");
  //     return;
  //   }
  //   final url = Uri.parse("$backendUrl/get_trip_list");
  //
  //   final body = {
  //     'cookie': AuthService.sessionId,
  //     'company': company,
  //     'from_date': fromDate,
  //     'to_date': toDate,
  //     'employee_id': employeeId,
  //     'limit_start': limitStart,
  //     'limit_page_length': limitPageLength,
  //     'status': tripStatus == "All" ? null : tripStatus,
  //     'name': name,
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
  //       travelLogs = [];
  //       final data = jsonDecode(response.body);
  //       print("data $data");
  //       final tripsJson = data['message'] as List<dynamic>? ?? [];
  //
  //       if (limitStart == 0) {
  //         travelLogs.clear();
  //       }
  //
  //       travelLogs.addAll(tripsJson.map((e) => Trip.fromJson(e)).toList());
  //
  //       offset += tripsJson.length;
  //       hasMore = tripsJson.length == limitPageLength;
  //       print("TravelLogs length = ${travelLogs.length} , ${travelLogs}");
  //     } else {
  //       print("❌ Error ${response.statusCode}: ${response.body}");
  //     }
  //   } catch (e) {
  //     print("⚠️ Error: ${e.toString()}");
  //   }
  //   isLoading = false;
  //   update();
  // }

  void onSelectMonth(String value) {
    selectedMonth = value;

    Map<String, String> dateFilter = {};
    if (selectedYear != null &&
        selectedMonth != null &&
        loginCtrl.userModel.employeeId != null) {
      dateFilter = getMonthDateRange(int.parse(selectedYear!), selectedMonth!);
      print("From: ${dateFilter['fromDate']}");
      print("To: ${dateFilter['toDate']}");
    }
    fetchTripList(
      company: loginCtrl.userModel.company,
      fromDate: dateFilter['fromDate'],
      toDate: dateFilter['toDate'],
      employeeId: loginCtrl.userModel.employeeId,
      // limitPageLength: 20,
      // limitStart: 0,
      tripStatus: tripStatus,
    );
    update();
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
      fetchTripList(
        company: loginCtrl.userModel.company,
        fromDate: dateFilter['fromDate'],
        toDate: dateFilter['toDate'],
        employeeId: loginCtrl.userModel.employeeId,
        limitPageLength: 20,
        limitStart: 0,
        tripStatus: tripStatus,
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

  Future<void> saveTripParent({Trip? trip}) async {
    final String finalTime = DateFormat(
      'dd-MM-yyyy HH:mm:ss',
    ).format(DateTime.now());
    final DateFormat inputFormat = DateFormat('dd-MM-yyyy HH:mm:ss');
    final DateTime dateTime = inputFormat.parse(finalTime);
    final DateFormat outputFormat = DateFormat('dd MMM yy hh:mm a');
    String valueDate = outputFormat.format(dateTime);

    Trip tripParent = trip ?? Trip();

    // Create a new Trip if not already existing
    if (tripParent.name == null || tripParent.name!.isEmpty) {
      tripParent = Trip(
        employee: loginCtrl.userModel.employeeId,
        startDate: dateTime.toString(),
        status: "Pending",
        totalDistance: 0,
        company: loginCtrl.userModel.company,
      );
    }

    // Ensure session exists
    if (AuthService.sessionId == null) {
      print("❌ No session found. Please login first.");
      return;
    }

    final url = Uri.parse(
      "$baseUrl/api/method/my_api_app.api_methods.hr_modules_api.save_trip",
    );

    // ✅ IMPORTANT: ERPNext expects only { "data": {...} }
    final Map<String, dynamic> body = {'data': tripParent.toJson()};

    try {
      final response = await http.post(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          'Cookie': AuthService.sessionId!, // ✅ Pass cookie in header, not body
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['message'] != null) {
          final msg = data['message'];
          print("✅ Trip Parent ${msg['status']}: ${msg['name']}");

          // If new trip created, trigger child saving logic
          if (msg['name'] != null && msg['status'] != "updated") {
            if (selectedYear != null &&
                selectedMonth != null &&
                loginCtrl.userModel.employeeId != null) {
              final dateFilter = getMonthDateRange(
                int.parse(selectedYear!),
                selectedMonth!,
              );
              print("From: ${dateFilter['fromDate']}");
              print("To: ${dateFilter['toDate']}");

              await saveTripChild(parentId: msg['name']);
            }
          }
        } else {
          print("⚠️ Unexpected Response: $data");
        }
      } else {
        print("❌ Error ${response.statusCode}: ${response.body}");
      }
    } catch (e) {
      print("⚠️ Exception: $e");
    }

    update();
  }

  // Future<void> saveTripParent({Trip? trip}) async {
  //   final String finalTime = DateFormat(
  //     'dd-MM-yyyy HH:mm:ss',
  //   ).format(DateTime.now());
  //
  //   final DateFormat inputFormat = DateFormat('dd-MM-yyyy HH:mm:ss');
  //   final DateTime dateTime = inputFormat.parse(finalTime);
  //
  //   final DateFormat outputFormat = DateFormat('dd MMM yy hh:mm a');
  //   String valueDate = outputFormat.format(dateTime);
  //   Trip tripParent = trip ?? Trip();
  //
  //   if (tripParent.name == null || tripParent.name == "") {
  //     tripParent = Trip(
  //       employee: loginCtrl.userModel.employeeId,
  //       startDate: dateTime.toString(),
  //       status: "Pending",
  //       totalDistance: 0,
  //       company: loginCtrl.userModel.company,
  //     );
  //   }
  //   if (AuthService.sessionId == null) {
  //     print("❌ No session found. Please login first.");
  //     return;
  //   }
  //
  //   final url = Uri.parse("$backendUrl/save_trip_parent");
  //   final Map<String, dynamic> body = {
  //     'cookie': AuthService.sessionId,
  //     'data': tripParent.toJson(),
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
  //
  //       Map<String, String> dateFilter = {};
  //
  //       if (data['message'] != null) {
  //         print(
  //           "✅ Trip Parent ${data['message']['status']}: ${data['message']['name']}",
  //         );
  //
  //         if (data['message']['name'] != null &&
  //             data['message']['status'] != "updated") {
  //           if (selectedYear != null &&
  //               selectedMonth != null &&
  //               loginCtrl.userModel.employeeId != null) {
  //             dateFilter = getMonthDateRange(
  //               int.parse(selectedYear!),
  //               selectedMonth!,
  //             );
  //             print("From: ${dateFilter['fromDate']}");
  //             print("To: ${dateFilter['toDate']}");
  //
  //             await saveTripChild(parentId: data['message']['name']);
  //
  //             /// to do implement fetchlist();
  //           }
  //         }
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

  // Future<bool> saveTripChild({
  //   String? parentId,
  //   String? childId,
  //   int? sequence,
  // }) async {
  //   final String finalTime = DateFormat(
  //     'dd-MM-yyyy HH:mm:ss',
  //   ).format(DateTime.now());
  //   final DateFormat inputFormat = DateFormat('dd-MM-yyyy HH:mm:ss');
  //   final DateTime dateTime = inputFormat.parse(finalTime);
  //   RoutePoint tripChildRoute = RoutePoint();
  //
  //   if (childId == null || childId == "") {
  //
  //
  //     tripChildRoute = RoutePoint(
  //       parentId: parentId,
  //       address: address,
  //       distanceFromPreviousKm: 0,
  //       latitude: latitude,
  //       longitude: longitude,
  //       sequence: sequence ?? 1,
  //       timestamp: dateTime.toString(),
  //     );
  //   } else {
  //     tripChildRoute = RoutePoint(
  //       id: childId,
  //       parentId: parentId,
  //       address: address,
  //       distanceFromPreviousKm: 0,
  //       latitude: latitude,
  //       longitude: longitude,
  //       sequence: sequence ?? 1,
  //       timestamp: dateTime.toString(),
  //     );
  //   }
  //
  //   final url = Uri.parse("$backendUrl/save_trip_child");
  //   final Map<String, dynamic> body = {
  //     'cookie': AuthService.sessionId,
  //     'data': tripChildRoute.toJson(),
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
  //       if (data['message']['name'] != null) {
  //         Map<String, String> dateFilter = {};
  //         if (selectedYear != null &&
  //             selectedMonth != null &&
  //             loginCtrl.userModel.employeeId != null) {
  //           dateFilter = getMonthDateRange(
  //             int.parse(selectedYear!),
  //             selectedMonth!,
  //           );
  //           print("From: ${dateFilter['fromDate']}");
  //           print("To: ${dateFilter['toDate']}");
  //         }
  //         await fetchTripList(
  //           company: loginCtrl.userModel.company,
  //           fromDate: dateFilter['fromDate'],
  //           toDate: dateFilter['toDate'],
  //           employeeId: loginCtrl.userModel.employeeId,
  //           tripStatus: tripStatus,
  //         );
  //         Trip? trip = travelLogs.firstWhere(
  //           (t) => t.name == parentId,
  //           orElse: () => Trip(),
  //         );
  //         updateCurrentTrip(trip);
  //         return true;
  //       } else {
  //         return false;
  //       }
  //     }
  //   } catch (e) {
  //     print("⚠️ Error: ${e.toString()}");
  //     return false;
  //   }
  //   update();
  //   return false;
  // }

  Future<bool> saveTripChild({
    required String parentId,
    int? sequence,
    String? childId,
  }) async {
    final String finalTime = DateFormat(
      'dd-MM-yyyy HH:mm:ss',
    ).format(DateTime.now());
    final DateFormat inputFormat = DateFormat('dd-MM-yyyy HH:mm:ss');
    final DateTime dateTime = inputFormat.parse(finalTime);

    RoutePoint tripChildRoute;

    // 🧭 Ensure mandatory ERPNext parent linkage
    const String parentType = "Employee Trip";

    if (childId == null || childId.isEmpty) {
      tripChildRoute = RoutePoint(
        parentId: parentId,
        // parentType: parentType, // ✅ Required field
        address: address,
        distanceFromPreviousKm: 0,
        latitude: latitude,
        longitude: longitude,
        sequence: sequence ?? 1,
        timestamp: dateTime.toString(),
      );
    } else {
      tripChildRoute = RoutePoint(
        id: childId,
        parentId: parentId,

        // parentType: parentType,
        address: address,
        distanceFromPreviousKm: 0,
        latitude: latitude,
        longitude: longitude,
        sequence: sequence ?? 1,
        timestamp: dateTime.toString(),
      );
    }

    // ✅ Whitelisted ERPNext method URL
    final url = Uri.parse(
      "$baseUrl/api/method/my_api_app.api_methods.hr_modules_api.save_trip_route",
    );

    // ✅ Only send "data" — do NOT include cookie in body
    final Map<String, dynamic> body = {'data': tripChildRoute.toJson()};

    try {
      final response = await http.post(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          'Cookie': AuthService.sessionId!, // ✅ Pass session cookie here
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['message']?['name'] != null) {
          print(
            "✅ Trip Child ${data['message']['status']}: ${data['message']['name']}",
          );

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
          }

          await fetchTripList(
            company: loginCtrl.userModel.company,
            fromDate: dateFilter['fromDate'],
            toDate: dateFilter['toDate'],
            employeeId: loginCtrl.userModel.employeeId,
            tripStatus: tripStatus,
          );

          Trip? trip = travelLogs.firstWhere(
            (t) => t.name == parentId,
            orElse: () => Trip(),
          );
          updateCurrentTrip(trip);

          return true;
        } else {
          print("⚠️ Unexpected response: $data");
          return false;
        }
      } else {
        print("❌ Server Error ${response.statusCode}: ${response.body}");
        return false;
      }
    } catch (e) {
      print("⚠️ Exception: $e");
      return false;
    }
  }

  Future<void> refreshItems() async {
    offset = 0;
    hasMore = true;
    travelLogs.clear();
    update();
    await fetchTripList(tripStatus: tripStatus);
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
