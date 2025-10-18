import 'package:flatten/controllers/other/syncfusion_charts_controller.dart';
import 'package:flatten/helpers/extensions/string.dart';
import 'package:flatten/helpers/theme/app_style.dart';
import 'package:flatten/helpers/utils/mixins/ui_mixin.dart';
import 'package:flatten/helpers/widgets/my_breadcrumb.dart';
import 'package:flatten/helpers/widgets/my_breadcrumb_item.dart';
import 'package:flatten/helpers/widgets/my_container.dart';
import 'package:flatten/helpers/widgets/my_flex.dart';
import 'package:flatten/helpers/widgets/my_flex_item.dart';
import 'package:flatten/helpers/widgets/my_spacing.dart';
import 'package:flatten/helpers/widgets/my_text.dart';
import 'package:flatten/helpers/widgets/my_text_style.dart';
import 'package:flatten/views/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SyncfusionChartsPage extends StatefulWidget {
  const SyncfusionChartsPage({super.key});

  @override
  _SyncfusionChartsPageState createState() => _SyncfusionChartsPageState();
}

class _SyncfusionChartsPageState extends State<SyncfusionChartsPage>
    with SingleTickerProviderStateMixin, UIMixin {
  late SyncfusionChartsController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(SyncfusionChartsController());
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
        child: GetBuilder<SyncfusionChartsController>(
            init: controller,
            builder: (controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: MySpacing.x(flexSpacing),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyText.titleMedium(
                          "syncfusion_charts".tr().capitalizeWords,
                          fontSize: 18,
                          fontWeight: 600,
                        ),
                        MyBreadcrumb(
                          children: [
                            MyBreadcrumbItem(name: 'ui'.tr()),
                            MyBreadcrumbItem(name: 'charts'.tr(), active: true),
                          ],
                        ),
                      ],
                    ),
                  ),
                  MySpacing.height(flexSpacing),
                  Padding(
                    padding: MySpacing.x(flexSpacing / 2),
                    child: MyFlex(
                      children: [
                        MyFlexItem(
                            sizes: "lg-6 md-12",
                            child: MyContainer.bordered(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 6,
                                        height: 18,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(1)),
                                          color: AppColors.random.color,
                                        ),
                                      ),
                                      MySpacing.width(12),
                                      MyText.titleMedium(
                                          "area_chart".tr().capitalizeWords,
                                          fontWeight: 600),
                                    ],
                                  ),
                                  MySpacing.height(16),
                                  _buildDefaultAreaChart(),
                                ],
                              ),
                            )),
                        MyFlexItem(
                            sizes: "lg-6 md-12",
                            child: MyContainer.bordered(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 6,
                                        height: 18,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(1)),
                                          color: AppColors.random.color,
                                        ),
                                      ),
                                      MySpacing.width(12),
                                      MyText.titleMedium(
                                          "bar_chart".tr().capitalizeWords,
                                          fontWeight: 600),
                                    ],
                                  ),
                                  MySpacing.height(16),
                                  _buildDefaultBarChart(),
                                ],
                              ),
                            )),
                        MyFlexItem(
                            sizes: "lg-6 md-12",
                            child: MyContainer.bordered(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 6,
                                        height: 18,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(1)),
                                          color: AppColors.random.color,
                                        ),
                                      ),
                                      MySpacing.width(12),
                                      MyText.titleMedium(
                                          "bubble_chart".tr().capitalizeWords,
                                          fontWeight: 600),
                                    ],
                                  ),
                                  MySpacing.height(16),
                                  _buildDefaultBubbleChart(),
                                ],
                              ),
                            )),
                        MyFlexItem(
                            sizes: "lg-6 md-12",
                            child: MyContainer.bordered(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 6,
                                        height: 18,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(1)),
                                          color: AppColors.random.color,
                                        ),
                                      ),
                                      MySpacing.width(12),
                                      MyText.titleMedium(
                                          "column_chart".tr().capitalizeWords,
                                          fontWeight: 600),
                                    ],
                                  ),
                                  MySpacing.height(16),
                                  _buildDefaultColumnChart(),
                                ],
                              ),
                            )),
                        MyFlexItem(
                            sizes: "lg-6 md-12",
                            child: MyContainer.bordered(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 6,
                                        height: 18,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(1)),
                                          color: AppColors.random.color,
                                        ),
                                      ),
                                      MySpacing.width(12),
                                      MyText.titleMedium(
                                          "doughnut_chart".tr().capitalizeWords,
                                          fontWeight: 600),
                                    ],
                                  ),
                                  MySpacing.height(16),
                                  _buildDefaultDoughnutChart(),
                                ],
                              ),
                            )),
                        MyFlexItem(
                            sizes: "lg-6 md-12",
                            child: MyContainer.bordered(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 6,
                                        height: 18,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(1)),
                                          color: AppColors.random.color,
                                        ),
                                      ),
                                      MySpacing.width(12),
                                      MyText.titleMedium(
                                          "pie_chart".tr().capitalizeWords,
                                          fontWeight: 600),
                                    ],
                                  ),
                                  MySpacing.height(16),
                                  _buildDefaultPieChart(),
                                ],
                              ),
                            )),
                        MyFlexItem(
                            sizes: "lg-6 md-12",
                            child: MyContainer.bordered(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 6,
                                        height: 18,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(1)),
                                          color: AppColors.random.color,
                                        ),
                                      ),
                                      MySpacing.width(12),
                                      MyText.titleMedium(
                                          "radial_chart".tr().capitalizeWords,
                                          fontWeight: 600),
                                    ],
                                  ),
                                  MySpacing.height(16),
                                  _buildDefaultRadialBarChart(),
                                ],
                              ),
                            )),
                        MyFlexItem(
                            sizes: "lg-6 md-12",
                            child: MyContainer.bordered(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 6,
                                        height: 18,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(1)),
                                          color: AppColors.random.color,
                                        ),
                                      ),
                                      MySpacing.width(12),
                                      MyText.titleMedium(
                                          "pyramid_chart".tr().capitalizeWords,
                                          fontWeight: 600),
                                    ],
                                  ),
                                  MySpacing.height(16),
                                  _buildDefaultPyramidChart(),
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                ],
              );
            }));
  }

  /// ====   Charts   =====

  //Default Area Chart
  SfCartesianChart _buildDefaultAreaChart() {
    List<AreaSeries<ChartSampleData, DateTime>> getDefaultAreaSeries() {
      return <AreaSeries<ChartSampleData, DateTime>>[
        AreaSeries<ChartSampleData, DateTime>(
          dataSource: controller.areaChartData,
          opacity: 0.7,
          name: 'product_a'.tr().capitalizeWords,
          xValueMapper: (ChartSampleData sales, _) => sales.x as DateTime,
          yValueMapper: (ChartSampleData sales, _) => sales.y,
        ),
        AreaSeries<ChartSampleData, DateTime>(
          dataSource: controller.areaChartData,
          opacity: 0.7,
          name: 'product_b',
          xValueMapper: (ChartSampleData sales, _) => sales.x as DateTime,
          yValueMapper: (ChartSampleData sales, _) => sales.secondSeriesYValue,
        )
      ];
    }

    return SfCartesianChart(
      legend: Legend(opacity: 0.7, position: LegendPosition.bottom),
      title: ChartTitle(
          text: 'average_sales_comparison\n'.tr().capitalizeWords,
          textStyle: MyTextStyle.bodySmall()),
      plotAreaBorderWidth: 0,
      primaryXAxis: DateTimeAxis(
          interval: 1,
          intervalType: DateTimeIntervalType.years,
          majorGridLines: const MajorGridLines(width: 0),
          edgeLabelPlacement: EdgeLabelPlacement.shift),
      primaryYAxis: NumericAxis(
          labelFormat: '{value}M',
          //title: AxisTitle(text: 'Revenue in millions'),
          interval: 1,
          axisLine: const AxisLine(width: 0),
          majorTickLines:
              const MajorTickLines(size: 8, color: Colors.transparent)),
      series: getDefaultAreaSeries(),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  SfCartesianChart _buildDefaultBarChart() {
    List<BarSeries<ChartSampleData, String>> getDefaultBarSeries() {
      return <BarSeries<ChartSampleData, String>>[
        BarSeries<ChartSampleData, String>(
            dataSource: controller.barChartData,
            xValueMapper: (ChartSampleData sales, _) => sales.x as String,
            yValueMapper: (ChartSampleData sales, _) => sales.y,
            name: '2015'),
        BarSeries<ChartSampleData, String>(
            dataSource: controller.barChartData,
            xValueMapper: (ChartSampleData sales, _) => sales.x as String,
            yValueMapper: (ChartSampleData sales, _) =>
                sales.secondSeriesYValue,
            name: '2016'),
        BarSeries<ChartSampleData, String>(
            dataSource: controller.barChartData,
            xValueMapper: (ChartSampleData sales, _) => sales.x as String,
            yValueMapper: (ChartSampleData sales, _) => sales.thirdSeriesYValue,
            name: '2017')
      ];
    }

    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(
          text: '${'tourism_-_number'.tr().capitalizeWords}'
              ' ${'of_arrivals'.tr()}'
              '\n',
          textStyle: MyTextStyle.bodySmall()),
      legend: Legend(isVisible: true, position: LegendPosition.bottom),
      primaryXAxis: CategoryAxis(
        majorGridLines: MajorGridLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
        majorGridLines: MajorGridLines(width: 0),
      ),
      series: getDefaultBarSeries(),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  SfCartesianChart _buildDefaultBubbleChart() {
    List<BubbleSeries<ChartSampleData, num>> getDefaultBubbleSeries() {
      return <BubbleSeries<ChartSampleData, num>>[
        BubbleSeries<ChartSampleData, num>(
          opacity: 0.7,
          dataSource: controller.bubbleChartData,
          xValueMapper: (ChartSampleData sales, _) => sales.xValue as num,
          yValueMapper: (ChartSampleData sales, _) => sales.y,
          sizeValueMapper: (ChartSampleData sales, _) => sales.size,
        )
      ];
    }

    return SfCartesianChart(
        plotAreaBorderWidth: 0,
        title: ChartTitle(
            text: 'world_countries_details\n'.tr(),
            textStyle: MyTextStyle.bodySmall()),
        primaryXAxis: NumericAxis(
            majorGridLines: const MajorGridLines(width: 0),
            title: AxisTitle(
                text: 'literacy_rate'.tr(), textStyle: MyTextStyle.bodySmall()),
            minimum: 60,
            maximum: 100),
        primaryYAxis: NumericAxis(
            axisLine: const AxisLine(width: 0),
            majorTickLines:
                const MajorTickLines(size: 8, color: Colors.transparent),
            title: AxisTitle(
                text: 'gdp_growth_rate'.tr(),
                textStyle: MyTextStyle.bodySmall())),
        tooltipBehavior: controller.tooltipBehavior,
        series: getDefaultBubbleSeries());
  }

  SfCartesianChart _buildDefaultColumnChart() {
    List<ColumnSeries<ChartSampleData, String>> getDefaultColumnSeries() {
      return <ColumnSeries<ChartSampleData, String>>[
        ColumnSeries<ChartSampleData, String>(
          dataSource: controller.columnChartData,
          xValueMapper: (ChartSampleData sales, _) => sales.x as String,
          yValueMapper: (ChartSampleData sales, _) => sales.y,
          dataLabelSettings: DataLabelSettings(
              isVisible: true, textStyle: TextStyle(fontSize: 10)),
        )
      ];
    }

    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(
        text: 'population_growth_of_various_countries\n'.tr(),
        textStyle: MyTextStyle.bodySmall(),
      ),
      primaryXAxis: CategoryAxis(
        majorGridLines: MajorGridLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
          axisLine: AxisLine(width: 0),
          labelFormat: '{value}%',
          majorTickLines: MajorTickLines(size: 8, color: Colors.transparent)),
      series: getDefaultColumnSeries(),
      tooltipBehavior: controller.tooltipBehavior,
    );
  }

  SfCircularChart _buildDefaultDoughnutChart() {
    List<DoughnutSeries<ChartSampleData, String>> getDefaultDoughnutSeries() {
      return <DoughnutSeries<ChartSampleData, String>>[
        DoughnutSeries<ChartSampleData, String>(
            radius: '80%',
            explode: true,
            explodeOffset: '10%',
            dataSource: controller.doughnutChartData,
            xValueMapper: (ChartSampleData data, _) => data.x as String,
            yValueMapper: (ChartSampleData data, _) => data.y,
            dataLabelMapper: (ChartSampleData data, _) => data.text,
            dataLabelSettings: const DataLabelSettings(isVisible: true))
      ];
    }

    return SfCircularChart(
      title: ChartTitle(
          text: 'composition_of_ocean_water'.tr(),
          textStyle: MyTextStyle.bodySmall()),
      legend: Legend(
          isVisible: true,
          overflowMode: LegendItemOverflowMode.wrap,
          position: LegendPosition.bottom),
      series: getDefaultDoughnutSeries(),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  SfCircularChart _buildDefaultPieChart() {
    List<PieSeries<ChartSampleData, String>> getDefaultPieSeries() {
      return <PieSeries<ChartSampleData, String>>[
        PieSeries<ChartSampleData, String>(
            explode: true,
            explodeIndex: 0,
            explodeOffset: '10%',
            dataSource: controller.pieChartData,
            xValueMapper: (ChartSampleData data, _) => data.x as String,
            yValueMapper: (ChartSampleData data, _) => data.y,
            dataLabelMapper: (ChartSampleData data, _) => data.text,
            startAngle: 90,
            endAngle: 90,
            dataLabelSettings: const DataLabelSettings(isVisible: true)),
      ];
    }

    return SfCircularChart(
      title: ChartTitle(
          text: 'sales_by_sales_person'.tr(),
          textStyle: MyTextStyle.bodySmall()),
      legend: Legend(isVisible: true, position: LegendPosition.bottom),
      series: getDefaultPieSeries(),
    );
  }

  SfCircularChart _buildDefaultRadialBarChart() {
    List<RadialBarSeries<ChartSampleData, String>> getRadialBarDefaultSeries() {
      return <RadialBarSeries<ChartSampleData, String>>[
        RadialBarSeries<ChartSampleData, String>(
            maximumValue: 15,
            dataLabelSettings: const DataLabelSettings(
                isVisible: true, textStyle: TextStyle(fontSize: 10.0)),
            dataSource: controller.radialChartData,
            cornerStyle: CornerStyle.bothCurve,
            gap: '10%',
            radius: '90%',
            xValueMapper: (ChartSampleData data, _) => data.x as String,
            yValueMapper: (ChartSampleData data, _) => data.y,
            pointRadiusMapper: (ChartSampleData data, _) => data.text,
            pointColorMapper: (ChartSampleData data, _) => data.pointColor,
            dataLabelMapper: (ChartSampleData data, _) => data.x as String)
      ];
    }

    return SfCircularChart(
      key: GlobalKey(),
      title: ChartTitle(
          text: 'shot_put_distance'.tr(), textStyle: MyTextStyle.bodySmall()),
      series: getRadialBarDefaultSeries(),
      tooltipBehavior: controller.radialTooltipBehavior,
    );
  }

  SfPyramidChart _buildDefaultPyramidChart() {
    PyramidSeries<ChartSampleData, String> getPyramidSeries() {
      return PyramidSeries<ChartSampleData, String>(
          dataSource: controller.pyramidChartData,
          height: '90%',
          explode: false,
          gapRatio: 0,
          pyramidMode: PyramidMode.linear,
          xValueMapper: (ChartSampleData data, _) => data.x as String,
          yValueMapper: (ChartSampleData data, _) => data.y,
          dataLabelSettings: const DataLabelSettings(
            isVisible: true,
          ));
    }

    return SfPyramidChart(
      // smartLabelMode: SmartLabelMode.shift,
      title: ChartTitle(
          text: 'comparison_of_calories'.tr(),
          textStyle: MyTextStyle.bodySmall()),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: getPyramidSeries(),
    );
  }
}
