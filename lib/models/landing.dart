import 'dart:convert';

import 'package:flatten/models/identifier_model.dart';
import 'package:flatten/helpers/services/json_decoder.dart';
import 'package:flutter/services.dart';

class Landing extends IdentifierModel {
  final String title;

  Landing(super.id, this.title);

  static Landing fromJSON(Map<String, dynamic> json) {
    JSONDecoder decoder = JSONDecoder(json);

    String title = decoder.getString('title');

    return Landing(decoder.getId, title);
  }

  static List<Landing> listFromJSON(List<dynamic> list) {
    return list.map((e) => Landing.fromJSON(e)).toList();
  }

  static List<Landing>? _dummyList;

  static Future<List<Landing>> get dummyList async {
    if (_dummyList == null) {
      dynamic data = json.decode(await getData());
      _dummyList = listFromJSON(data);
    }

    return _dummyList!.sublist(0, 5);
  }

  static Future<String> getData() async {
    return await rootBundle.loadString('assets/data/landing_data.json');
  }
}
