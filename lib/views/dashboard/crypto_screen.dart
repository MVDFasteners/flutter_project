import 'package:flatten/controllers/dashboard/crypto_controller.dart';
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
import 'package:flatten/models/chart_model.dart';
import 'package:flatten/views/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CryptoScreen extends StatefulWidget {
  const CryptoScreen({super.key});

  @override
  State<CryptoScreen> createState() => _CryptoScreenState();
}

class _CryptoScreenState extends State<CryptoScreen> with UIMixin {
  CryptoController controller = Get.put(CryptoController());

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        tag: 'crypto_dashboard_controller',
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
                      "Crypto",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'Crypto'),
                        MyBreadcrumbItem(name: 'Dashboard', active: true),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing / 2),
                child: MyFlex(children: [
                  MyFlexItem(sizes: 'lg-3 md-6 sm-6', child: stats("Ethereum", "3200.00", "250.75", LucideIcons.circle_arrow_up)),
                  MyFlexItem(sizes: 'lg-3 md-6 sm-6', child: stats("Bitcoin", "21500.00", "100.10", LucideIcons.circle_arrow_up)),
                  MyFlexItem(sizes: 'lg-3 md-6 sm-6', child: stats("Ripple", "0.90", "-0.05", LucideIcons.circle_arrow_down)),
                  MyFlexItem(sizes: 'lg-3 md-6 sm-6', child: stats("Dogecoin", "0.073", "0.004", LucideIcons.circle_arrow_up)),
                  MyFlexItem(sizes: 'lg-4 md-6', child: recentActivity()),
                  MyFlexItem(sizes: 'lg-4 md-6', child: topPerformers()),
                  MyFlexItem(sizes: 'lg-4', child: transactionHistory()),
                  MyFlexItem(sizes: 'lg-6 md-6', child: marketOverview()),
                  MyFlexItem(sizes: 'lg-6 md-6', child: cryptoStatistics()),
                  MyFlexItem(child: activeOverallGrowth()),
                ]),
              )
            ],
          );
        },
      ),
    );
  }

  Widget stats(String title, String detail, String percentile, IconData? icon) {
    return MyCard(
      shadow: MyShadow(elevation: 0.5, position: MyShadowPosition.bottom),
      paddingAll: 24,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText.bodyMedium(title),
                MySpacing.height(4),
                MyText.titleLarge(detail, fontWeight: 600),
                MySpacing.height(4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(percentile.startsWith('-') ? LucideIcons.chevron_down : LucideIcons.chevron_up,
                        size: 16, color: percentile.startsWith('-') ? contentTheme.danger : contentTheme.success),
                    MySpacing.width(4),
                    MyText.bodySmall('$percentile%', fontWeight: 600, color: percentile.startsWith('-') ? contentTheme.danger : contentTheme.success),
                    MySpacing.width(4),
                    Expanded(child: MyText.bodySmall("per year", maxLines: 1)),
                  ],
                )
              ],
            ),
          ),
          MyContainer(
            height: 60,
            width: 60,
            paddingAll: 0,
            color: percentile.startsWith('-') ? contentTheme.danger : contentTheme.success,
            child: Icon(icon, size: 22, color: contentTheme.onPrimary),
          ),
        ],
      ),
    );
  }

  Widget recentActivity() {
    Widget recentActivityWidget(String coinName, String transactionType, String price, String transactionUpDown, IconData icon) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyContainer.roundBordered(
            height: 44,
            width: 44,
            paddingAll: 0,
            child: Icon(icon, size: 20),
          ),
          MySpacing.width(20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText.bodyMedium(coinName, fontWeight: 600, maxLines: 1),
                MySpacing.height(4),
                MyText.bodySmall(transactionType, fontWeight: 600, muted: true, maxLines: 1),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              MyText.bodyMedium(price, fontWeight: 600),
              MySpacing.height(4),
              MyText.bodySmall("${transactionUpDown.startsWith('-') ? '' : '+'}${transactionUpDown}",
                  fontWeight: 600, muted: true, color: transactionUpDown.startsWith('-') ? contentTheme.danger : contentTheme.success),
            ],
          ),
        ],
      );
    }

    return MyCard(
      shadow: MyShadow(elevation: 0.5, position: MyShadowPosition.bottom),
      paddingAll: 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.bodyMedium("Latest Transactions", fontWeight: 600), // Changed the title here
          MySpacing.height(24),
          recentActivityWidget("Bought Ethereum", "Credit Card ***3", "+1.5 ETH", "4800.00 USD", LucideIcons.circle_plus),
          MySpacing.height(24),
          recentActivityWidget("Sold Bitcoin", "Bank Account", "-0.03 BTC", "-650.20 USD", LucideIcons.circle_minus),
          MySpacing.height(24),
          recentActivityWidget("Transferred Ripple", "Crypto Wallet", "-500 XRP", "-125.30 USD", LucideIcons.circle_arrow_up),
          MySpacing.height(24),
          recentActivityWidget("Bought Solana", "PayPal", "+200 SOL", "3,980.10 USD", LucideIcons.circle_check),
          MySpacing.height(24),
          recentActivityWidget("Sold Dogecoin", "Debit Card ***7", "-15,000 DOGE", "-1,200.50 USD", LucideIcons.circle_x),
        ],
      ),
    );
  }

  Widget topPerformers() {
    Widget topPerformersWidget(String coinName, String shortName, String price, String image) {
      return Row(
        children: [
          MyContainer(
            height: 44,
            width: 44,
            paddingAll: 0,
            child: Image.asset(image),
          ),
          MySpacing.width(24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText.bodyMedium(coinName, fontWeight: 600),
                MySpacing.height(4),
                MyText.bodySmall(shortName, fontWeight: 600, muted: true),
              ],
            ),
          ),
          MyText.bodyMedium(price, fontWeight: 600),
        ],
      );
    }

    return MyCard(
      shadow: MyShadow(elevation: 0.5, position: MyShadowPosition.bottom),
      paddingAll: 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.bodyMedium("Top Performance", fontWeight: 600),
          MySpacing.height(24),
          topPerformersWidget("Bitcoin", "BTC", "\$45,000", "assets/images/coin/bitcoin.png"),
          MySpacing.height(24),
          topPerformersWidget("Chainlink", "LINK", "\$25.50", "assets/images/coin/chainlink.png"),
          MySpacing.height(24),
          topPerformersWidget("Dogecoin", "DOGE", "\$0.25", "assets/images/coin/dogecoin.png"),
          MySpacing.height(24),
          topPerformersWidget("Ethereum", "ETH", "\$3,200", "assets/images/coin/ethereum.png"),
          MySpacing.height(24),
          topPerformersWidget("Polkadot", "DOT", "\$12.75", "assets/images/coin/polkadot.png"),
        ],
      ),
    );
  }

  Widget transactionHistory() {
    Widget transactionHistoryWidget(String coinName, String date, String buyPrice, IconData icon) {
      return Row(
        children: [
          MyContainer(
            height: 44,
            width: 44,
            paddingAll: 0,
            color: contentTheme.primary.withValues(alpha: 0.2),
            child: Icon(icon, size: 20, color: contentTheme.primary),
          ),
          MySpacing.width(24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText.bodyMedium(coinName, fontWeight: 600),
                MySpacing.height(4),
                MyText.bodySmall(date, fontWeight: 600, muted: true),
              ],
            ),
          ),
          MyText.bodyMedium(buyPrice, fontWeight: 600),
        ],
      );
    }

    return MyCard(
      shadow: MyShadow(elevation: 0.5, position: MyShadowPosition.bottom),
      paddingAll: 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.bodyMedium("Transaction History", fontWeight: 600),
          MySpacing.height(24),
          transactionHistoryWidget("Sent BTC", "20 November 2024 3:00 PM", "0.075 BTC", LucideIcons.send), // Changed to 'send' icon
          MySpacing.height(24),
          transactionHistoryWidget("Received ETH", "19 November 2024 10:15 AM", "1.0 ETH", LucideIcons.download), // Changed to 'download' icon
          MySpacing.height(24),
          transactionHistoryWidget("Sent LTC", "18 November 2024 4:45 PM", "0.5 LTC", LucideIcons.upload), // Changed to 'upload' icon
          MySpacing.height(24),
          transactionHistoryWidget("Received ADA", "17 November 2024 9:00 AM", "800 ADA", LucideIcons.circle_arrow_down), // Changed to 'arrow_down_circle' icon
          MySpacing.height(24),
          transactionHistoryWidget("Sent DOGE", "16 November 2024 12:30 PM", "5,000 DOGE", LucideIcons.circle_arrow_up), // Changed to 'arrow_up_circle' icon
        ],
      ),
    );
  }

  Widget marketOverview() {
    return MyCard(
      shadow: MyShadow(elevation: 0.5, position: MyShadowPosition.bottom),
      paddingAll: 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: MyText.bodyMedium("Market Overview", fontWeight: 600)),
              PopupMenuButton(
                onSelected: controller.onSelectIntervalType,
                itemBuilder: (BuildContext context) {
                  return DateTimeIntervalType.values.map((behavior) {
                    return PopupMenuItem(
                      value: behavior,
                      height: 32,
                      child: MyText.bodySmall(
                        behavior.toString().split('.').last.capitalize.toString(),
                        color: theme.colorScheme.onSurface,
                        fontWeight: 600,
                      ),
                    );
                  }).toList();
                },
                color: theme.cardTheme.color,
                child: MyContainer.bordered(
                  padding: MySpacing.xy(8, 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      MyText.labelSmall(controller.intervalType.toString().split('.').last.capitalize.toString(), color: theme.colorScheme.onSurface),
                      Icon(LucideIcons.chevron_down, size: 16, color: theme.colorScheme.onSurface)
                    ],
                  ),
                ),
              ),
            ],
          ),
          MySpacing.height(24),
          SfCartesianChart(
              plotAreaBorderWidth: 0,
              primaryXAxis: DateTimeAxis(
                  autoScrollingMode: AutoScrollingMode.start,
                  dateFormat: DateFormat.MMM(),
                  intervalType: controller.intervalType,
                  minimum: DateTime(2016),
                  maximum: DateTime(2016, 10),
                  majorGridLines: const MajorGridLines(width: 0)),
              primaryYAxis: const NumericAxis(minimum: 80, maximum: 120, labelFormat: r'${value}', axisLine: AxisLine(width: 0)),
              series: _getCandleSeries(),
              trackballBehavior: controller.trackballBehavior,
              tooltipBehavior: TooltipBehavior(),
              zoomPanBehavior: ZoomPanBehavior(enableMouseWheelZooming: true, enablePinching: true, enablePanning: true, enableDoubleTapZooming: true)),
        ],
      ),
    );
  }

  List<CandleSeries<ChartSampleData, DateTime>> _getCandleSeries() {
    return <CandleSeries<ChartSampleData, DateTime>>[
      CandleSeries<ChartSampleData, DateTime>(
        enableSolidCandles: controller.enableSolidCandle,
        dataSource: <ChartSampleData>[
          ChartSampleData(x: DateTime(2016, 01, 11), open: 102.25, high: 105.75, low: 99.12, close: 101.50),
          ChartSampleData(x: DateTime(2016, 01, 18), open: 100.50, high: 106.15, low: 97.23, close: 104.20),
          ChartSampleData(x: DateTime(2016, 01, 25), open: 103.45, high: 104.10, low: 95.88, close: 99.95),
          ChartSampleData(x: DateTime(2016, 02, 01), open: 98.75, high: 100.60, low: 95.50, close: 97.20),
          ChartSampleData(x: DateTime(2016, 02, 08), open: 94.90, high: 98.40, low: 92.70, close: 94.10),
          ChartSampleData(x: DateTime(2016, 02, 15), open: 95.10, high: 99.50, low: 93.80, close: 97.85),
          ChartSampleData(x: DateTime(2016, 02, 22), open: 97.15, high: 99.80, low: 94.40, close: 98.60),
          ChartSampleData(x: DateTime(2016, 02, 29), open: 99.80, high: 105.00, low: 97.50, close: 104.00),
          ChartSampleData(x: DateTime(2016, 03, 07), open: 104.10, high: 107.50, low: 102.00, close: 105.75),
          ChartSampleData(x: DateTime(2016, 03, 14), open: 107.00, high: 108.20, low: 106.00, close: 107.10),
          ChartSampleData(x: DateTime(2016, 03, 21), open: 106.70, high: 109.50, low: 105.00, close: 107.50),
          ChartSampleData(x: DateTime(2016, 03, 28), open: 109.30, high: 112.00, low: 107.50, close: 110.75),
          ChartSampleData(x: DateTime(2016, 04, 04), open: 110.80, high: 113.50, low: 109.00, close: 111.00),
          ChartSampleData(x: DateTime(2016, 04, 11), open: 109.90, high: 113.20, low: 108.00, close: 110.30),
          ChartSampleData(x: DateTime(2016, 04, 18), open: 107.80, high: 109.80, low: 104.60, close: 106.50),
          ChartSampleData(x: DateTime(2016, 04, 25), open: 106.10, high: 107.40, low: 103.50, close: 105.00),
          ChartSampleData(x: DateTime(2016, 05, 02), open: 105.00, high: 107.80, low: 103.10, close: 104.25),
          ChartSampleData(x: DateTime(2016, 05, 09), open: 104.00, high: 105.00, low: 100.90, close: 102.50),
          ChartSampleData(x: DateTime(2016, 05, 16), open: 103.40, high: 106.20, low: 101.50, close: 104.80),
          ChartSampleData(x: DateTime(2016, 05, 23), open: 105.30, high: 109.50, low: 104.80, close: 107.40),
          ChartSampleData(x: DateTime(2016, 05, 30), open: 107.90, high: 109.00, low: 106.10, close: 107.50),
          ChartSampleData(x: DateTime(2016, 06, 06), open: 108.20, high: 111.40, low: 106.90, close: 109.00),
          ChartSampleData(x: DateTime(2016, 06, 13), open: 109.50, high: 111.00, low: 107.40, close: 109.90),
          ChartSampleData(x: DateTime(2016, 06, 20), open: 107.00, high: 108.50, low: 105.30, close: 107.80),
          ChartSampleData(x: DateTime(2016, 06, 27), open: 106.50, high: 109.00, low: 105.00, close: 107.10),
          ChartSampleData(x: DateTime(2016, 07, 04), open: 107.40, high: 109.00, low: 106.10, close: 107.60),
          ChartSampleData(x: DateTime(2016, 07, 11), open: 108.20, high: 110.50, low: 107.00, close: 108.80),
          ChartSampleData(x: DateTime(2016, 07, 18), open: 109.10, high: 110.90, low: 108.00, close: 109.50),
          ChartSampleData(x: DateTime(2016, 07, 25), open: 109.80, high: 112.00, low: 108.20, close: 110.50),
          ChartSampleData(x: DateTime(2016, 08, 01), open: 110.00, high: 113.00, low: 109.50, close: 111.80),
          ChartSampleData(x: DateTime(2016, 08, 08), open: 111.30, high: 113.80, low: 110.00, close: 112.60),
          ChartSampleData(x: DateTime(2016, 08, 15), open: 112.50, high: 115.00, low: 111.20, close: 113.50),
          ChartSampleData(x: DateTime(2016, 08, 22), open: 113.00, high: 116.00, low: 112.10, close: 114.70),
          ChartSampleData(x: DateTime(2016, 08, 29), open: 114.50, high: 116.50, low: 113.00, close: 115.00),
          ChartSampleData(x: DateTime(2016, 09, 05), open: 116.00, high: 118.00, low: 114.00, close: 116.50),
          ChartSampleData(x: DateTime(2016, 09, 12), open: 116.80, high: 119.20, low: 115.50, close: 118.50),
          ChartSampleData(x: DateTime(2016, 09, 19), open: 119.00, high: 120.00, low: 116.80, close: 118.90),
          ChartSampleData(x: DateTime(2016, 09, 26), open: 118.50, high: 120.20, low: 117.10, close: 119.00),
        ],
        showIndicationForSameValues: true,
        xValueMapper: (ChartSampleData sales, _) => sales.x as DateTime,
        lowValueMapper: (ChartSampleData sales, _) => sales.low,
        highValueMapper: (ChartSampleData sales, _) => sales.high,
        openValueMapper: (ChartSampleData sales, _) => sales.open,
        closeValueMapper: (ChartSampleData sales, _) => sales.close,
        spacing: 0.2,
        width: 0.8,
        borderRadius: BorderRadius.all(Radius.circular(4)),
      )
    ];
  }

  Widget cryptoStatistics() {
    return MyCard(
      shadow: MyShadow(elevation: 0.5, position: MyShadowPosition.bottom),
      paddingAll: 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.bodyMedium("Crypto Statistics", fontWeight: 600),
          MySpacing.height(24),
          SizedBox(
            height: 329,
            child: SfCartesianChart(
              margin: MySpacing.zero,
              plotAreaBorderWidth: 0,
              legend: Legend(isVisible: false, position: LegendPosition.bottom),
              primaryXAxis: const CategoryAxis(majorGridLines: MajorGridLines(width: 0), labelPlacement: LabelPlacement.onTicks),
              primaryYAxis: const NumericAxis(
                  axisLine: AxisLine(width: 0), edgeLabelPlacement: EdgeLabelPlacement.shift, labelFormat: '{value}', majorTickLines: MajorTickLines(size: 0)),
              series: [
                SplineSeries<ChartSampleData, String>(
                    dataSource: controller.chartData,
                    xValueMapper: (ChartSampleData sales, _) => sales.x as String,
                    yValueMapper: (ChartSampleData sales, _) => sales.y,
                    markerSettings: const MarkerSettings(isVisible: true),
                    color: contentTheme.success,
                    name: 'High'),
                SplineSeries<ChartSampleData, String>(
                  dataSource: controller.chartData,
                  name: 'Low',
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

  Widget activeOverallGrowth() {
    return MyCard(
      shadow: MyShadow(elevation: 0.5, position: MyShadowPosition.bottom),
      paddingAll: 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.bodyMedium("Active Overall Growth", fontWeight: 600),
          MySpacing.height(24),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
                sortAscending: true,
                columnSpacing: 170,
                onSelectAll: (_) => {},
                headingRowColor: WidgetStatePropertyAll(contentTheme.primary.withAlpha(40)),
                dataRowMaxHeight: 60,
                showBottomBorder: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                border: TableBorder.all(borderRadius: BorderRadius.circular(4), style: BorderStyle.solid, width: .4, color: Colors.grey),
                columns: [
                  DataColumn(label: MyText.labelLarge('Type', color: contentTheme.primary)),
                  DataColumn(label: MyText.labelLarge('Assets', color: contentTheme.primary)),
                  DataColumn(label: MyText.labelLarge('Date', color: contentTheme.primary)),
                  DataColumn(label: MyText.labelLarge('IP Address', color: contentTheme.primary)),
                  DataColumn(label: MyText.labelLarge('Status', color: contentTheme.primary)),
                  DataColumn(label: MyText.labelLarge('Amount', color: contentTheme.primary)),
                ],
                rows: controller.coinGrowth
                    .mapIndexed((index, data) => DataRow(cells: [
                          DataCell(MyText.labelMedium('Exchange')),
                          DataCell(MyText.labelMedium('${data.asset}')),
                          DataCell(MyText.labelMedium('${Utils.getDateTimeStringFromDateTime(data.date)}')),
                          DataCell(MyText.labelMedium('${data.ipAddress}')),
                          DataCell(MyContainer(
                              paddingAll: 4,
                              color: data.status == 'Success' ? contentTheme.success : contentTheme.danger,
                              child: MyText.labelMedium('${data.status}', color: data.status == 'Success' ? contentTheme.onSuccess : contentTheme.onDanger))),
                          DataCell(MyText.labelMedium('\$${data.amount}')),
                        ]))
                    .toList()),
          ),
        ],
      ),
    );
  }
}
