
import 'package:flutter/material.dart';
import 'package:timelines_plus/timelines_plus.dart';

class TravelTimelinePage extends StatelessWidget {
  const TravelTimelinePage({super.key});

  final List<Map<String, dynamic>> travelStops = const [
    {'location': 'Chennai', 'time': '08:00 AM', 'distance': 'Start Point'},
    {'location': 'Vellore', 'time': '10:15 AM', 'distance': '130 km'},
    {'location': 'Bangalore', 'time': '01:30 PM', 'distance': '210 km'},
    {'location': 'Mysore', 'time': '04:00 PM', 'distance': 'Final Destination'},
    {'location': 'Chennai', 'time': '08:00 AM', 'distance': 'Start Point'},
    {'location': 'Vellore', 'time': '10:15 AM', 'distance': '130 km'},
    {'location': 'Bangalore', 'time': '01:30 PM', 'distance': '210 km'},
    {'location': 'Mysore', 'time': '04:00 PM', 'distance': 'Final Destination'},
    {'location': 'Chennai', 'time': '08:00 AM', 'distance': 'Start Point'},
    {'location': 'Vellore', 'time': '10:15 AM', 'distance': '130 km'},
    {'location': 'Bangalore', 'time': '01:30 PM', 'distance': '210 km'},
    {'location': 'Mysore', 'time': '04:00 PM', 'distance': 'Final Destination'},
    {'location': 'Chennai', 'time': '08:00 AM', 'distance': 'Start Point'},
    {'location': 'Vellore', 'time': '10:15 AM', 'distance': '130 km'},
    {'location': 'Bangalore', 'time': '01:30 PM', 'distance': '210 km'},
    {'location': 'Mysore', 'time': '04:00 PM', 'distance': 'Final Destination'},
    {'location': 'Chennai', 'time': '08:00 AM', 'distance': 'Start Point'},
    {'location': 'Vellore', 'time': '10:15 AM', 'distance': '130 km'},
    {'location': 'Bangalore', 'time': '01:30 PM', 'distance': '210 km'},
    {'location': 'Mysore', 'time': '04:00 PM', 'distance': 'Final Destination'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Travel Timeline"),
        backgroundColor: Colors.teal,
      ),
      body: Timeline.tileBuilder(
        theme: TimelineThemeData(
          direction: Axis.vertical,
          connectorTheme: const ConnectorThemeData(
            color: Colors.teal,
            thickness: 3,
          ),
          indicatorTheme: const IndicatorThemeData(
            color: Colors.teal,
            size: 25,
          ),
        ),
        builder: TimelineTileBuilder.connected(
          itemCount: travelStops.length,
          connectionDirection: ConnectionDirection.before,
          connectorBuilder: (_, index, __) => const SolidLineConnector(),
          indicatorBuilder: (_, index) => const DotIndicator(
            color: Colors.teal,
            child: Icon(Icons.location_on, color: Colors.white, size: 14),
          ),
          contentsBuilder: (context, index) {
            final stop = travelStops[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                title: Text(
                  stop['location'],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('${stop['distance']} • ${stop['time']}'),
              ),
            );
          },
        ),
      ),
    );
  }
}
