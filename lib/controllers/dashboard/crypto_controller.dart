import 'package:flatten/controllers/my_controller.dart';
import 'package:flatten/models/chart_model.dart';
import 'package:flatten/models/coin_growth_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CryptoController extends MyController {
  DateTimeIntervalType intervalType = DateTimeIntervalType.months;
  TrackballBehavior? trackballBehavior;
  bool enableSolidCandle = false;
  List<ChartSampleData>? chartData;
  List<CoinGrowthModel> coinGrowth = [];

  void onSelectIntervalType(DateTimeIntervalType interval) {
    intervalType = interval;
    update();
  }

  @override
  void onInit() {
    CoinGrowthModel.dummyList.then((value) {
      coinGrowth = value.sublist(0, 5);
      update();
    });
    chartData = <ChartSampleData>[
      ChartSampleData(x: 'Jan', y: 62, secondSeriesYValue: 55, thirdSeriesYValue: 53),
      ChartSampleData(x: 'Feb', y: 59, secondSeriesYValue: 52, thirdSeriesYValue: 57),
      ChartSampleData(x: 'Mar', y: 68, secondSeriesYValue: 56, thirdSeriesYValue: 61),
      ChartSampleData(x: 'Apr', y: 72, secondSeriesYValue: 61, thirdSeriesYValue: 64),
      ChartSampleData(x: 'May', y: 80, secondSeriesYValue: 67, thirdSeriesYValue: 70),
      ChartSampleData(x: 'Jun', y: 85, secondSeriesYValue: 73, thirdSeriesYValue: 76),
      ChartSampleData(x: 'Jul', y: 90, secondSeriesYValue: 78, thirdSeriesYValue: 81),
      ChartSampleData(x: 'Aug', y: 88, secondSeriesYValue: 76, thirdSeriesYValue: 79),
      ChartSampleData(x: 'Sep', y: 82, secondSeriesYValue: 70, thirdSeriesYValue: 74),
      ChartSampleData(x: 'Oct', y: 76, secondSeriesYValue: 65, thirdSeriesYValue: 69),
      ChartSampleData(x: 'Nov', y: 69, secondSeriesYValue: 60, thirdSeriesYValue: 63),
      ChartSampleData(x: 'Dec', y: 63, secondSeriesYValue: 58, thirdSeriesYValue: 61)
    ];
    super.onInit();
  }
}
