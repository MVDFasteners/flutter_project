import 'package:flatten/controllers/my_controller.dart';
import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

class ChartSampleData {
  ChartSampleData(
      {this.x,
      this.y,
      this.xValue,
      this.yValue,
      this.secondSeriesYValue,
      this.thirdSeriesYValue,
      this.pointColor,
      this.size,
      this.text,
      this.open,
      this.close,
      this.low,
      this.high,
      this.volume});

  final dynamic x;
  final num? y;
  final dynamic xValue;
  final num? yValue;
  final num? secondSeriesYValue;
  final num? thirdSeriesYValue;
  final Color? pointColor;
  final num? size;
  final String? text;
  final num? open;
  final num? close;
  final num? low;
  final num? high;
  final num? volume;
}

class SyncfusionChartsController extends MyController {
  final TooltipBehavior tooltipBehavior = TooltipBehavior(
      enable: true,
      textAlignment: ChartAlignment.center,
      header: '',
      canShowMarker: false,
      format:
          'point.x\nLiteracy rate : point.x%\nGDP growth rate : point.y\nPopulation : point.sizeB');

  final TooltipBehavior radialTooltipBehavior =
      TooltipBehavior(enable: true, format: 'point.x : point.ym');

  //Data
  final List<ChartSampleData> areaChartData = <ChartSampleData>[
    ChartSampleData(x: DateTime(2000, 1, 1), y: 4, secondSeriesYValue: 2.6),
    ChartSampleData(x: DateTime(2001, 1, 1), y: 3.0, secondSeriesYValue: 2.8),
    ChartSampleData(x: DateTime(2002, 1, 1), y: 3.8, secondSeriesYValue: 2.6),
    ChartSampleData(x: DateTime(2003, 1, 1), y: 3.4, secondSeriesYValue: 3),
    ChartSampleData(x: DateTime(2004, 1, 1), y: 3.2, secondSeriesYValue: 3.6),
    ChartSampleData(x: DateTime(2005, 1, 1), y: 3.9, secondSeriesYValue: 3),
  ];

  final List<ChartSampleData> barChartData = <ChartSampleData>[
    ChartSampleData(
        x: 'France',
        y: 84452000,
        secondSeriesYValue: 82682000,
        thirdSeriesYValue: 86861000),
    ChartSampleData(
        x: 'Spain',
        y: 68175000,
        secondSeriesYValue: 75315000,
        thirdSeriesYValue: 81786000),
    ChartSampleData(
        x: 'US',
        y: 77774000,
        secondSeriesYValue: 76407000,
        thirdSeriesYValue: 76941000),
    ChartSampleData(
        x: 'Italy',
        y: 50732000,
        secondSeriesYValue: 52372000,
        thirdSeriesYValue: 58253000),
    ChartSampleData(
        x: 'Mexico',
        y: 32093000,
        secondSeriesYValue: 35079000,
        thirdSeriesYValue: 39291000),
    ChartSampleData(
        x: 'UK',
        y: 34436000,
        secondSeriesYValue: 35814000,
        thirdSeriesYValue: 37651000),
  ];

  final List<ChartSampleData> bubbleChartData = <ChartSampleData>[
    ChartSampleData(x: 'China', xValue: 92.2, y: 7.8, size: 1.347),
    ChartSampleData(x: 'India', xValue: 74, y: 6.5, size: 1.241),
    ChartSampleData(x: 'Indonesia', xValue: 90.4, y: 6.0, size: 0.238),
    ChartSampleData(x: 'US', xValue: 99.4, y: 2.2, size: 0.312),
    ChartSampleData(x: 'Germany', xValue: 99, y: 0.7, size: 0.0818),
    ChartSampleData(x: 'Egypt', xValue: 72, y: 2.0, size: 0.0826),
    ChartSampleData(x: 'Russia', xValue: 99.6, y: 3.4, size: 0.143),
    ChartSampleData(x: 'Japan', xValue: 99, y: 0.2, size: 0.128),
    ChartSampleData(x: 'Mexico', xValue: 86.1, y: 4.0, size: 0.115),
    ChartSampleData(x: 'Philippines', xValue: 92.6, y: 6.6, size: 0.096),
    ChartSampleData(x: 'Nigeria', xValue: 61.3, y: 1.45, size: 0.162),
    ChartSampleData(x: 'Hong Kong', xValue: 82.2, y: 3.97, size: 0.7),
    ChartSampleData(x: 'Netherland', xValue: 79.2, y: 3.9, size: 0.162),
    ChartSampleData(x: 'Jordan', xValue: 72.5, y: 4.5, size: 0.7),
    ChartSampleData(x: 'Australia', xValue: 81, y: 3.5, size: 0.21),
    ChartSampleData(x: 'Mongolia', xValue: 66.8, y: 3.9, size: 0.028),
    ChartSampleData(x: 'Taiwan', xValue: 78.4, y: 2.9, size: 0.231),
  ];

  final List<ChartSampleData> columnChartData = <ChartSampleData>[
    ChartSampleData(x: 'China', y: 0.541),
    ChartSampleData(x: 'Brazil', y: 0.818),
    ChartSampleData(x: 'Bolivia', y: 1.51),
    ChartSampleData(x: 'Mexico', y: 1.302),
    ChartSampleData(x: 'Egypt', y: 2.017),
    ChartSampleData(x: 'Mongolia', y: 1.683),
  ];

  final List<ChartSampleData> doughnutChartData = <ChartSampleData>[
    ChartSampleData(x: 'Chlorine', y: 55, text: '55%'),
    ChartSampleData(x: 'Sodium', y: 31, text: '31%'),
    ChartSampleData(x: 'Magnesium', y: 7.7, text: '7.7%'),
    ChartSampleData(x: 'Sulfur', y: 3.7, text: '3.7%'),
    ChartSampleData(x: 'Calcium', y: 1.2, text: '1.2%'),
    ChartSampleData(x: 'Others', y: 1.4, text: '1.4%'),
  ];

  final List<ChartSampleData> pieChartData = <ChartSampleData>[
    ChartSampleData(x: 'David', y: 13, text: 'David \n 13%'),
    ChartSampleData(x: 'Steve', y: 24, text: 'Steve \n 24%'),
    ChartSampleData(x: 'Jack', y: 25, text: 'Jack \n 25%'),
    ChartSampleData(x: 'Others', y: 38, text: 'Others \n 38%'),
  ];

  final List<ChartSampleData> radialChartData = <ChartSampleData>[
    ChartSampleData(
        x: 'John',
        y: 10,
        text: '100%',
        pointColor: const Color.fromRGBO(248, 177, 149, 1.0)),
    ChartSampleData(
        x: 'Almaida',
        y: 11,
        text: '100%',
        pointColor: const Color.fromRGBO(246, 114, 128, 1.0)),
    ChartSampleData(
        x: 'Don',
        y: 12,
        text: '100%',
        pointColor: const Color.fromRGBO(61, 205, 171, 1.0)),
    ChartSampleData(
        x: 'Tom',
        y: 13,
        text: '100%',
        pointColor: const Color.fromRGBO(1, 174, 190, 1.0)),
  ];

  final List<ChartSampleData> pyramidChartData = <ChartSampleData>[
    ChartSampleData(x: 'Walnuts', y: 654),
    ChartSampleData(x: 'Almonds', y: 575),
    ChartSampleData(x: 'Soybeans', y: 446),
    ChartSampleData(x: 'Black beans', y: 341),
    ChartSampleData(x: 'Mushrooms', y: 296),
    ChartSampleData(x: 'Avacado', y: 160),
  ];

  SyncfusionChartsController();

  void onSelect(int index) {}
}
