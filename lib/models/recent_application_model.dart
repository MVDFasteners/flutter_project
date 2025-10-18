import 'dart:convert';
import 'package:flatten/helpers/services/json_decoder.dart';
import 'package:flatten/models/identifier_model.dart';
import 'package:flutter/services.dart';

class JobRecentApplicationModel extends IdentifierModel {
  final String candidate, category, designation, mail, location, type;
  final DateTime date;

  JobRecentApplicationModel(super.id, this.candidate, this.category, this.designation, this.mail, this.location, this.type, this.date);

  static JobRecentApplicationModel fromJSON(Map<String, dynamic> json) {
    JSONDecoder decoder = JSONDecoder(json);

    String candidate = decoder.getString('candidate');
    String category = decoder.getString('category');
    String designation = decoder.getString('designation');
    String mail = decoder.getString('mail');
    String location = decoder.getString('location');
    String type = decoder.getString('type');
    DateTime date = decoder.getDateTime('date');

    return JobRecentApplicationModel(decoder.getId, candidate, category, designation, mail, location, type, date);
  }

  static List<JobRecentApplicationModel> listFromJSON(List<dynamic> list) {
    return list.map((e) => JobRecentApplicationModel.fromJSON(e)).toList();
  }

  static List<JobRecentApplicationModel>? _dummyList;

  static Future<List<JobRecentApplicationModel>> get dummyList async {
    if (_dummyList == null) {
      dynamic data = json.decode(await getData());
      _dummyList = listFromJSON(data);
    }

    return _dummyList!;
  }

  static Future<String> getData() async {
    return await rootBundle.loadString('assets/data/job_recent_application.json');
  }
}
