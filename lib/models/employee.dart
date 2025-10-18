import 'dart:convert';

import 'package:flatten/helpers/services/json_decoder.dart';
import 'package:flatten/models/identifier_model.dart';
import 'package:flutter/services.dart';

class EmployeeModel extends IdentifierModel {
  String? name, designation, phoneNumber;
  double? experience;
  DateTime? joiningDate;

  EmployeeModel(super.id, this.name, this.designation, this.phoneNumber,
      this.experience, this.joiningDate);

  static EmployeeModel fromJSON(Map<String, dynamic> json) {
    JSONDecoder decoder = JSONDecoder(json);
    String name = decoder.getString('name');
    String designation = decoder.getString('designation');

    String phoneNumber = decoder.getString('phone_number');
  
    double experience = decoder.getDouble('experience');
    DateTime joiningDate = decoder.getDateTime('joiningDate');
    return EmployeeModel(
        decoder.getId, name, designation, phoneNumber, experience, joiningDate);
  }

  static List<EmployeeModel> listFromJSON(List<dynamic> list) {
    return list.map((e) => EmployeeModel.fromJSON(e)).toList();
  }

  static List<EmployeeModel>? _dummyList;

  static Future<List<EmployeeModel>> get dummyList async {
    if (_dummyList == null) {
      dynamic data = json.decode(await getData());
      _dummyList = listFromJSON(data);
    }

    return _dummyList!;
  }

  static Future<String> getData() async {
    return await rootBundle.loadString('assets/data/employee_data.json');
  }
}

enum Designation {
  angular,
  react,
  javaScript,
  teamLeader,
  vueJS,
  nodeJS,
  webDesign;

  const Designation();
}
