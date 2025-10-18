import 'package:flatten/controllers/my_controller.dart';
import 'package:flatten/controllers/other/syncfusion_charts_controller.dart';
import 'package:flatten/helpers/theme/app_style.dart';
import 'package:flatten/models/crm_dashboard_data.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CrmDashboardController extends MyController {
  String selectRevenue = "Today";
  TooltipBehavior? tooltipBehavior;
  List<CrmDashboardData> crmData = [];

  @override
  void onInit() {
    CrmDashboardData.dummyList.then((value) {
      crmData = value;
      update();
    });
    tooltipBehavior =
        TooltipBehavior(enable: true, tooltipPosition: TooltipPosition.pointer);
    super.onInit();
  }

  void onSelectRevenue(String time) {
    selectRevenue = time;
    update();
  }

  List<ColumnSeries<ChartSampleData, String>> getDefaultColumnSeries() {
    return <ColumnSeries<ChartSampleData, String>>[
      ColumnSeries<ChartSampleData, String>(
        dataSource: <ChartSampleData>[
          ChartSampleData(x: 'Jan', y: 182),
          ChartSampleData(x: 'Fab', y: 138),
          ChartSampleData(x: 'Mar', y: 149),
          ChartSampleData(x: 'Apr', y: 158),
          ChartSampleData(x: 'May', y: 170),
          ChartSampleData(x: 'Jun', y: 149),
          ChartSampleData(x: 'Jul', y: 120),
          ChartSampleData(x: 'Aug', y: 139),
          ChartSampleData(x: 'Sep', y: 100),
          ChartSampleData(x: 'Oct', y: 179),
          ChartSampleData(x: 'Nov', y: 190),
          ChartSampleData(x: 'Dec', y: 100),
        ],
        xValueMapper: (ChartSampleData sales, _) => sales.x as String,
        yValueMapper: (ChartSampleData sales, _) => sales.y,
        color: theme.colorScheme.primary,
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
        markerSettings: MarkerSettings(isVisible: true),
        dataLabelSettings: DataLabelSettings(
            isVisible: true, textStyle: TextStyle(fontSize: 10)),
      )
    ];
  }

  List<PieSeries<ChartSampleData, String>> getSourceChart() {
    return <PieSeries<ChartSampleData, String>>[
      PieSeries<ChartSampleData, String>(
          explode: true,
          explodeIndex: 0,
          dataSource: <ChartSampleData>[
            ChartSampleData(
                x: 'Prospecting', y: 13, text: 'Prospecting \n 13%'),
            ChartSampleData(
                x: 'Negotiation', y: 24, text: 'Negotiation \n 24%'),
            ChartSampleData(x: 'Proposal', y: 25, text: 'Proposal \n 25%'),
            ChartSampleData(
                x: 'Qualification', y: 38, text: 'Qualification \n 38%'),
          ],
          xValueMapper: (ChartSampleData data, _) => data.x as String,
          yValueMapper: (ChartSampleData data, _) => data.y,
          dataLabelMapper: (ChartSampleData data, _) => data.text,
          startAngle: 90,
          endAngle: 90,
          dataLabelSettings: DataLabelSettings(isVisible: true)),
    ];
  }
}
