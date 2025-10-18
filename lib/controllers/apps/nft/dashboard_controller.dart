import 'package:flatten/controllers/my_controller.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

class ChartData {
  ChartData(this.y, this.x);

  final double? y;
  final String x;
}

class NFTDashboardController extends MyController {
  final TooltipBehavior tooltipBehavior = TooltipBehavior(
    enable: true,
    textAlignment: ChartAlignment.center,
    header: '',
    canShowMarker: false,
  );
  final List<ChartData> chartData = <ChartData>[
    ChartData(21, 'Jan'),
    ChartData(24, 'Feb'),
    ChartData(35, 'Mar'),
    ChartData(38, 'Apr'),
    ChartData(12, 'May'),
    ChartData(21, 'Jun'),
    ChartData(24, 'Jul'),
    ChartData(5, 'Aug'),
    ChartData(38, 'Sep'),
    ChartData(35, 'Oct'),
    ChartData(15, 'Nov'),
    ChartData(20, 'Dec')
  ];
}
