import 'dart:convert';

import 'package:flatten/helpers/services/json_decoder.dart';
import 'package:flatten/models/identifier_model.dart';
import 'package:flutter/services.dart';

class ProjectSummaryModel extends IdentifierModel {
  final String title, assignTo, priority, status;
  final DateTime date;

  ProjectSummaryModel(
    super.id,
    this.title,
    this.assignTo,
    this.priority,
    this.status,
    this.date,
  );

  static ProjectSummaryModel fromJSON(Map<String, dynamic> json) {
    JSONDecoder decoder = JSONDecoder(json);

    String title = decoder.getString('title');
    String assignTo = decoder.getString('assign_to');
    String priority = decoder.getString('priority');
    String status = decoder.getString('status');
    DateTime date = decoder.getDateTime('date');

    return ProjectSummaryModel(decoder.getId, title, assignTo, priority, status, date);
  }

  static List<ProjectSummaryModel> listFromJSON(List<dynamic> list) {
    return list.map((e) => ProjectSummaryModel.fromJSON(e)).toList();
  }

  static List<ProjectSummaryModel>? _dummyList;

  static Future<List<ProjectSummaryModel>> get dummyList async {
    if (_dummyList == null) {
      dynamic data = json.decode(await getData());
      _dummyList = listFromJSON(data);
    }

    return _dummyList!;
  }

  static Future<String> getData() async {
    return await rootBundle.loadString('assets/data/project_summary.json');
  }
}
