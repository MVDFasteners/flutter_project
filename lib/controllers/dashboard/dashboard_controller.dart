import 'dart:convert';
import 'dart:io';

import 'package:flatten/app_constant.dart';
import 'package:flatten/controllers/auth/login_controller.dart';
import 'package:flatten/controllers/my_controller.dart';
import 'package:flatten/controllers/other/syncfusion_charts_controller.dart';
import 'package:flatten/helpers/extensions/extensions.dart';
import 'package:flatten/helpers/services/auth_service.dart';
import 'package:flatten/helpers/theme/app_style.dart';
import 'package:flatten/models/customer.dart';
import 'package:flatten/models/product.dart';
import 'package:flatten/models/sales_team_summary.dart';
import 'package:flatten/models/sales_yearly_summary.dart';
import 'package:flatten/models/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardController extends MyController {
  DashboardController();

  final LoginController loginCtrl = Get.put(LoginController());
  List<Product> products = [];
  List<Customer> customers = [];
  String salesYearlySummary = "2025-2026";
  TooltipBehavior? tooltipBehavior;

  SalesSummaryYearly salesSummaryYearly = SalesSummaryYearly();
  SalesTeamSummary salesTeamSummary = SalesTeamSummary();

  UserModel userModel = UserModel();

  double? salesValue;
  double? purchaseValue;
  double? paymentReceivedValue;
  double? paymentPaidValue;

  List<String> companyList = [];
  String currentCompany = "MVD FASTENERS PRIVATE LIMITED";

  DateTime now = DateTime(2023, 9);

  Future<void> onSelectYearlySummary(String? value) async {
    if (value != null) {
      salesYearlySummary = value;
      String year = value.split(RegExp(r'[-=]')).first;
      int? intYear = year.toInt();
      print(year);

      if (intYear != null) {
        await fetchSalesSummaryYearly(company: currentCompany, year: intYear);
        update();
      }
    }
  }

  Future<void> onSelectYearlyTeamSummary(DateTimeRange<DateTime>? value) async {
    if (value != null) {
      String fromDate = value.start.toString();
      String endDate = value.end.toString();
      print("$fromDate - $endDate");
      // 2025-10-01

      await fetchSalesTeamSummary(
        company: currentCompany,
        fromDate: fromDate,
        toDate: endDate,
      );
      // update();
    }
  }

  List<ColumnSeries<ChartSampleData, String>> getDefaultColumnSeries() {
    return <ColumnSeries<ChartSampleData, String>>[
      ColumnSeries<ChartSampleData, String>(
        dataSource: <ChartSampleData>[...erpnextDataChart()],
        xValueMapper: (ChartSampleData sales, _) => sales.x as String,
        yValueMapper: (ChartSampleData sales, _) => sales.y,
        color: theme.colorScheme.primary,
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
        markerSettings: MarkerSettings(isVisible: true),
        dataLabelSettings: DataLabelSettings(
          isVisible: true,
          textStyle: TextStyle(fontSize: 10),
        ),
      ),
    ];
  }

  List<ChartSampleData> erpnextDataChart() {
    final List<ChartSampleData> chartData = [];

    if (salesSummaryYearly.months != null &&
        salesSummaryYearly.values != null &&
        salesSummaryYearly.months!.length ==
            salesSummaryYearly.values!.length) {
      for (int i = 0; i < salesSummaryYearly.months!.length; i++) {
        chartData.add(
          ChartSampleData(
            x: salesSummaryYearly.months![i],
            y: salesSummaryYearly.values![i],
          ),
        );
      }
    }
    return chartData;
  }

  //Data
  late final List<ChartSampleData> revenueChartData = <ChartSampleData>[
    ChartSampleData(
      x: now.subtract(Duration(days: 30 * 6)),
      y: 20,
      secondSeriesYValue: 24,
    ),
    ChartSampleData(
      x: now.subtract(Duration(days: 30 * 5)),
      y: 24,
      secondSeriesYValue: 28,
    ),
    ChartSampleData(
      x: now.subtract(Duration(days: 30 * 4)),
      y: 22,
      secondSeriesYValue: 26,
    ),
    ChartSampleData(
      x: now.subtract(Duration(days: 30 * 3)),
      y: 28,
      secondSeriesYValue: 32,
    ),
    ChartSampleData(
      x: now.subtract(Duration(days: 30 * 2)),
      y: 26,
      secondSeriesYValue: 30,
    ),
    ChartSampleData(
      x: now.subtract(Duration(days: 30 * 1)),
      y: 30,
      secondSeriesYValue: 34,
    ),
  ];

  late final List<ChartSampleData> comparisonChartData = <ChartSampleData>[
    ChartSampleData(
      x: now.subtract(Duration(days: 1 * 6)),
      y: 20,
      secondSeriesYValue: 24,
    ),
    ChartSampleData(
      x: now.subtract(Duration(days: 1 * 5)),
      y: 24,
      secondSeriesYValue: 28,
    ),
    ChartSampleData(
      x: now.subtract(Duration(days: 1 * 4)),
      y: 28,
      secondSeriesYValue: 24,
    ),
    ChartSampleData(
      x: now.subtract(Duration(days: 1 * 3)),
      y: 26,
      secondSeriesYValue: 32,
    ),
    ChartSampleData(
      x: now.subtract(Duration(days: 1 * 2)),
      y: 30,
      secondSeriesYValue: 26,
    ),
    ChartSampleData(
      x: now.subtract(Duration(days: 1 * 1)),
      y: 28,
      secondSeriesYValue: 32,
    ),
  ];

  @override
  void onInit() {
    super.onInit();

    DateTime todayDateTime = DateTime.now();
    String today = DateFormat('yyyy-MM-dd').format(todayDateTime);

    if (loginCtrl.userModel.userId != null) {}

    DateTime firstDayOfMonthTime = DateTime(
      todayDateTime.year,
      todayDateTime.month,
      1,
    );

    String firstDayOfMonth = DateFormat(
      'yyyy-MM-dd',
    ).format(firstDayOfMonthTime);

    int currentYear = DateTime.now().year;
    print("today$today");

    print("firstDayOfMonth$firstDayOfMonth");

    print("currentYear$currentYear");
    _fetchUser();
    fetchCompanyList();

    fetchSalesValue(
      company: currentCompany,
      fromDate: today.toString(),
      toDate: firstDayOfMonth.toString(),
    );
    fetchPurchaseValue(
      company: currentCompany,
      fromDate: today.toString(),
      toDate: firstDayOfMonth.toString(),
    );
    fetchPaymentValue(
      company: currentCompany,
      fromDate: today.toString(),
      toDate: firstDayOfMonth.toString(),
    );
    fetchSalesSummaryYearly(company: currentCompany, year: currentYear);

    fetchSalesTeamSummary(
      company: currentCompany,
      fromDate: "2025-01-01",
      // today.toString(),
      toDate: "2025-10-13",
      // firstDayOfMonth.toString(),
    );

    // Product.dummyList.then((value) {
    //   products = value.sublist(0, 5);
    //   update();
    // });
    //
    // Customer.dummyList.then((value) {
    //   customers = value.sublist(0, 5);
    //   update();
    // });
    
    tooltipBehavior = TooltipBehavior(
      enable: true,
      tooltipPosition: TooltipPosition.pointer,
    );
  }

  Future<void> _fetchUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? userId = pref.getString("email");
    if (userId != null) {
      loginCtrl.fetchUserByEmail(userId);
    }
  }

  Future<void> fetchSalesTeamSummary({
    String? company,
    String? fromDate,
    String? toDate,
  }) async {
    if (AuthService.sessionId == null) {
      print("❌ No session found. Please login first.");
      return;
    }

    final url = Uri.parse("$backendUrl/sales_team_summary");

    final Map<String, dynamic> body = {
      'cookie': AuthService.sessionId,
      'company': company,
      'from_date': fromDate,
      'to_date': toDate,
    };

    try {
      final response = await http.post(
        url,
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data['message']);
        salesTeamSummary = SalesTeamSummary.fromJson(data['message']);
        update();
      } else {
        print("❌ Error ${response.statusCode}: ${response.body}");
      }
    } catch (e) {
      print("⚠️ Error: ${e.toString()}");
    }
  }

  Future<void> fetchSalesSummaryYearly({
    String? company = "MVD FASTENERS PRIVATE LIMITED",
    int? year, // Example: 2024 for FY 2024–2025
  }) async {
    if (AuthService.sessionId == null) {
      print("❌ No session found. Please login first.");
      return;
    }
    final url = Uri.parse("$backendUrl/sales_summary_year");
    final Map<String, dynamic> body = {'cookie': AuthService.sessionId};
    if (company != null) body['company'] = company;
    if (year != null) body['year'] = year;

    try {
      final response = await http.post(
        url,
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        salesSummaryYearly = SalesSummaryYearly.fromJson(data['message']);
        print("✅ Yearly Summary Loaded: ${salesSummaryYearly.year}");
        print("Months: ${salesSummaryYearly.months}");
        print("Values: ${salesSummaryYearly.values}");
        update();
      } else {
        print("❌ Error ${response.statusCode}: ${response.body}");
      }
    } catch (e) {
      print("⚠️ Error: ${e.toString()}");
    }
  }

  Future<void> fetchSalesValue({
    String? company,
    String? fromDate,
    String? toDate,
  }) async {
    if (AuthService.sessionId == null) {
      print("❌ No session found. Please login first.");
      return;
    }

    final url = Uri.parse("$backendUrl/sales_value");

    final Map<String, dynamic> body = {'cookie': AuthService.sessionId};
    if (company != null) body['company'] = company;
    if (fromDate != null) body['from_date'] = fromDate;
    if (toDate != null) body['to_date'] = toDate;

    try {
      final response = await http.post(
        url,
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        salesValue = data['message']['total_billed'];
        update();
        print("✅ Sales Value: $salesValue");
      } else {
        print("❌ Error ${response.statusCode}: ${response.body}");
      }
    } on SocketException {
      print("⚠️ Connection Error: Cannot reach backend ($backendUrl)");
    } catch (e) {
      print("⚠️ Unexpected Error: ${e.toString()}");
    }
  }

  Future<void> fetchPurchaseValue({
    String? company,
    String? fromDate,
    String? toDate,
  }) async {
    if (AuthService.sessionId == null) {
      print("❌ No session found. Please login first.");
    }
    final url = Uri.parse("$backendUrl/purchase_value");

    final Map<String, dynamic> body = {'cookie': AuthService.sessionId};
    if (company != null) body['company'] = company;
    if (fromDate != null) body['from_date'] = fromDate;
    if (toDate != null) body['to_date'] = toDate;

    try {
      final response = await http.post(
        url,
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        purchaseValue = data['message']['total_billed'];
        update();
        print("salesValue$purchaseValue");
      }
    } on SocketException {
      print("⚠️ Connection Error: Cannot reach backend ($backendUrl)");
    } catch (e) {
      print("⚠️ Unexpected Error: ${e.toString()}");
    }
  }

  Future<void> fetchPaymentValue({
    String? company,
    String? fromDate,
    String? toDate,
  }) async {
    if (AuthService.sessionId == null) {
      print("❌ No session found. Please login first.");
    }
    final url = Uri.parse("$backendUrl/payment_value");

    final Map<String, dynamic> body = {'cookie': AuthService.sessionId};
    if (company != null) body['company'] = company;
    if (fromDate != null) body['from_date'] = fromDate;
    if (toDate != null) body['to_date'] = toDate;

    try {
      final response = await http.post(
        url,
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        paymentReceivedValue = data['message']['total_received'];
        paymentPaidValue = data['message']['total_paid'];
        update();
        print("payment vlaue$paymentPaidValue");
      }
    } on SocketException {
      print("⚠️ Connection Error: Cannot reach backend ($backendUrl)");
    } catch (e) {
      print("⚠️ Unexpected Error: ${e.toString()}");
    }
  }

  Future<void> fetchCompanyList() async {
    if (AuthService.sessionId == null) {
      print("❌ No session found. Please login first.");
    }
    final url = Uri.parse("$backendUrl/company_list");
    try {
      final response = await http.post(
        url,
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: jsonEncode({'cookie': AuthService.sessionId}),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        companyList = (data['message']['companies'] as List)
            .map((item) => item['name'] as String)
            .toList();
        print(companyList);
        update();
      }
    } on SocketException {
      print("⚠️ Connection Error: Cannot reach backend ($backendUrl)");
    } catch (e) {
      print("⚠️ Unexpected Error: ${e.toString()}");
    }
  }

  void onChangeDropDown(String? value) {
    if (value != null) {
      currentCompany = value;
      fetchPurchaseValue(
        company: value,
        fromDate: "2025.01.01",
        toDate: "2025.10.1",
      );
      fetchSalesValue(
        company: value,
        fromDate: "2025.01.01",
        toDate: "2025.10.1",
      );
      fetchPaymentValue(
        company: value,
        fromDate: "2025.01.01",
        toDate: "2025.10.1",
      );
      fetchSalesTeamSummary(
        company: value,
        fromDate: "2025.01.01",
        toDate: "2025.10.1",
      );
      update();
    }
  }

  Future<void> fetchUserByEmail(String email) async {
    if (AuthService.sessionId == null) {
      print("❌ No session found. Please login first.");
      return;
    }

    final url = Uri.parse("$backendUrl/get_user");
    final Map<String, dynamic> body = {
      'cookie': AuthService.sessionId,
      'email': email,
    };

    try {
      final response = await http.post(
        url,
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data.containsKey('error')) {
          print("❌ Error: ${data['error']}");
          return;
        }
        userModel = UserModel.fromJson(data);
        print(
          "User fetched: ${userModel!.fullName}, ${userModel!.department}, ${userModel!.company}, ${userModel!.image}",
        );
        update(); // if inside GetX controller
      } else {
        print("❌ HTTP Error ${response.statusCode}: ${response.body}");
      }
    } on SocketException {
      print("⚠️ Connection Error: Cannot reach backend ($backendUrl)");
    } catch (e) {
      print("⚠️ Unexpected Error: ${e.toString()}");
    }
  }

  void goToProducts() {
    Get.toNamed('/apps/ecommerce/products');
  }

  void goToCustomers() {
    Get.toNamed('/apps/ecommerce/customers');
  }
}
