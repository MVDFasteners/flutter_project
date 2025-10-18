import 'dart:convert';
import 'dart:io';
import 'package:flatten/helpers/services/auth_service.dart';
import 'package:flatten/models/trip_list.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flatten/app_constant.dart';

class TripListController extends GetxController {
  List<Trip> travelLogs = [];
  bool isLoading = false;
  bool hasMore = true;
  int limit = 20;
  int offset = 0;

  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    fetchTripList();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 200 &&
          !isLoading) {
        fetchTripList();
      }
    });
  }

  Future<void> fetchTripList({
    String? company,
    String? fromDate,
    String? toDate,
    String? employeeId,
    int limitStart = 0,
    int limitPageLength = 20,
  }) async {
    if (AuthService.sessionId == null) {
      print("❌ No session found. Please login first.");
      return;
    }
    final url = Uri.parse("$backendUrl/get_trip_list");
    final body = {
      'cookie': AuthService.sessionId,
      'company': company,
      'from_date': fromDate,
      'to_date': toDate,
      'employee_id': employeeId,
      'limit_start': limitStart,
      'limit_page_length': limitPageLength,
    };

    try {
      final response = await http.post(
        url,
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        travelLogs = [];
        final data = jsonDecode(response.body);
        print("data $data");
        final tripsJson = data['message'] as List<dynamic>? ?? [];
        travelLogs.addAll(tripsJson.map((e) => Trip.fromJson(e)).toList());

        print("travelLogs length = ${travelLogs.length} , ${travelLogs}");
        isLoading = false;
        update();
      } else {
        print("❌ Error ${response.statusCode}: ${response.body}");
      }
    } catch (e) {
      print("⚠️ Error: ${e.toString()}");
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
