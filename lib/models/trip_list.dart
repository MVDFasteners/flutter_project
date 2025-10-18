class RoutePoint {
  int? sequence;
  double? latitude;
  double? longitude;
  String? address;
  String? timestamp;
  double? distanceFromPreviousKm;

  RoutePoint({
    this.sequence,
    this.latitude,
    this.longitude,
    this.address,
    this.timestamp,
    this.distanceFromPreviousKm,
  });

  factory RoutePoint.fromJson(Map<String, dynamic> json) {
    return RoutePoint(
      sequence: json['sequence'] ?? 0,
      latitude: (json['latitude'] ?? 0).toDouble(),
      longitude: (json['longitude'] ?? 0).toDouble(),
      address: json['address'] ?? '',
      timestamp: json['timestamp'] ?? '',
      distanceFromPreviousKm: (json['distance_from_previous_km'] ?? 0)
          .toDouble(),
    );
  }
}

class Trip {
  String? name;
  String? employee;
  String? employeeName;
  String? startDate;
  String? endDate;
  double? totalDistance;
  String? status;
  String? creation;
  List<RoutePoint>? routes;

  Trip({
    this.name,
    this.employee,
    this.employeeName,
    this.startDate,
    this.endDate,
    this.totalDistance,
    this.status,
    this.creation,
    this.routes,
  });

  factory Trip.fromJson(Map<String, dynamic> json) {
    var routesJson = json['routes'] as List<dynamic>? ?? [];
    List<RoutePoint> routePoints = routesJson
        .map((e) => RoutePoint.fromJson(e))
        .toList();

    return Trip(
      name: json['trip_name'] ?? '',
      employee: json['employee'] ?? '',
      employeeName: json['employee_name'] ?? '',
      startDate: json['start_date'] ?? '',
      endDate: json['end_date'] ?? '',
      totalDistance: (json['total_distance'] ?? 0).toDouble(),
      status: json['status'] ?? '',
      creation: json['creation'] ?? '',
      routes: routePoints,
    );
  }
}
