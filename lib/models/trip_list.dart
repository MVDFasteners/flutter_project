class TripImage {
  String? id;
  String? image;
  String? description;
  String? parentId;
  String? childId;

  TripImage({
    this.id,
    this.image,
    this.description,
    this.parentId,
    this.childId,
  });

  factory TripImage.fromJson(Map<String, dynamic> json) {
    return TripImage(
      id: json['name'],
      image: json['image'],
      description: json['description'] ?? "",
      childId: json['travel_log_id'] ?? "",
      parentId: json['parent'] ?? ""
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': id,
      'parent': parentId,
      'image': image,
      'description': description,
      'travel_log_id': childId,
      "parenttype": "Employee Trip",
      "parentfield": "trip_images",
    };
  }
}

class RoutePoint {
  String? id;
  int? sequence;
  double? latitude;
  double? longitude;
  String? address;
  String? timestamp;
  double? distanceFromPreviousKm;
  String? parentId;

  RoutePoint({
    this.id,
    this.sequence,
    this.latitude,
    this.longitude,
    this.address,
    this.timestamp,
    this.distanceFromPreviousKm,
    this.parentId,
  });

  factory RoutePoint.fromJson(Map<String, dynamic> json) {
    return RoutePoint(
      id: json['name'],
      parentId: json['parent'],
      sequence: json['sequence'] ?? 0,
      latitude: (json['latitude'] ?? 0).toDouble(),
      longitude: (json['longitude'] ?? 0).toDouble(),
      address: json['address'] ?? '',
      timestamp: json['timestamp'] ?? '',
      distanceFromPreviousKm: (json['distance_from_previous_km'] ?? 0)
          .toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'parent': parentId,
      'sequence': sequence,
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'timestamp': timestamp,
      'distance_from_previous_km': distanceFromPreviousKm,
      "parenttype": "Employee Trip",
      "parentfield": "travel_log_route",
    };
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
  int? totalPending;
  int? totalCompleted;
  String? company;
  // List<RoutePoint>? routes;

  Trip({
    this.name,
    this.employee,
    this.employeeName,
    this.startDate,
    this.endDate,
    this.totalDistance,
    this.status,
    this.creation,
    // this.routes,
    this.totalCompleted,
    this.totalPending,
    this.company,
  });

  factory Trip.fromJson(Map<String, dynamic> json) {
    var routesJson = json['routes'] as List<dynamic>? ?? [];
    List<RoutePoint> routePoints = routesJson
        .map((e) => RoutePoint.fromJson(e))
        .toList();

    return Trip(
      name: json['name'] ?? '',
      employee: json['employee'] ?? '',
      employeeName: json['employee_name'] ?? '',
      startDate: json['start_time'] ?? '',
      endDate: json['end_time'] ?? '',
      totalDistance: (json['total_distance_km'] ?? 0).toDouble(),
      status: json['status'] ?? '',
      creation: json['creation'] ?? '',
      totalCompleted: json['total_completed'] ?? '',
      totalPending: json['total_pending'] ?? '',
      company: json['company'] ?? '',

      // routes: routePoints,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'employee': employee,
      'employee_name': employeeName,
      'start_time': startDate,
      'end_time': endDate,
      'total_distance_km': totalDistance,
      'status': status,
      'creation': creation,
      'company':company
      // 'routes': routes?.map((e) => e.toJson()).toList(),
    };
  }
}
