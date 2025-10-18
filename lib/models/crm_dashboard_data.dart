import 'dart:convert';

import 'package:flatten/helpers/services/json_decoder.dart';
import 'package:flatten/models/identifier_model.dart';
import 'package:flutter/services.dart';

class CrmDashboardData extends IdentifierModel {
  final int number, orderId, totalAmount;
  final String productName, customerName, status;
  final DateTime orderDate;

  CrmDashboardData(super.id, this.number, this.orderId, this.totalAmount,
      this.productName, this.customerName, this.status, this.orderDate);

  static CrmDashboardData fromJSON(Map<String, dynamic> json) {
    JSONDecoder decoder = JSONDecoder(json);

    int number = decoder.getInt('number');
    int orderId = decoder.getInt('order_id');
    int totalAmount = decoder.getInt('total_amount');
    String productName = decoder.getString('product_name');
    String customerName = decoder.getString('customer');
    String status = decoder.getString('status');
    DateTime orderDate = decoder.getDateTime('order_date');

    return CrmDashboardData(decoder.getId, number, orderId, totalAmount,
        productName, customerName, status, orderDate);
  }

  static List<CrmDashboardData> listFromJSON(List<dynamic> list) {
    return list.map((e) => CrmDashboardData.fromJSON(e)).toList();
  }

  static List<CrmDashboardData>? _dummyList;

  static Future<List<CrmDashboardData>> get dummyList async {
    if (_dummyList == null) {
      dynamic data = json.decode(await getData());
      _dummyList = listFromJSON(data);
    }

    return _dummyList!.sublist(0, 5);
  }

  static Future<String> getData() async {
    return await rootBundle.loadString('assets/data/crm_dashboard.json');
  }
}
