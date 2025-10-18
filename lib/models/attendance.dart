class EmployeeLogin {
  final String? id;
  final String? user;
  final String? employee;
  final String? employeeName;
  final String? inTime;
  final String? outTime;
  final String? inDate;
  final String? outDate;
  final String? company;
  final String? remarks;
  final String? inLocation;
  final String? outLocation;
  final String? inPhoto;
  final String? outPhoto;
  final String? message;
  final int? isLeave;

  EmployeeLogin({
    this.id,
    this.user,
    this.employee,
    this.employeeName,
    this.inTime,
    this.outTime,
    this.inDate,
    this.outDate,
    this.company,
    this.remarks,
    this.inLocation,
    this.outLocation,
    this.inPhoto,
    this.outPhoto,
    this.message,
    this.isLeave
  });

  /// ✅ Convert JSON → Dart Object
  factory EmployeeLogin.fromJson(Map<String, dynamic> json) {
    return EmployeeLogin(
      id: json['name'],
      // ERPNext document name
      user: json['user'],
      employee: json['employee'],
      employeeName: json['employee_name'],
      inTime: json['in_time'],
      outTime: json['out_time'],
      inDate: json['in_date'],
      outDate: json['out_date'],
      company: json['company'],
      remarks: json['remarks'],
      inLocation: json['in_location'],
      outLocation: json['out_location'],
      inPhoto: json['in_photo'],
      outPhoto: json['out_photo'],
      isLeave: json['is_leave'],
      message: json['message'],
    );
  }

  /// ✅ Convert Dart Object → JSON
  Map<String, dynamic> toJson() {
    return {
      'name': id,
      'user': user,
      'employee': employee,
      'employee_name': employeeName,
      'in_time': inTime,
      'out_time': outTime,
      'in_date': inDate,
      'out_date': outDate,
      'company': company,
      'remarks': remarks,
      'in_location': inLocation,
      'out_location': outLocation,
      'in_photo': inPhoto,
      'out_photo': outPhoto,
    };
  }
}
