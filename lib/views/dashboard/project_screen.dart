import 'package:flatten/controllers/dashboard/project_controller.dart';
import 'package:flatten/helpers/theme/app_style.dart';
import 'package:flatten/helpers/utils/mixins/ui_mixin.dart';
import 'package:flatten/helpers/utils/my_shadow.dart';
import 'package:flatten/helpers/utils/utils.dart';
import 'package:flatten/helpers/widgets/my_breadcrumb.dart';
import 'package:flatten/helpers/widgets/my_breadcrumb_item.dart';
import 'package:flatten/helpers/widgets/my_card.dart';
import 'package:flatten/helpers/widgets/my_container.dart';
import 'package:flatten/helpers/widgets/my_flex.dart';
import 'package:flatten/helpers/widgets/my_flex_item.dart';
import 'package:flatten/helpers/widgets/my_list_extension.dart';
import 'package:flatten/helpers/widgets/my_spacing.dart';
import 'package:flatten/helpers/widgets/my_text.dart';
import 'package:flatten/images.dart';
import 'package:flatten/models/chart_model.dart';
import 'package:flatten/models/task_list_model.dart';
import 'package:flatten/views/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ProjectScreen extends StatefulWidget {
  const ProjectScreen({super.key});

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> with UIMixin {
  ProjectController controller = Get.put(ProjectController());

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        tag: 'project_dashboard_controller',
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
                      "Project Dashboard",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'Project'),
                        MyBreadcrumbItem(name: 'Dashboard', active: true),
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
                    MyFlexItem(sizes: 'lg-3 md-6 sm-6', child: stats("Total Tasks", "2500", "+3.5")),
                    MyFlexItem(sizes: 'lg-3 md-6 sm-6', child: stats("Finished Tasks", "1800", "-2.3")),
                    MyFlexItem(sizes: 'lg-3 md-6 sm-6', child: stats("Ongoing Tasks", "500", "+4.1")),
                    MyFlexItem(sizes: 'lg-3 md-6 sm-6', child: stats("Active Tasks", "75", "-1.1")),
                    MyFlexItem(sizes: 'lg-6 md-6 sm-6', child: taskPerformance()),
                    MyFlexItem(sizes: 'lg-6 md-6 sm-6', child: incomeAnalytics()),
                    MyFlexItem(sizes: 'lg-3 md-6 sm-6', child: taskList()),
                    MyFlexItem(sizes: 'lg-3 md-6 sm-6', child: recentTransaction()),
                    MyFlexItem(sizes: 'lg-6 md-6', child: taskSummary()),
                    MyFlexItem(child: projectSummary()),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget stats(String title, String details, String progress) {
    return MyCard(
      shadow: MyShadow(elevation: 0.5, position: MyShadowPosition.bottom),
      paddingAll: 24,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText.bodyMedium(title),
                MySpacing.height(4),
                MyText.titleLarge(details, fontWeight: 600),
                MySpacing.height(4),
                Row(
                  children: [
                    Flexible(child: MyText.bodySmall("Project Progress", fontWeight: 600, maxLines: 1)),
                    MySpacing.width(4),
                    MyText.bodySmall(progress, color: progress.startsWith('+') ? contentTheme.success : contentTheme.danger, fontWeight: 600, maxLines: 1),
                    MySpacing.width(4),
                    Icon(progress.startsWith('+') ? LucideIcons.trending_up : LucideIcons.trending_down,
                        color: progress.startsWith('+') ? contentTheme.success : contentTheme.danger, size: 16)
                  ],
                ),
              ],
            ),
          ),
          MyContainer.rounded(
            height: 40,
            width: 40,
            paddingAll: 0,
            color: contentTheme.primary,
            child: Icon(LucideIcons.file, size: 16, color: contentTheme.onPrimary),
          )
        ],
      ),
    );
  }

  Widget taskPerformance() {
    return MyCard(
      shadow: MyShadow(elevation: 0.5, position: MyShadowPosition.bottom),
      paddingAll: 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.bodyMedium("Task Performance", fontWeight: 600),
          SizedBox(
            height: 299,
            child: SfCircularChart(
              margin: MySpacing.zero,
              series: [
                RadialBarSeries<ChartSampleData, String>(
                    dataLabelSettings: const DataLabelSettings(isVisible: true, textStyle: TextStyle(fontSize: 10.0)),
                    dataSource: <ChartSampleData>[
                      ChartSampleData(x: 'Complete', y: 7, text: '100%', pointColor: contentTheme.primary),
                      ChartSampleData(x: 'Active', y: 5, text: '100%', pointColor: contentTheme.success),
                      ChartSampleData(x: 'Assigned', y: 8, text: '100%', pointColor: contentTheme.info),
                    ],
                    cornerStyle: CornerStyle.bothCurve,
                    gap: '10%',
                    radius: '90%',
                    xValueMapper: (ChartSampleData data, _) => data.x as String,
                    yValueMapper: (ChartSampleData data, _) => data.y,
                    pointRadiusMapper: (ChartSampleData data, _) => data.text,
                    pointColorMapper: (ChartSampleData data, _) => data.pointColor,
                    dataLabelMapper: (ChartSampleData data, _) => data.x as String)
              ],
              tooltipBehavior: controller.tooltipBehavior,
            ),
          )
        ],
      ),
    );
  }

  Widget incomeAnalytics() {
    return MyCard(
      shadow: MyShadow(elevation: 0.5, position: MyShadowPosition.bottom),
      paddingAll: 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.bodyMedium("Income Analytics", fontWeight: 600),
          SfCircularChart(
            margin: MySpacing.zero,
            legend: Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap, position: LegendPosition.bottom),
            series: [
              PieSeries<ChartSampleData, String>(
                dataSource: <ChartSampleData>[
                  ChartSampleData(x: 'USA', y: 700000, text: '60%'),
                  ChartSampleData(x: 'Germany', y: 450000, text: '50%'),
                  ChartSampleData(x: 'China', y: 600000, text: '65%'),
                  ChartSampleData(x: 'India', y: 400000, text: '55%'),
                  ChartSampleData(x: 'Brazil', y: 350000, text: '40%'),
                  ChartSampleData(x: 'Russia', y: 300000, text: '35%'),
                  ChartSampleData(x: 'South Africa', y: 250000, text: '30%')
                ],
                xValueMapper: (ChartSampleData data, _) => data.x,
                yValueMapper: (ChartSampleData data, _) => data.y,
                dataLabelMapper: (ChartSampleData data, _) => data.x,
                startAngle: 100,
                endAngle: 100,
                pointRadiusMapper: (ChartSampleData data, _) => data.text,
                dataLabelSettings: const DataLabelSettings(isVisible: true, labelPosition: ChartDataLabelPosition.outside),
              ),
            ],
            tooltipBehavior: TooltipBehavior(enable: true, tooltipPosition: TooltipPosition.auto),
          )
        ],
      ),
    );
  }

  Widget taskList() {
    return MyCard(
      shadow: MyShadow(elevation: 0.5, position: MyShadowPosition.bottom),
      paddingAll: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: MySpacing.all(24),
            child: MyText.bodyMedium("Task List", fontWeight: 600),
          ),
          SizedBox(
            height: 380,
            child: ListView.separated(
              itemCount: controller.task.length,
              shrinkWrap: true,
              padding: MySpacing.x(24),
              itemBuilder: (context, index) {
                TaskListModel task = controller.task[index];
                return Row(
                  children: [
                    Theme(
                      data: ThemeData(visualDensity: getCompactDensity),
                      child: Checkbox(
                        value: task.isSelectTask,
                        onChanged: (value) => controller.onSelectTask(task),
                        visualDensity: getCompactDensity,
                      ),
                    ),
                    MySpacing.width(12),
                    MyContainer.rounded(
                      height: 32,
                      width: 32,
                      paddingAll: 0,
                      child: Image.asset(Images.avatars[index % Images.avatars.length], fit: BoxFit.cover),
                    ),
                    MySpacing.width(12),
                    Expanded(child: MyText.bodyMedium(task.title, maxLines: 1)),
                    MyText.labelMedium(task.status,
                        color: task.status == 'Pending'
                            ? contentTheme.primary
                            : task.status == 'Completed'
                                ? contentTheme.success
                                : null),
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return MySpacing.height(24);
              },
            ),
          )
        ],
      ),
    );
  }

  Widget recentTransaction() {
    Widget recentTransaction(String title, String subTitle, String price) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              MyContainer.roundBordered(
                paddingAll: 12,
                child: MyText(title[0].capitalize.toString()),
              ),
              MySpacing.width(24),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText.bodyMedium(title),
                    MySpacing.height(4),
                    MyText.bodySmall(subTitle),
                  ],
                ),
              ),
              MyText.bodySmall(price),
            ],
          )
        ],
      );
    }

    return MyCard(
      shadow: MyShadow(elevation: 0.5, position: MyShadowPosition.bottom),
      padding: MySpacing.top(24),
      height: 450,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: MySpacing.x(24),
            child: MyText.bodyMedium("Recent Transaction", fontWeight: 600),
          ),
          Expanded(
            child: ListView(
              padding: MySpacing.nBottom(24),
              children: [
                for (Map<String, String> transaction in controller.recentTransactions)
                  Column(
                    children: [
                      recentTransaction(transaction['name'] ?? '', transaction['date'] ?? '', transaction['price'] ?? ''),
                      MySpacing.height(24),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget taskSummary() {
    return MyCard(
      shadow: MyShadow(elevation: 0.5, position: MyShadowPosition.bottom),
      paddingAll: 24,
      height: 450,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText.bodyMedium("Task Summary", fontWeight: 600),
              MyContainer(
                onTap: () {},
                paddingAll: 8,
                color: contentTheme.light,
                child: MyText.labelSmall("View All", fontWeight: 600),
              )
            ],
          ),
          MySpacing.height(24),
          SizedBox(
            height: 344,
            child: SfCartesianChart(
              plotAreaBorderWidth: 0,
              margin: MySpacing.zero,
              legend: Legend(isVisible: true, position: LegendPosition.bottom),
              primaryXAxis: const CategoryAxis(majorGridLines: MajorGridLines(width: 0), labelPlacement: LabelPlacement.onTicks),
              primaryYAxis: const NumericAxis(
                  axisLine: AxisLine(width: 0), edgeLabelPlacement: EdgeLabelPlacement.shift, labelFormat: '{value}', majorTickLines: MajorTickLines(size: 0)),
              series: [
                SplineSeries<ChartSampleData, String>(
                    dataSource: controller.chartData,
                    xValueMapper: (ChartSampleData sales, _) => sales.x as String,
                    yValueMapper: (ChartSampleData sales, _) => sales.y,
                    markerSettings: const MarkerSettings(isVisible: true),
                    name: 'This Week'),
                SplineSeries<ChartSampleData, String>(
                  dataSource: controller.chartData,
                  name: 'Last Week',
                  markerSettings: const MarkerSettings(isVisible: true),
                  xValueMapper: (ChartSampleData sales, _) => sales.x as String,
                  yValueMapper: (ChartSampleData sales, _) => sales.secondSeriesYValue,
                )
              ],
              tooltipBehavior: TooltipBehavior(enable: true),
            ),
          )
        ],
      ),
    );
  }

  Widget projectSummary() {
    return MyCard.bordered(
      borderRadiusAll: 4,
      border: Border.all(color: Colors.grey.withValues(alpha: .2)),
      shadow: MyShadow(elevation: 1, position: MyShadowPosition.bottom),
      paddingAll: 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.bodyMedium("Project Summary", fontWeight: 600),
          MySpacing.height(24),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
                sortAscending: true,
                columnSpacing: 145,
                onSelectAll: (_) => {},
                headingRowColor: WidgetStatePropertyAll(contentTheme.primary.withAlpha(40)),
                dataRowMaxHeight: 60,
                showBottomBorder: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                border: TableBorder.all(borderRadius: BorderRadius.circular(4), style: BorderStyle.solid, width: .4, color: Colors.grey),
                columns: [
                  DataColumn(label: MyText.labelLarge('S.No', color: contentTheme.primary)),
                  DataColumn(label: MyText.labelLarge('Title', color: contentTheme.primary)),
                  DataColumn(label: MyText.labelLarge('Assign to', color: contentTheme.primary)),
                  DataColumn(label: MyText.labelLarge('Due Date', color: contentTheme.primary)),
                  DataColumn(label: MyText.labelLarge('Priority', color: contentTheme.primary)),
                  DataColumn(label: MyText.labelLarge('Status', color: contentTheme.primary)),
                  DataColumn(label: MyText.labelLarge('Action', color: contentTheme.primary)),
                ],
                rows: controller.projectSummary
                    .mapIndexed((index, data) => DataRow(cells: [
                          DataCell(MyText.bodyMedium("#${data.id}", fontWeight: 600)),
                          DataCell(MyText.bodyMedium(data.title, fontWeight: 600)),
                          DataCell(MyText.bodyMedium(data.assignTo, fontWeight: 600)),
                          DataCell(MyText.bodyMedium(Utils.getDateStringFromDateTime(data.date), fontWeight: 600)),
                          DataCell(MyText.bodyMedium(data.priority, fontWeight: 600)),
                          DataCell(MyText.bodyMedium(data.status, fontWeight: 600)),
                          DataCell(Row(
                            children: [
                              MyContainer(
                                onTap: () {},
                                color: contentTheme.primary,
                                paddingAll: 8,
                                child: Icon(LucideIcons.download, size: 16, color: contentTheme.onPrimary),
                              ),
                              MySpacing.width(12),
                              MyContainer(
                                onTap: () {},
                                color: contentTheme.secondary,
                                paddingAll: 8,
                                child: Icon(LucideIcons.pencil, size: 16, color: contentTheme.onPrimary),
                              ),
                            ],
                          ))
                        ]))
                    .toList()),
          )
        ],
      ),
    );
  }
}
