import 'dart:convert';

import 'package:flatten/helpers/services/json_decoder.dart';
import 'package:flatten/models/identifier_model.dart';
import 'package:flutter/services.dart';

class TaskListModel extends IdentifierModel {
  final String title, description, priority, status;
  final DateTime dueDate;
  late bool isSelectTask;

  TaskListModel(super.id, this.title, this.description, this.priority, this.status, this.dueDate, this.isSelectTask);

  static TaskListModel fromJSON(Map<String, dynamic> json) {
    JSONDecoder decoder = JSONDecoder(json);

    String title = decoder.getString('title');
    String description = decoder.getString('description');
    String priority = decoder.getString('priority');
    String status = decoder.getString('status');
    DateTime dueDate = decoder.getDateTime('due_date');
    bool isSelectTask = decoder.getBool('isSelectTask');

    return TaskListModel(decoder.getId, title, description, priority, status, dueDate, isSelectTask);
  }

  static List<TaskListModel> listFromJSON(List<dynamic> list) {
    return list.map((e) => TaskListModel.fromJSON(e)).toList();
  }

  static List<TaskListModel>? _dummyList;

  static Future<List<TaskListModel>> get dummyList async {
    if (_dummyList == null) {
      dynamic data = json.decode(await getData());
      _dummyList = listFromJSON(data);
    }

    return _dummyList!;
  }

  static Future<String> getData() async {
    return await rootBundle.loadString('assets/data/task_list.json');
  }
}
