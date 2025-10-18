import 'package:flatten/controllers/mycontroller/trip_list_controller.dart';
import 'package:flatten/views/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TripListScreen extends StatelessWidget {
  final TripListController controller = Get.put(TripListController());

  @override
  Widget build(BuildContext context) {
    return Layout(
      scrollNeed: false,
      anyWidget: IconButton(
        onPressed: () async {
          await controller.fetchTripList(
            company: "MVD FASTENERS PRIVATE LIMITED",
          );
        },
        icon: Icon(Icons.refresh),
      ),
      child: GetBuilder<TripListController>(
        builder: (controller) {
          if (controller.travelLogs.isEmpty && controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return
            //
            Row(
              children: [
                Container(color: Colors.red, height: 10),
                Expanded(
                  child: ListView.builder(
                  controller: controller.scrollController,
                  itemCount:
                      controller.travelLogs.length + (controller.hasMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == controller.travelLogs.length) {
                      return const Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }


                    final log = controller.travelLogs[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      child: Text(log.employee ?? ""),
                    );
                  },
                            ),
                ),
              ],
            );
        },
      ),
    );
  }
}
