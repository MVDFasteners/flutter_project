import 'dart:convert';

import 'package:flatten/images.dart';
import 'package:flatten/models/identifier_model.dart';
import 'package:flatten/helpers/services/json_decoder.dart';
import 'package:flutter/services.dart';

class JobVacancee extends IdentifierModel {
  final String companyName, appName, location, image;
  final int years, amount;
  final double progress;

  JobVacancee(
    super.id,
    this.companyName,
    this.appName,
    this.location,
    this.image,
    this.years,
    this.amount,
    this.progress,
  );

  static JobVacancee fromJSON(Map<String, dynamic> json) {
    JSONDecoder decoder = JSONDecoder(json);

    String companyName = decoder.getString('company_name');
    String appName = decoder.getString('app_name');
    String location = decoder.getString('location');
    String image = Images.randomImage(Images.avatars);
    int years = decoder.getInt('years');
    int amount = decoder.getInt('amount');
    double progress = decoder.getDouble('progress');

    return JobVacancee(
      decoder.getId,
      companyName,
      appName,
      location,
      image,
      years,
      amount,
      progress,
    );
  }

  static List<JobVacancee> listFromJSON(List<dynamic> list) {
    return list.map((e) => JobVacancee.fromJSON(e)).toList();
  }

  static List<JobVacancee>? _dummyList;

  static Future<List<JobVacancee>> get dummyList async {
    if (_dummyList == null) {
      dynamic data = json.decode(await getData());
      _dummyList = listFromJSON(data);
    }

    return _dummyList!.sublist(0, 14);
  }

  static Future<String> getData() async {
    return await rootBundle.loadString('assets/data/job_vacancee.json');
  }
}
