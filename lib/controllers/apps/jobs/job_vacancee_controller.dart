import 'package:flatten/controllers/my_controller.dart';
import 'package:flatten/models/job_vacancee.dart';
import 'package:flutter/material.dart';

class JobType {
  String name;
  bool isChecked;

  JobType(this.name, {this.isChecked = false});
}

class JobCategories {
  String name;
  bool isChecked;

  JobCategories(this.name, {this.isChecked = false});
}

class JobExperience {
  String name;
  bool isChecked;

  JobExperience(this.name, {this.isChecked = false});
}

class JobVacanceeController extends MyController {
  List<JobVacancee> jobVacancee = [];

  final List<JobType> jobType = [
    JobType('Full-time'),
    JobType('InternShip'),
    JobType('Part-Time'),
    JobType('Freelancer'),
  ];

  final List<JobCategories> jobCategories = [
    JobCategories("Business Development / Sales"),
    JobCategories("Marketing"),
    JobCategories("Software Engineering"),
    JobCategories("Finance"),
  ];

  final List<JobExperience> jobExperience = [
    JobExperience("Beginner"),
    JobExperience("Intermediate"),
    JobExperience("Expert"),
  ];

  @override
  void onInit() {
    super.onInit();
    JobVacancee.dummyList.then((value) {
      jobVacancee = value;
      update();
    });
  }

  bool sticky = false, isSwitch = false;
  RangeValues rangeSlider = RangeValues(20, 40);

  void onChangeRangeSlider(RangeValues value) {
    rangeSlider = value;
    update();
  }

  void onChangeSticky(bool? value) {
    if (value != null) {
      sticky = value;
      update();
    }
  }
}
