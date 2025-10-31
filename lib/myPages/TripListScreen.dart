import 'package:flatten/app_constant.dart';
import 'package:flatten/controllers/mycontroller/place_list_controller.dart';
import 'package:flatten/controllers/mycontroller/trip_list_controller.dart';
import 'package:flatten/helpers/extensions/extensions.dart';
import 'package:flatten/helpers/theme/app_style.dart';
import 'package:flatten/helpers/utils/mixins/ui_mixin.dart';
import 'package:flatten/helpers/utils/my_shadow.dart';
import 'package:flatten/helpers/widgets/my_card.dart';
import 'package:flatten/helpers/widgets/my_container.dart';
import 'package:flatten/helpers/widgets/my_spacing.dart';
import 'package:flatten/helpers/widgets/my_text.dart';
import 'package:flatten/models/trip_list.dart';
import 'package:flatten/myPages/locaiton_service.dart';
import 'package:flatten/myPages/myScreenList.dart';
import 'package:flatten/myPages/placeList.dart';
import 'package:flatten/responsive.dart';
import 'package:flatten/views/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:flatten/controllers/mycontroller/trip_images_controller.dart';

class TripListScreen extends StatefulWidget {
  @override
  State<TripListScreen> createState() => _TripListScreenState();
}

class _TripListScreenState extends State<TripListScreen>
    with SingleTickerProviderStateMixin, UIMixin {
  final TripListController controller = Get.put(TripListController());
  final ScrollController scrollController = ScrollController();
  final LocationService locationService = LocationService();
  final PlaceListController placeListController = Get.put(
    PlaceListController(),
  );
  final TripImagesController tripImageCtrl = Get.put(TripImagesController());

  @override
  Widget build(BuildContext context) {
    return Layout(
      leadingWidget: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back),
      ),
      floatingAction: GetBuilder(
        init: controller,
        builder: (controller) {
          return controller.isFetchLoading
              ? SizedBox(
                  height: 40,
                  width: 40,
                  child: CircularProgressIndicator(),
                )
              : FloatingActionButton(
                  backgroundColor: AppTheme.primaryColor,
                  child: Icon(Icons.add),
                  onPressed: () async {
                    await controller.initLoadDateLocation();
                    await _newStartTrip(context, controller: controller);
                  },
                );
        },
      ),
      scrollNeed: false,
      anyWidget: IconButton(
        onPressed: () async {
          await controller.fetchTripListWithFilters();
        },
        icon: Icon(Icons.refresh),
      ),
      child: GetBuilder<TripListController>(
        builder: (controller) {
          if (controller.travelLogs.isEmpty && controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          // return Container(color: Colors.green, height: 50);
          return Column(
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          MyText.titleMedium(
                            "TRIP LIST".tr(),
                            fontSize: 18,
                            fontWeight: 600,
                          ),
                          Spacer(),
                          IconButton(
                            onPressed: () async {
                              await controller.fetchTripListWithFilters();
                            },
                            icon: Icon(Icons.refresh),
                          ),
                          _popUpMenuBuilderForYearlySummary(controller),
                          MySpacing.width(flexSpacing),
                          _popUpMenuBuilderForMonthlySummary(controller),
                        ],
                      ),
                      Row(children: [..._halfPermission(controller)]),
                      // Expanded(
                      //   flex: 1,
                      //   child: Row(
                      //     children: [
                      //       MyText.titleMedium(
                      //         "TRIP LIST".tr(),
                      //         fontSize: 18,
                      //         fontWeight: 600,
                      //       ),
                      //       Spacer(),
                      //       IconButton(
                      //         onPressed: () async {
                      //           await controller.fetchTripListWithFilters();
                      //         },
                      //         icon: Icon(Icons.refresh),
                      //       ),
                      //       _popUpMenuBuilderForYearlySummary(controller),
                      //       MySpacing.width(flexSpacing),
                      //       _popUpMenuBuilderForMonthlySummary(controller),
                      //     ],
                      //   ),
                      // ),
                      // MySpacing.height(flexSpacing),
                      // Expanded(
                      //   flex: 3,
                      //   child: Row(children: [..._halfPermission(controller)]),
                      // ),
                    ],
                  ),
                ),
              ),
              MySpacing.height(flexSpacing),
              Expanded(
                flex: 4,
                child: RefreshIndicator(
                  onRefresh: controller.fetchTripListWithFilters,
                  child: ListView.builder(
                    // controller: controller.scrollController,
                    itemCount:
                        // controller.hasMore
                        //     ? controller.travelLogs.length + 1
                        //     :
                        controller.travelLogs.length,
                    itemBuilder: (context, index) {
                      // if (index < controller.travelLogs.length) {
                      Trip log = controller.travelLogs[index];
                      String startDate = "---";
                      String endDate = "---";

                      if (log.startDate != null && log.startDate != "") {
                        startDate = calculateTime(log.startDate!);
                      }
                      if (log.endDate != null && log.endDate != "") {
                        endDate = calculateTime(log.endDate!);
                      }

                      return InkWell(
                        onTap: () async {
                          controller.updateCurrentTrip(log);

                          if (log.name != null) {
                            placeListController.updateCurrentTrip(log);
                            tripImageCtrl.updateCurrentTrip(log);

                            await placeListController.fetchRoutesList(
                              parentId: log.name!,
                            );

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PlaceList(),
                              ),
                            );
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: stateCardDetail(
                            distanceTraveled:
                                "Distance ${(log.totalDistance ?? 0).toString()}",
                            status: log.status ?? "Pending",
                            tripId: "Trip Id : ${log.name}",
                            startDate: "Start : $startDate",
                            endDate: "End    : $endDate",
                          ),
                        ),
                      );
                      // } else {
                      //   return const Padding(
                      //     padding: EdgeInsets.all(8.0),
                      //     child: Center(child: CircularProgressIndicator()),
                      //   );
                      // }
                      // Trip log = controller.travelLogs[index];
                      // String startDate = "Null";
                      // String endDate = "Null";
                      // if (log.startDate != null && log.startDate != "") {
                      //   startDate = calculateTime(log.startDate!);
                      //   endDate = calculateTime(log.endDate!);
                      // }
                      //
                      // if (index < controller.travelLogs.length) {
                      //   return InkWell(
                      //     onTap: () {},
                      //     child: Padding(
                      //       padding: const EdgeInsets.only(bottom: 12),
                      //       child: stateCardDetail(
                      //         distanceTraveled:
                      //             "Distance ${(log.totalDistance ?? 0).toString()}",
                      //         status: log.status ?? "Pending",
                      //         tripId: "Trip Id : ${log.name}",
                      //         startDate: "Start : $startDate",
                      //         endDate: "End    : $endDate",
                      //       ),
                      //     ),
                      //   );
                      // } else {
                      //   return const Padding(
                      //     padding: EdgeInsets.all(8.0),
                      //     child: Center(child: CircularProgressIndicator()),
                      //   );
                      // }
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<dynamic> _newStartTrip(
    context, {
    required TripListController controller,
  }) async {
    return showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text(
            "Start a New Trip",
            style: TextStyle(color: Colors.red, fontSize: 25),
          ),
          content: SingleChildScrollView(
            // ✅ scrollable if content grows
            child: ConstrainedBox(
              // ✅ limit height
              constraints: const BoxConstraints(maxHeight: 300),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text("       Date : "),
                      Expanded(
                        child: TextField(
                          readOnly: true,
                          controller: controller.dateCtrl,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Text("Location : "),
                      Expanded(
                        child: TextField(
                          readOnly: true,
                          maxLines: 3,
                          controller: controller.locationCtrl,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () async {
                await controller.saveTripParent();
                Navigator.pop(context);
              },
              child: const Text("Get Start", style: TextStyle(fontSize: 16)),
            ),
          ],
        );
      },
    );
  }

  Widget stateCardDetail({
    required String tripId,
    required String startDate,
    required String endDate,
    required String distanceTraveled,
    required String status,
  }) {
    return MyContainer(
      height: 165,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MyText.titleMedium(tripId, fontWeight: 600),
          MyText.titleLarge(startDate, fontWeight: 700),
          MyText.titleLarge(endDate, fontWeight: 700),
          Row(
            children: [
              MyText.bodyMedium(
                distanceTraveled,
                fontWeight: 600,
                color: Colors.red,
              ),
              Spacer(),
              MyContainer(
                paddingAll: 8,
                color: contentTheme.success.withAlpha(36),
                child: MyText.bodySmall(
                  status,
                  fontWeight: 700,
                  color: contentTheme.success,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _halfPermission(TripListController controller) {
    return [
      Expanded(
        child: InkWell(
          onTap: controller.togglePending,
          child: buildTopSeller(
            Icons.pending_outlined,
            "Pending",
            controller.travelLogs.isNotEmpty
                ? (controller.travelLogs[0].totalPending ?? 0).toString()
                : "0",
            controller.tripStatus == "Pending"
                ? AppTheme.primaryColor
                : Colors.grey,
          ),
        ),
      ),
      Expanded(
        child: InkWell(
          onTap: controller.toggleCompleted,
          child: buildTopSeller(
            Icons.done_outline_outlined,
            "Completed",
            controller.travelLogs.isNotEmpty
                ? (controller.travelLogs[0].totalCompleted ?? 0).toString()
                : "0",
            controller.tripStatus == "Completed"
                ? AppTheme.primaryColor
                : Colors.grey,
          ),
        ),
      ),
    ];
  }

  Widget _popUpMenuBuilderForMonthlySummary(TripListController controller) {
    String currentMonthName = monthMap.keys.elementAt(DateTime.now().month - 1);
    controller.selectedMonth ??= currentMonthName;
    return PopupMenuButton<String>(
      onSelected: controller.onSelectMonth,
      itemBuilder: (BuildContext context) {
        return monthMap.keys.map((month) {
          return PopupMenuItem<String>(
            value: month,
            height: 36,
            child: MyText.bodySmall(
              month,
              color: Theme.of(context).colorScheme.onSurface,
              fontWeight: 600,
            ),
          );
        }).toList();
      },
      color: theme.cardTheme.color,
      child: MyContainer.bordered(
        padding: MySpacing.xy(12, 4),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            MyText.labelMedium(
              controller.selectedMonth ?? monthMap.keys.first,
              color: contentTheme.onBackground,
            ),
            MySpacing.width(4),
            Icon(
              LucideIcons.chevron_down,
              size: 20,
              color: contentTheme.onBackground,
            ),
          ],
        ),
      ),
    );
  }

  Widget _popUpMenuBuilderForYearlySummary(TripListController controller) {
    final currentYear = DateTime.now().year;
    final startYear = 2024;

    final List<String> yearList = [
      for (int y = startYear; y <= currentYear; y++) "$y",
    ];

    controller.selectedYear ??= currentYear.toString();

    return PopupMenuButton<String>(
      onSelected: controller.onSelectYear,
      itemBuilder: (BuildContext context) {
        return yearList.map((yrs) {
          return PopupMenuItem<String>(
            value: yrs,
            height: 32,
            child: MyText.bodySmall(
              yrs,
              color: Theme.of(context).colorScheme.onSurface,
              fontWeight: 600,
            ),
          );
        }).toList();
      },
      color: theme.cardTheme.color,
      child: MyContainer.bordered(
        padding: MySpacing.xy(12, 4),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            MyText.labelMedium(
              controller.selectedYear ?? yearList.first,
              color: contentTheme.onBackground,
            ),
            MySpacing.width(4),
            Icon(
              LucideIcons.chevron_down,
              size: 20,
              color: contentTheme.onBackground,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTopSeller(
    IconData icon,
    String title,
    String value,
    Color color,
  ) {
    return MyCard(
      color: color,
      shadow: MyShadow(elevation: 1),
      paddingAll: 8,
      margin: MySpacing.right(5),
      borderRadiusAll: AppStyle.buttonRadius.medium,
      // width: 300,
      child: Row(
        children: [
          Icon(icon, size: 30, color: Colors.white),
          // MyContainer.none(
          //   borderRadiusAll: AppStyle.buttonRadius.medium,
          //   clipBehavior: Clip.antiAliasWithSaveLayer,
          //   child: Icon(icon, size: 30, color: color),
          //   // Icon(Icons.absent, size: 70),
          // ),
          MySpacing.width(8),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyText.bodyMedium(
                title,
                muted: true,
                fontSize: 16,
                color: Colors.white,
              ),
              MyText.bodyMedium(
                value,
                fontWeight: 700,
                fontSize: 16,
                color: Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
