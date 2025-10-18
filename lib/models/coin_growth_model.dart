import 'dart:convert';

import 'package:flatten/helpers/services/json_decoder.dart';
import 'package:flatten/models/identifier_model.dart';
import 'package:flutter/services.dart';

class CoinGrowthModel extends IdentifierModel {
  final String asset, ipAddress, status;
  final int amount;
  final DateTime date;

  CoinGrowthModel(
    super.id,
    this.asset,
    this.ipAddress,
    this.status,
    this.amount,
    this.date,
  );

  static CoinGrowthModel fromJSON(Map<String, dynamic> json) {
    JSONDecoder decoder = JSONDecoder(json);

    String asset = decoder.getString('asset');
    String ipAddress = decoder.getString('ip_address');
    String status = decoder.getString('status');
    int amount = decoder.getInt('amount');
    DateTime date = decoder.getDateTime('date');

    return CoinGrowthModel(decoder.getId, asset, ipAddress, status, amount, date);
  }

  static List<CoinGrowthModel> listFromJSON(List<dynamic> list) {
    return list.map((e) => CoinGrowthModel.fromJSON(e)).toList();
  }

  static List<CoinGrowthModel>? _dummyList;

  static Future<List<CoinGrowthModel>> get dummyList async {
    if (_dummyList == null) {
      dynamic data = json.decode(await getData());
      _dummyList = listFromJSON(data);
    }

    return _dummyList!;
  }

  static Future<String> getData() async {
    return await rootBundle.loadString('assets/data/coin_growth.json');
  }
}
