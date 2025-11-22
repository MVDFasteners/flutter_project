
import 'package:flatten/app_constant.dart';
import 'package:flatten/controllers/mycontroller/place_list_controller.dart';
import 'package:flatten/controllers/mycontroller/trip_images_controller.dart';
import 'package:flatten/controllers/mycontroller/trip_list_controller.dart';
import 'package:flatten/models/trip_list.dart';
import 'package:flatten/myPages/locaiton_service.dart';
import 'package:flatten/myPages/trip_images.dart';
import 'package:flatten/views/layouts/layout.dart';
import 'package:flatten/work%20space.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:timelines_plus/timelines_plus.dart';

class PlaceList extends StatelessWidget {
  const PlaceList({super.key});

  @override
  Widget build(BuildContext context) {
    final TripImagesController tripImagesController = Get.put(
      TripImagesController(),
    );
    return Layout(
      anyWidget: GetBuilder<PlaceListController>(
        builder: (controller) {
          return IconButton(
            onPressed: () async {
              if (controller.currentTrip.name != null) {
                List<TripEmployees> listValues = await controller
                    .fetchTripEmployees(parentId: controller.currentTrip.name!);
                await _listEmployeesTrip(context, employeeList: listValues);
              }
            },
            icon: Icon(Icons.people, color: Colors.blue, size: 33),
          );
        },
      ),
      leadingWidget: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      scrollNeed: false,
      bottomBar: GetBuilder<PlaceListController>(
        builder: (controller) {
          return SizedBox(
            height: 180,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (controller.currentTrip.status == "Completed")
                  ..._showDistance(controller),
                if (controller.currentTrip.status == "Pending")
                  ..._endBtnAndLocationBtn(controller, context),
              ],
            ),
          );
        },
      ),
      child: GetBuilder<PlaceListController>(
        builder: (controller) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FixedTimeline.tileBuilder(
                theme: TimelineThemeData(
                  nodePosition: 0.1,
                  color: Colors.teal,
                  indicatorTheme: const IndicatorThemeData(
                    size: 20,
                    color: Colors.teal,
                  ),
                  connectorTheme: const ConnectorThemeData(
                    thickness: 3,
                    color: Colors.teal,
                  ),
                ),
                builder: TimelineTileBuilder.connected(
                  connectionDirection: ConnectionDirection.before,
                  itemCount: controller.tripRouteList.length,
                  contentsBuilder: (context, index) {
                    final stop = controller.tripRouteList[index];
                    String value = "";
                    if (stop.timestamp != "") {
                      value = calculateTime(stop.timestamp);
                    }

                    return InkWell(
                      onTap: () async {
                        tripImagesController.updateCurrentRoute(stop);
                        await tripImagesController.fetchTripImages(
                          childId: stop.id,
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => TripImages()),
                        );
                      },
                      child: Card(
                        margin: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 12,
                        ),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          title: Text(
                            stop.address ?? "",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Row(
                            children: [
                              Text(
                                "${stop.distanceFromPreviousKm} km",
                                style: TextStyle(color: Colors.red),
                              ),
                              Spacer(),
                              Text('${value}'),
                            ],
                          ),
                        ),
                      ),
                    );
                  },

                  indicatorBuilder: (_, index) =>
                      const DotIndicator(color: Colors.teal),
                  connectorBuilder: (_, index, type) =>
                      const SolidLineConnector(color: Colors.teal),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  List<Widget> _showDistance(PlaceListController controller) {
    return [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text("Total Distance Traveled", style: TextStyle(fontSize: 16)),
      ),
      Spacer(),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          ": ${controller.currentTrip.totalDistance} km",
          style: TextStyle(fontSize: 30, color: Colors.red),
        ),
      ),
    ];
  }

  List<Widget> _endBtnAndLocationBtn(
    PlaceListController controller,
    BuildContext context,
  ) {
    return [
      Padding(
        padding: const EdgeInsets.only(left: 16),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red, // sets button color to red
            padding: EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 12,
            ), // optional
          ),
          onPressed: () async {
            await controller.endTrip();
            Future.delayed(Duration(milliseconds: 1500), () {
              Navigator.pop(context);
            });
          },
          child: Text("End My Trip", style: TextStyle(fontSize: 16)),
        ),
      ),
      Spacer(),
      Padding(
        padding: const EdgeInsets.only(right: 16),
        child: controller.isFetchLoading
            ? SizedBox(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(),
              )
            : ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ), // optional
                ),
                onPressed: () async {
                  double? value = await controller.updateLocation();
                  if (value != null) {
                    await controller.saveTripChild(
                      childId: null,
                      parentId: controller.currentTrip.name,
                      distanceKm: value,
                    );
                  } else {
                    toastMessage(message: "Cannot able to fetch distance");
                  }
                },
                child: Text("Update Location", style: TextStyle(fontSize: 16)),
              ),
      ),
    ];
  }

  Future<dynamic> _listEmployeesTrip(
    context, {
    required List<TripEmployees> employeeList,
  }) async {
    return showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text(
            "Employees List",
            style: TextStyle(color: Colors.red, fontSize: 25),
          ),
          content: employeeList.isEmpty
              ? SizedBox(height: 100, child: Text("No Employees Found"))
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (TripEmployees value in employeeList)
                      Card(
                        margin: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text(
                              '${value.employeeName!.substring(0, 1)}',
                            ),
                          ),
                          title: Text(value.employeeName ?? "--"),
                        ),
                      ),
                  ],
                ),
        );
      },
    );
  }
}
