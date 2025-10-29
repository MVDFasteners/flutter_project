// import 'package:flatten/controllers/auth/login_controller.dart';
// import 'package:flatten/controllers/dashboard/dashboard_controller.dart';
// import 'package:flatten/controllers/other/syncfusion_charts_controller.dart';
// import 'package:flatten/helpers/extensions/string.dart';
// import 'package:flatten/helpers/theme/app_style.dart';
// import 'package:flatten/helpers/utils/mixins/ui_mixin.dart';
// import 'package:flatten/helpers/utils/my_shadow.dart';
// import 'package:flatten/helpers/widgets/my_breadcrumb.dart';
// import 'package:flatten/helpers/widgets/my_breadcrumb_item.dart';
// import 'package:flatten/helpers/widgets/my_button.dart';
// import 'package:flatten/helpers/widgets/my_card.dart';
// import 'package:flatten/helpers/widgets/my_container.dart';
// import 'package:flatten/helpers/widgets/my_flex.dart';
// import 'package:flatten/helpers/widgets/my_flex_item.dart';
// import 'package:flatten/helpers/widgets/my_list_extension.dart';
// import 'package:flatten/helpers/widgets/my_spacing.dart';
// import 'package:flatten/helpers/widgets/my_text.dart';
//
// import 'package:flatten/images.dart';
// import 'package:flatten/models/sales_team_summary.dart';
// import 'package:flatten/views/layouts/layout.dart';
// import 'package:flutter/material.dart';
// import 'package:get/instance_manager.dart';
// import 'package:get/state_manager.dart';
// import 'package:flutter_lucide/flutter_lucide.dart';
// import 'package:intl/intl.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
//
// class DashboardPage extends StatefulWidget {
//   const DashboardPage({super.key});
//
//   @override
//   DashboardPageState createState() => DashboardPageState();
// }
//
// class DashboardPageState extends State<DashboardPage>
//     with SingleTickerProviderStateMixin, UIMixin {
//   // late DashboardController controller;
//   final LoginController loginCtrl = Get.put(LoginController());
//
//   @override
//   void initState() {
//     super.initState();
//     // controller = Get.put(DashboardController());
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Layout(
//       anyWidget: SizedBox(
//         height: 40,
//         width: 300,
//         child: Opacity(
//           opacity: 1,
//           child: DropdownButtonFormField<String>(
//             value: controller.currentCompany,
//             dropdownColor: Colors.white,
//             items: controller.companyList
//                 .map(
//                   (item) => DropdownMenuItem<String>(
//                     value: item,
//                     child: Text(item, style: TextStyle(fontSize: 15)),
//                   ),
//                 )
//                 .toList(),
//             onChanged: (value) {
//               controller.onChangeDropDown(value);
//             },
//           ),
//         ),
//       ),
//       child: GetBuilder<DashboardController>(
//         init: controller,
//         builder: (controller) {
//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               IconButton(
//                 onPressed: () async {
//                   await loginCtrl.fetchUserByEmail(
//                     "jayasuryaarulselvam26@gmail.com",
//                   );
//
//                   // await controller.fetchSalesTeamSummary(
//                   //   company: "MVD FASTENERS PRIVATE LIMITED",
//                   //   fromDate: "2025.01.01",
//                   //   toDate: "2025.10.1",
//                   // );
//                 },
//
//                 icon: Icon(Icons.refresh),
//               ),
//               Padding(
//                 padding: MySpacing.x(flexSpacing),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     MyText.titleMedium(
//                       "dashboard".tr(),
//                       fontSize: 18,
//                       fontWeight: 600,
//                     ),
//                     MyBreadcrumb(
//                       children: [
//                         MyBreadcrumbItem(name: 'ecommerce'.tr()),
//                         MyBreadcrumbItem(name: 'dashboard'.tr(), active: true),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               MySpacing.height(flexSpacing),
//               Padding(
//                 padding: MySpacing.x(flexSpacing / 2),
//                 child: MyFlex(
//                   wrapAlignment: WrapAlignment.start,
//                   wrapCrossAlignment: WrapCrossAlignment.start,
//                   children: [
//                     MyFlexItem(
//                       sizes: "xl-3 lg-6 sm-6 md-6",
//                       child: MyCard(
//                         shadow: MyShadow(
//                           elevation: 0.5,
//                           position: MyShadowPosition.bottom,
//                         ),
//                         padding: MySpacing.xy(20, 20),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 MyText.headlineSmall(
//                                   (controller.salesValue ?? 0).toString(),
//                                   fontWeight: 600,
//                                 ),
//                                 MySpacing.height(4),
//                                 MyText.bodySmall(
//                                   "sales_value".tr().capitalizeWords,
//                                   muted: true,
//                                   fontWeight: 600,
//                                 ),
//                               ],
//                             ),
//                             MyContainer(
//                               color: contentTheme.primary.withAlpha(48),
//                               child: Icon(
//                                 Icons.sell,
//                                 color: contentTheme.primary,
//                                 size: 24,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     MyFlexItem(
//                       sizes: "xl-3 lg-6 sm-6 md-6",
//                       child: MyCard(
//                         shadow: MyShadow(
//                           elevation: 0.5,
//                           position: MyShadowPosition.bottom,
//                         ),
//                         padding: MySpacing.xy(20, 20),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 MyText.headlineSmall(
//                                   (controller.purchaseValue ?? 0).toString(),
//                                   fontWeight: 600,
//                                 ),
//                                 MySpacing.height(4),
//                                 MyText.bodySmall(
//                                   "purchase_value".tr().capitalizeWords,
//                                   muted: true,
//                                   fontWeight: 600,
//                                 ),
//                               ],
//                             ),
//                             MyContainer(
//                               color: contentTheme.success.withAlpha(48),
//                               child: Icon(
//                                 LucideIcons.shopping_cart,
//                                 color: contentTheme.success,
//                                 size: 24,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     MyFlexItem(
//                       sizes: "xl-3 lg-6 sm-6 md-6",
//                       child: MyCard(
//                         shadow: MyShadow(
//                           elevation: 0.5,
//                           position: MyShadowPosition.bottom,
//                         ),
//                         padding: MySpacing.xy(20, 20),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 MyText.headlineSmall(
//                                   (controller.paymentReceivedValue ?? 0)
//                                       .toString(),
//                                   fontWeight: 600,
//                                 ),
//                                 MySpacing.height(4),
//                                 MyText.bodySmall(
//                                   "payment_received".tr().capitalizeWords,
//                                   muted: true,
//                                   fontWeight: 600,
//                                 ),
//                               ],
//                             ),
//                             MyContainer(
//                               color: contentTheme.secondary.withAlpha(48),
//                               child: Icon(
//                                 Icons.payment,
//                                 color: contentTheme.secondary,
//                                 size: 24,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     MyFlexItem(
//                       sizes: "xl-3 lg-6 sm-6 md-6",
//                       child: MyCard(
//                         shadow: MyShadow(
//                           elevation: 0.5,
//                           position: MyShadowPosition.bottom,
//                         ),
//                         padding: MySpacing.xy(20, 20),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 MyText.headlineSmall(
//                                   (controller.paymentPaidValue ?? 0).toString(),
//                                   fontWeight: 600,
//                                 ),
//                                 MySpacing.height(4),
//                                 MyText.bodySmall(
//                                   "payment_paid".tr().capitalizeWords,
//                                   muted: true,
//                                   fontWeight: 600,
//                                 ),
//                               ],
//                             ),
//                             MyContainer(
//                               color: contentTheme.danger.withAlpha(48),
//                               child: Icon(
//                                 Icons.payment_outlined,
//                                 color: contentTheme.danger,
//                                 size: 26,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     MyFlexItem(
//                       sizes: 'lg-12 md-10',
//                       child: MyContainer(
//                         paddingAll: 24,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 MyText.titleMedium(
//                                   "Sales Summary",
//                                   wordSpacing: 0,
//                                   height: .9,
//                                   fontWeight: 600,
//                                 ),
//                                 _popUpMenuBuilderForYearlySummary(),
//                               ],
//                             ),
//                             MySpacing.height(20),
//                             buildDefaultColumnChart(),
//                           ],
//                         ),
//                       ),
//                     ),
//                     MyFlexItem(
//                       sizes: 'lg-6 md-6 sm-6',
//                       child: salesTeamPerformance1(controller),
//                     ),
//                     MyFlexItem(
//                       sizes: 'lg-6 md-6 sm-6',
//                       child: salesTeamPerformance2(controller),
//                     ),
//                     MyFlexItem(
//                       sizes: "lg-6 sm-12",
//                       child: MyCard(
//                         shadow: MyShadow(
//                           elevation: 0.5,
//                           position: MyShadowPosition.bottom,
//                         ),
//                         padding: MySpacing.xy(20, 20),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             MyText.titleMedium(
//                               "product_comparison".tr().capitalizeWords,
//                               fontWeight: 600,
//                             ),
//                             MySpacing.height(36),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 Column(
//                                   children: [
//                                     MyText.bodyMedium(
//                                       "${"product".tr()} 1",
//                                       muted: true,
//                                     ),
//                                     MySpacing.height(8),
//                                     Row(
//                                       mainAxisSize: MainAxisSize.min,
//                                       children: [
//                                         Icon(
//                                           LucideIcons.arrow_down,
//                                           size: 16,
//                                           color: contentTheme.danger,
//                                         ),
//                                         MySpacing.width(8),
//                                         MyText.bodyLarge(
//                                           '40.2%',
//                                           fontWeight: 600,
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                                 Column(
//                                   children: [
//                                     MyText.bodyMedium(
//                                       "${"product".tr()} 2",
//                                       muted: true,
//                                     ),
//                                     MySpacing.height(8),
//                                     Row(
//                                       mainAxisSize: MainAxisSize.min,
//                                       children: [
//                                         Icon(
//                                           LucideIcons.arrow_up,
//                                           size: 16,
//                                           color: contentTheme.primary,
//                                         ),
//                                         MySpacing.width(8),
//                                         MyText.bodyLarge(
//                                           '24.5%',
//                                           fontWeight: 600,
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                                 Column(
//                                   children: [
//                                     MyText.bodyMedium(
//                                       "${"Product".tr()} 3",
//                                       muted: true,
//                                     ),
//                                     MySpacing.height(8),
//                                     Row(
//                                       mainAxisSize: MainAxisSize.min,
//                                       children: [
//                                         Icon(
//                                           LucideIcons.arrow_down,
//                                           size: 16,
//                                           color: contentTheme.danger,
//                                         ),
//                                         MySpacing.width(8),
//                                         MyText.bodyLarge(
//                                           '32.5%',
//                                           fontWeight: 600,
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                             MySpacing.height(36),
//                             buildComparisonChart(),
//                           ],
//                         ),
//                       ),
//                     ),
//                     MyFlexItem(
//                       sizes: "lg-6 sm-12",
//                       child: MyCard(
//                         shadow: MyShadow(
//                           elevation: 0.5,
//                           position: MyShadowPosition.bottom,
//                         ),
//                         padding: MySpacing.xy(20, 20),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 MyText.titleMedium(
//                                   "trending_products".tr().capitalizeWords,
//                                   fontWeight: 600,
//                                 ),
//                                 MyButton.text(
//                                   onPressed: controller.goToProducts,
//                                   elevation: 6,
//                                   padding: MySpacing.xy(20, 16),
//                                   child: MyText.bodySmall(
//                                     'view_all'.tr().capitalizeWords,
//                                     color: contentTheme.primary,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             MySpacing.height(20),
//                             MyContainer.none(
//                               borderRadiusAll: 4,
//                               clipBehavior: Clip.antiAliasWithSaveLayer,
//                               child: SingleChildScrollView(
//                                 scrollDirection: Axis.horizontal,
//                                 child: DataTable(
//                                   sortAscending: true,
//                                   columnSpacing: 60,
//                                   onSelectAll: (_) => {},
//                                   headingRowColor: WidgetStatePropertyAll(
//                                     contentTheme.primary.withAlpha(40),
//                                   ),
//                                   dataRowMaxHeight: 60,
//                                   showBottomBorder: false,
//                                   columns: [
//                                     DataColumn(
//                                       label: MyText.labelLarge(
//                                         'id'.tr(),
//                                         color: contentTheme.primary,
//                                       ),
//                                     ),
//                                     DataColumn(
//                                       label: MyText.labelLarge(
//                                         'name'.tr(),
//                                         color: contentTheme.primary,
//                                       ),
//                                     ),
//                                     DataColumn(
//                                       label: MyText.labelLarge(
//                                         'price'.tr(),
//                                         color: contentTheme.primary,
//                                       ),
//                                     ),
//                                     DataColumn(
//                                       label: MyText.labelLarge(
//                                         'stock'.tr(),
//                                         color: contentTheme.primary,
//                                       ),
//                                     ),
//                                     DataColumn(
//                                       label: MyText.labelLarge(
//                                         'orders'.tr(),
//                                         color: contentTheme.primary,
//                                       ),
//                                     ),
//                                     DataColumn(
//                                       label: MyText.labelLarge(
//                                         'action'.tr(),
//                                         color: contentTheme.primary,
//                                       ),
//                                     ),
//                                   ],
//                                   rows: controller.products
//                                       .mapIndexed(
//                                         (index, data) => DataRow(
//                                           cells: [
//                                             DataCell(
//                                               MyText.bodyMedium('#${data.id}'),
//                                             ),
//                                             DataCell(
//                                               SizedBox(
//                                                 width: 220,
//                                                 child: Row(
//                                                   mainAxisSize:
//                                                       MainAxisSize.min,
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.center,
//                                                   children: [
//                                                     MyContainer.none(
//                                                       borderRadiusAll: 20,
//                                                       clipBehavior: Clip
//                                                           .antiAliasWithSaveLayer,
//                                                       child: Image.asset(
//                                                         Images
//                                                             .squareImages[index %
//                                                             Images
//                                                                 .squareImages
//                                                                 .length],
//                                                         height: 40,
//                                                         width: 40,
//                                                       ),
//                                                     ),
//                                                     MySpacing.width(16),
//                                                     Expanded(
//                                                       child: MyText.labelLarge(
//                                                         data.name.toString(),
//                                                         overflow: TextOverflow
//                                                             .ellipsis,
//                                                         maxLines: 1,
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ),
//                                             DataCell(
//                                               MyText.bodyMedium(
//                                                 '\$${data.price}',
//                                               ),
//                                             ),
//
//                                             DataCell(
//                                               MyText.bodyMedium(
//                                                 '${data.stock}',
//                                               ),
//                                             ),
//                                             DataCell(
//                                               MyText.bodyMedium(
//                                                 '${data.ordersCount}',
//                                               ),
//                                             ),
//
//                                             DataCell(
//                                               Align(
//                                                 alignment: Alignment.center,
//                                                 child: MyContainer.bordered(
//                                                   onTap: () => {},
//                                                   padding: MySpacing.xy(6, 6),
//                                                   borderColor: contentTheme
//                                                       .primary
//                                                       .withAlpha(40),
//                                                   child: Icon(
//                                                     LucideIcons.pencil,
//                                                     size: 14,
//                                                     color: contentTheme.primary,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                             // DataCell(MyText.bodyMedium('${DateTime.tryParse('2022-11-26T15:56:14Z')}')),
//                                           ],
//                                         ),
//                                       )
//                                       .toList(),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     MyFlexItem(
//                       sizes: "lg-6 sm-12",
//                       child: MyCard(
//                         shadow: MyShadow(
//                           elevation: 0.5,
//                           position: MyShadowPosition.bottom,
//                         ),
//                         padding: MySpacing.xy(20, 20),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 MyText.titleMedium(
//                                   "customers".tr(),
//                                   fontWeight: 600,
//                                 ),
//                                 MyButton.text(
//                                   onPressed: controller.goToCustomers,
//                                   elevation: 6,
//                                   padding: MySpacing.xy(20, 16),
//                                   child: MyText.bodySmall(
//                                     'view_all'.tr().capitalizeWords,
//                                     color: contentTheme.primary,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             MySpacing.height(20),
//                             MyContainer.none(
//                               borderRadiusAll: 4,
//                               clipBehavior: Clip.antiAliasWithSaveLayer,
//                               child: SingleChildScrollView(
//                                 scrollDirection: Axis.horizontal,
//                                 child: DataTable(
//                                   sortColumnIndex: 1,
//                                   columnSpacing: 50,
//                                   sortAscending: true,
//                                   onSelectAll: (_) => {},
//                                   headingRowColor: WidgetStatePropertyAll(
//                                     contentTheme.primary.withAlpha(40),
//                                   ),
//                                   // dataRowHeight: 60,
//                                   dataRowMaxHeight: 60,
//                                   showBottomBorder: false,
//                                   columns: [
//                                     DataColumn(
//                                       label: MyText.labelLarge(
//                                         'id'.tr(),
//                                         color: contentTheme.primary,
//                                       ),
//                                     ),
//                                     DataColumn(
//                                       label: MyText.labelLarge(
//                                         'name'.tr(),
//                                         color: contentTheme.primary,
//                                       ),
//                                     ),
//                                     DataColumn(
//                                       label: MyText.labelLarge(
//                                         'phone'.tr(),
//                                         color: contentTheme.primary,
//                                       ),
//                                     ),
//                                     DataColumn(
//                                       label: MyText.labelLarge(
//                                         'balance'.tr(),
//                                         color: contentTheme.primary,
//                                       ),
//                                     ),
//                                     DataColumn(
//                                       label: MyText.labelLarge(
//                                         'orders'.tr(),
//                                         color: contentTheme.primary,
//                                       ),
//                                     ),
//                                     DataColumn(
//                                       label: MyText.labelLarge(
//                                         'action'.tr(),
//                                         color: contentTheme.primary,
//                                       ),
//                                     ),
//                                   ],
//                                   rows: controller.customers
//                                       .mapIndexed(
//                                         (index, data) => DataRow(
//                                           cells: [
//                                             DataCell(
//                                               MyText.bodyMedium("#${data.id}"),
//                                             ),
//                                             DataCell(
//                                               SizedBox(
//                                                 width: 180,
//                                                 child: Row(
//                                                   mainAxisSize:
//                                                       MainAxisSize.min,
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.center,
//                                                   children: [
//                                                     MyContainer.none(
//                                                       borderRadiusAll: 20,
//                                                       clipBehavior: Clip
//                                                           .antiAliasWithSaveLayer,
//                                                       child: Image.asset(
//                                                         Images.avatars[index %
//                                                             Images
//                                                                 .avatars
//                                                                 .length],
//                                                         height: 40,
//                                                         width: 40,
//                                                       ),
//                                                     ),
//                                                     MySpacing.width(12),
//                                                     Expanded(
//                                                       child: MyText.labelLarge(
//                                                         data.fullName,
//                                                         maxLines: 1,
//                                                         overflow: TextOverflow
//                                                             .ellipsis,
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ),
//                                             DataCell(
//                                               MyText.bodyMedium(
//                                                 '${data.phoneNumber}',
//                                               ),
//                                             ),
//                                             DataCell(
//                                               MyText.bodyMedium(
//                                                 '\$${data.balance}',
//                                               ),
//                                             ),
//                                             DataCell(
//                                               MyText.bodyMedium(
//                                                 '${data.ordersCount}',
//                                               ),
//                                             ),
//                                             DataCell(
//                                               Align(
//                                                 alignment: Alignment.center,
//                                                 child: MyContainer.bordered(
//                                                   onTap: () => {},
//                                                   padding: MySpacing.xy(6, 6),
//                                                   borderColor: contentTheme
//                                                       .primary
//                                                       .withAlpha(40),
//                                                   child: Icon(
//                                                     LucideIcons.pencil,
//                                                     size: 14,
//                                                     color: contentTheme.primary,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       )
//                                       .toList(),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
//
//   Widget salesTeamPerformance1(DashboardController controller) {
//     return MyCard(
//       shadow: MyShadow(elevation: 0.5, position: MyShadowPosition.bottom),
//       paddingAll: 24,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           MyText.bodyMedium("Sales Team Wise", fontWeight: 600),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               TextButton.icon(
//                 icon: Icon(Icons.date_range),
//                 onPressed: () async {
//                   DateTimeRange<DateTime>? value = await _selectDateRange(
//                     context,
//                   );
//                   print(value);
//                   await controller.onSelectYearlyTeamSummary(value!);
//                 },
//                 label: Text("Select Date"),
//               ),
//               // _datePicker(context)
//             ],
//           ),
//
//           controller.salesTeamSummary.data != null &&
//                   controller.salesTeamSummary.data!.isEmpty
//               ? Text("No Data")
//               : SfCircularChart(
//                   margin: MySpacing.zero,
//                   legend: Legend(
//                     isVisible: true,
//                     overflowMode: LegendItemOverflowMode.wrap,
//                     position: LegendPosition.bottom,
//                   ),
//                   series: [
//                     PieSeries<ChartSampleData, String>(
//                       dataSource: salesTeamPerformance1Widget(
//                         controller.salesTeamSummary,
//                       ),
//                       // <ChartSampleData>[
//                       //   // ..._salesTeamDynamicData(controller),
//                       //   ChartSampleData(x: 'USA', y: 700000, text: '60%'),
//                       //   ChartSampleData(x: 'Germany', y: 450000, text: '50%'),
//                       //   ChartSampleData(x: 'China', y: 600000, text: '65%'),
//                       //   ChartSampleData(x: 'India', y: 400000, text: '55%'),
//                       //   ChartSampleData(x: 'Brazil', y: 350000, text: '40%'),
//                       //   ChartSampleData(x: 'Russia', y: 300000, text: '35%'),
//                       //   ChartSampleData(x: 'South Africa', y: 250000, text: '30%'),
//                       // ],
//                       xValueMapper: (ChartSampleData data, _) => data.x,
//                       yValueMapper: (ChartSampleData data, _) => data.y,
//                       dataLabelMapper: (ChartSampleData data, _) => data.x,
//                       startAngle: 100,
//                       endAngle: 100,
//                       radius: '80%',
//                       explode: true,
//                       // 👈 explode slice
//                       explodeAll: true,
//                       pointRadiusMapper: (ChartSampleData data, _) => data.text,
//                       dataLabelSettings: const DataLabelSettings(
//                         isVisible: true,
//                         labelPosition: ChartDataLabelPosition.outside,
//                       ),
//                     ),
//                   ],
//                   tooltipBehavior: TooltipBehavior(
//                     enable: true,
//                     tooltipPosition: TooltipPosition.auto,
//                   ),
//                 ),
//         ],
//       ),
//     );
//   }
//
//   Widget salesTeamPerformance2(DashboardController controller) {
//     return MyCard(
//       shadow: MyShadow(elevation: 0.5, position: MyShadowPosition.bottom),
//       paddingAll: 24,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               MyText.bodyMedium("Target Vs Achieved", fontWeight: 600),
//               Spacer(),
//               Text(
//                 (controller.salesTeamSummary.data?[0].targetValue ?? 0)
//                     .toString(),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 299,
//             child:
//                 controller.salesTeamSummary.data != null &&
//                     controller.salesTeamSummary.data!.isEmpty
//                 ? Text("No Data")
//                 : SfCircularChart(
//                     margin: MySpacing.zero,
//                     series: [
//                       RadialBarSeries<ChartSampleData, String>(
//                         maximumValue: 100,
//                         dataLabelSettings: const DataLabelSettings(
//                           isVisible: true,
//                           textStyle: TextStyle(fontSize: 10.0),
//                         ),
//                         dataSource: salesTeamPerformance2Widget(
//                           controller.salesTeamSummary,
//                         ),
//
//                         // dataSource: <ChartSampleData>[
//                         //   ChartSampleData(
//                         //     x: 'Complete',
//                         //     y: 7,
//                         //     text: '100%',
//                         //     pointColor: contentTheme.primary,
//                         //   ),
//                         //   ChartSampleData(
//                         //     x: 'Active',
//                         //     y: 5,
//                         //     text: '100%',
//                         //     pointColor: contentTheme.success,
//                         //   ),
//                         //   ChartSampleData(
//                         //     x: 'Assigned',
//                         //     y: 8,
//                         //     text: '100%',
//                         //     pointColor: contentTheme.info,
//                         //   ),
//                         // ],
//                         cornerStyle: CornerStyle.bothCurve,
//                         gap: '5%',
//                         radius: '100%',
//                         innerRadius: '30%',
//
//                         xValueMapper: (ChartSampleData data, _) =>
//                             data.x as String,
//                         yValueMapper: (ChartSampleData data, _) => data.y,
//                         pointRadiusMapper: (ChartSampleData data, _) =>
//                             data.text,
//                         pointColorMapper: (ChartSampleData data, _) =>
//                             data.pointColor,
//                         dataLabelMapper: (ChartSampleData data, _) =>
//                             data.x as String,
//                       ),
//                     ],
//                     tooltipBehavior: controller.tooltipBehavior,
//                   ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // ChartSampleData(
//   // x: 'Assigned',
//   // y: 8,
//   // text: '100%',
//   // pointColor: contentTheme.info,
//   // ),
//
//   List<ChartSampleData> salesTeamPerformance2Widget(SalesTeamSummary summary) {
//     return summary.data!.map((e) {
//       // Avoid division by zero
//       double target = (e.targetValue ?? 0).toDouble();
//       double achieved = (e.totalBilled ?? 0).toDouble();
//
//       double percent = target > 0 ? (achieved / target) * 100 : 0;
//
//       print(
//         "${e.salesPersonName} → ${percent.toStringAsFixed(1)}% (${achieved}/${target})",
//       );
//
//       return ChartSampleData(
//         x: e.salesPersonName,
//         y: percent, // ✅ percentage value for radial fill
//         text: "${percent.toStringAsFixed(1)}%", // visible label
//         pointColor: contentTheme.info,
//       );
//     }).toList();
//   }
//
//   List<ChartSampleData> salesTeamPerformance1Widget(SalesTeamSummary summary) {
//     return summary.data!.map((e) {
//       double percent = (e.totalBilled! / summary.totalBilled!.toDouble()) * 100;
//       print("$percent - ${e.salesPersonName} - ${e.totalBilled}");
//       print("${summary.totalBilled!.toDouble()}");
//
//       return ChartSampleData(
//         x: e.salesPersonName,
//         y: e.totalBilled,
//         text: '${percent.toStringAsFixed(1)}%',
//       );
//     }).toList();
//   }
//
//   // List<ChartSampleData> getChartDataSales(SalesTeamSummary summary) {
//   //   return summary.data!.map((e) {
//   //     double percent = (e.totalBilled! / summary.totalBilled!.toDouble()) * 100;
//   //     print("$percent - ${e.salesPersonName} - ${e.totalBilled}");
//   //     print("${summary.totalBilled!.toDouble()}");
//   //
//   //     return ChartSampleData(
//   //       x: e.salesPersonName,
//   //       y: e.totalBilled,
//   //       text: '${percent.toStringAsFixed(1)}%',
//   //     );
//   //   }).toList();
//   // }
//
//   // List<ChartSampleData> _salesTeamDynamicData(DashboardController controller) {
//   //   List<ChartSampleData> chartData = [];
//   //   List<String> percents = ["60%", "50%", "45%", "20%"];
//   //   if (controller.salesTeamSummary.data != null) {
//   //     for (int i = 0; i < controller.salesTeamSummary.data!.length; i++) {
//   //       chartData.add(
//   //         ChartSampleData(
//   //           x: controller.salesTeamSummary.data![i].salesPersonId,
//   //           y: controller.salesTeamSummary.data![i].totalBilled,
//   //           text: '60%',
//   //         ),
//   //       );
//   //     }
//   //   }
//   //   return chartData;
//   // }
//
//   Future<DateTimeRange?> _selectDateRange(BuildContext context) async {
//     final DateTimeRange? picked = await showDateRangePicker(
//       context: context,
//       firstDate: DateTime(2024),
//       lastDate: DateTime(2101),
//       builder: (context, child) {
//         return Center(
//           child: ConstrainedBox(
//             constraints: const BoxConstraints(maxWidth: 400, maxHeight: 500),
//             child: Material(
//               borderRadius: BorderRadius.circular(16),
//               clipBehavior: Clip.antiAlias,
//               child: child!,
//             ),
//           ),
//         );
//       },
//     );
//     if (picked != null) {
//       print("From: ${picked.start}");
//       print("To: ${picked.end}");
//     }
//     return picked;
//   }
//
//   SfCartesianChart buildDefaultColumnChart() {
//     return SfCartesianChart(
//       plotAreaBorderWidth: 0,
//       primaryXAxis: CategoryAxis(majorGridLines: MajorGridLines(width: 0)),
//       primaryYAxis: NumericAxis(
//         axisLine: AxisLine(width: 0),
//         labelFormat: '{value}',
//         majorTickLines: MajorTickLines(size: 0),
//       ),
//       series: controller.getDefaultColumnSeries(),
//       tooltipBehavior: controller.tooltipBehavior,
//     );
//   }
//
//   Widget _popUpMenuBuilderForYearlySummary() {
//     final currentYear = DateTime.now().year;
//     final currentMonth = DateTime.now().month;
//
//     final lastFyStartYear = currentMonth >= 4 ? currentYear : currentYear - 1;
//     final startYear = 2024;
//
//     // 🟢 Available financial years
//     final List<String> financialYears = [
//       for (int y = startYear; y <= lastFyStartYear; y++) "$y-${y + 1}",
//     ];
//
//     controller.salesYearlySummary ??= financialYears.first;
//
//     return PopupMenuButton<String>(
//       onSelected: controller.onSelectYearlySummary,
//       itemBuilder: (BuildContext context) {
//         return financialYears.map((fy) {
//           return PopupMenuItem<String>(
//             value: fy,
//             height: 32,
//             child: MyText.bodySmall(
//               fy,
//               color: Theme.of(context).colorScheme.onSurface,
//               fontWeight: 600,
//             ),
//           );
//         }).toList();
//       },
//       color: theme.cardTheme.color,
//       child: MyContainer.bordered(
//         padding: MySpacing.xy(12, 4),
//         clipBehavior: Clip.antiAliasWithSaveLayer,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: <Widget>[
//             MyText.labelMedium(
//               controller.salesYearlySummary ?? financialYears.first,
//               color: contentTheme.onBackground,
//             ),
//             MySpacing.width(4),
//             Icon(
//               LucideIcons.chevron_down,
//               size: 20,
//               color: contentTheme.onBackground,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget buildRevenueChart() {
//     List<SplineSeries<ChartSampleData, DateTime>> getDefaultAreaSeries() {
//       return <SplineSeries<ChartSampleData, DateTime>>[
//         SplineSeries<ChartSampleData, DateTime>(
//           dataSource: controller.revenueChartData,
//           opacity: 0.7,
//           name: '${'Product'.tr()} A',
//           color: contentTheme.primary.withAlpha(150),
//           xValueMapper: (ChartSampleData sales, _) => sales.x as DateTime,
//           yValueMapper: (ChartSampleData sales, _) => sales.y,
//         ),
//         SplineSeries<ChartSampleData, DateTime>(
//           dataSource: controller.revenueChartData,
//           opacity: 0.7,
//           name: '${'Product'.tr()} B',
//           color: contentTheme.danger.withAlpha(150),
//           xValueMapper: (ChartSampleData sales, _) => sales.x as DateTime,
//           yValueMapper: (ChartSampleData sales, _) => sales.secondSeriesYValue,
//         ),
//       ];
//     }
//
//     return SizedBox(
//       height: 400,
//       child: SfCartesianChart(
//         legend: Legend(opacity: 0.7, position: LegendPosition.bottom),
//         plotAreaBorderWidth: 0,
//         primaryXAxis: DateTimeAxis(
//           interval: 1,
//           intervalType: DateTimeIntervalType.months,
//           majorGridLines: const MajorGridLines(width: 1),
//           axisLine: AxisLine(width: 0),
//           edgeLabelPlacement: EdgeLabelPlacement.shift,
//         ),
//         primaryYAxis: NumericAxis(
//           labelFormat: '{value}',
//           //title: AxisTitle(text: 'Revenue in millions'),
//           interval: 4,
//           axisLine: const AxisLine(width: 0),
//           minimum: 16,
//           majorGridLines: const MajorGridLines(width: 0),
//           majorTickLines: const MajorTickLines(
//             size: 16,
//             width: 0,
//             color: Colors.transparent,
//           ),
//         ),
//         series: getDefaultAreaSeries(),
//         tooltipBehavior: TooltipBehavior(enable: true),
//       ),
//     );
//   }
//
//   Widget buildComparisonChart() {
//     List<ColumnSeries<ChartSampleData, DateTime>> getDefaultAreaSeries() {
//       return <ColumnSeries<ChartSampleData, DateTime>>[
//         ColumnSeries<ChartSampleData, DateTime>(
//           dataSource: controller.comparisonChartData,
//           opacity: 0.7,
//           name: '${'Product'.tr()} A',
//           width: 0.2,
//           color: contentTheme.primary.withAlpha(150),
//           xValueMapper: (ChartSampleData sales, _) => sales.x as DateTime,
//           yValueMapper: (ChartSampleData sales, _) => sales.y,
//         ),
//         ColumnSeries<ChartSampleData, DateTime>(
//           dataSource: controller.comparisonChartData,
//           opacity: 0.7,
//           name: '${'Product'.tr()} B',
//           width: 0.2,
//           color: contentTheme.danger.withAlpha(150),
//           xValueMapper: (ChartSampleData sales, _) => sales.x as DateTime,
//           yValueMapper: (ChartSampleData sales, _) => sales.secondSeriesYValue,
//         ),
//       ];
//     }
//
//     return SizedBox(
//       height: 400,
//       child: SfCartesianChart(
//         legend: Legend(opacity: 0.7, position: LegendPosition.bottom),
//         plotAreaBorderWidth: 0,
//         primaryXAxis: DateTimeAxis(
//           interval: 1,
//           intervalType: DateTimeIntervalType.days,
//           majorGridLines: const MajorGridLines(width: 1),
//           axisLine: AxisLine(width: 0),
//           edgeLabelPlacement: EdgeLabelPlacement.shift,
//         ),
//         primaryYAxis: NumericAxis(
//           labelFormat: '{value}',
//           //title: AxisTitle(text: 'Revenue in millions'),
//           interval: 4,
//           minimum: 8,
//           axisLine: const AxisLine(width: 0),
//           majorGridLines: const MajorGridLines(width: 0),
//           majorTickLines: const MajorTickLines(
//             size: 16,
//             width: 0,
//             color: Colors.transparent,
//           ),
//         ),
//         series: getDefaultAreaSeries(),
//         tooltipBehavior: TooltipBehavior(enable: true),
//       ),
//     );
//   }
// }
