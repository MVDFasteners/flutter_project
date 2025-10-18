import 'package:flatten/controllers/my_controller.dart';
import 'package:flatten/models/chart_model.dart';
import 'package:flatten/models/project_summary_model.dart';
import 'package:flatten/models/task_list_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ProjectController extends MyController {
  TooltipBehavior? tooltipBehavior;
  List<TaskListModel> task = [];
  List<ProjectSummaryModel> projectSummary = [];
  List<ChartSampleData>? chartData;

  @override
  void onInit() {
    TaskListModel.dummyList.then((value) {
      task = value;
      update();
    });
    ProjectSummaryModel.dummyList.then((value) {
      projectSummary = value.sublist(0, 5);
      update();
    });
    chartData = <ChartSampleData>[
      ChartSampleData(x: 'Jan', y: 15, secondSeriesYValue: 10, thirdSeriesYValue: 13),
      ChartSampleData(x: 'Feb', y: 8, secondSeriesYValue: 7, thirdSeriesYValue: 6),
      ChartSampleData(x: 'Mar', y: 14, secondSeriesYValue: 11, thirdSeriesYValue: 8),
      ChartSampleData(x: 'Apr', y: 12, secondSeriesYValue: 9, thirdSeriesYValue: 15),
      ChartSampleData(x: 'May', y: 10, secondSeriesYValue: 8, thirdSeriesYValue: 9),
      ChartSampleData(x: 'Jun', y: 9, secondSeriesYValue: 10, thirdSeriesYValue: 7),
      ChartSampleData(x: 'Jul', y: 13, secondSeriesYValue: 14, thirdSeriesYValue: 11),
      ChartSampleData(x: 'Aug', y: 6, secondSeriesYValue: 9, thirdSeriesYValue: 10),
      ChartSampleData(x: 'Sep', y: 11, secondSeriesYValue: 12, thirdSeriesYValue: 6),
      ChartSampleData(x: 'Oct', y: 5, secondSeriesYValue: 10, thirdSeriesYValue: 14),
      ChartSampleData(x: 'Nov', y: 9, secondSeriesYValue: 5, thirdSeriesYValue: 11),
      ChartSampleData(x: 'Dec', y: 16, secondSeriesYValue: 4, thirdSeriesYValue: 12)
    ];

    tooltipBehavior = TooltipBehavior(enable: true, format: 'point.x : point.ym');
    super.onInit();
  }

  List<Map<String, String>> recentTransactions = [
    {'name': 'Alice', 'date': 'Nov 28, 2024 - 10:30AM', 'price': '\$50.00'},
    {'name': 'Bob', 'date': 'Nov 28, 2024 - 11:15AM', 'price': '\$75.00'},
    {'name': 'Charlie', 'date': 'Nov 28, 2024 - 1:45PM', 'price': '\$120.00'},
    {'name': 'Diana', 'date': 'Nov 28, 2024 - 3:00PM', 'price': '\$200.00'},
    {'name': 'Eva', 'date': 'Nov 28, 2024 - 5:30PM', 'price': '\$10.00'},
    {'name': 'Frank', 'date': 'Nov 28, 2024 - 7:15PM', 'price': '\$99.99'},
  ];

  void onSelectTask(TaskListModel task) {
    task.isSelectTask = !task.isSelectTask;
    update();
  }
}
