import 'package:flatten/controllers/my_controller.dart';
import 'package:flatten/models/discover.dart';
import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

class ChartData {
  ChartData(this.y, this.x);

  final double? y;
  final String x;
}

class DiscoverController extends MyController {
  List<Discover> discover = [];
  String selectExperience = "Beginner";
  String selectLocation = "Mumbai";
  String selectTime = "Year";

  List<bool> selected = List.filled(4, false);

  DiscoverController() {
    selected[0] = true;
  }

  void onSelected(int index) {
    selected = List.filled(4, false);
    selected[index] = true;
    update();
  }

  bool isFullTime = false;
  bool isPartTime = false;
  bool isMobile = false;
  bool isContract = false;

  RangeValues rangeSlider = RangeValues(10000, 120000);

  void onChangeRangeSlider(RangeValues value) {
    rangeSlider = value;
    update();
  }

  void onSelectedExperience(String experience) {
    selectExperience = experience;
    update();
  }

  void onSelectedLocation(String location) {
    selectLocation = location;
    update();
  }

  void onSelectedTime(String time) {
    selectTime = time;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    Discover.dummyList.then((value) {
      discover = value;
      update();
    });
  }

  final TooltipBehavior tooltipBehavior = TooltipBehavior(
    enable: true,
    textAlignment: ChartAlignment.center,
    header: '',
    canShowMarker: true,
  );
  final List<ChartData> chartData = <ChartData>[
    ChartData(50, 'Jan'),
    ChartData(20, 'Feb'),
    ChartData(15, 'Mar'),
    ChartData(45, 'Apr'),
    ChartData(35, 'May'),
    ChartData(12, 'Jun'),
    ChartData(13, 'Jul'),
    ChartData(11, 'Aug'),
    ChartData(38, 'Sep'),
    ChartData(35, 'Oct'),
    ChartData(48, 'Nov'),
    ChartData(26, 'Dec'),
  ];
}
