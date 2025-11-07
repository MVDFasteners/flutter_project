class EmployeeLogin {
  String? id;
  String? user;
  String? employee;
  String? employeeName;
  String? inTime;
  String? outTime;
  String? inDate;
  String? outDate;
  String? company;
  String? remarks;
  String? inLocation;
  String? outLocation;
  String? inPhoto;
  String? outPhoto;
  String? message;
  int? isLeave;

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
    this.isLeave,
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

  Map<String, dynamic> updateImageFile() {
    return {'name': id, 'in_photo': inPhoto};
  }
}

class ReportEmployeesLoginList {
  String? loginId;
  String? employee;
  String? employeeName;
  String? inTime;
  String? outTime;
  String? inDate;
  String? outDate;
  String? company;
  String? remarks;
  String? inLocation;
  String? outLocation;
  String? inPhoto;
  String? outPhoto;
  String? message;
  String? isLeave;
  String? status;

  ReportEmployeesLoginList({
    this.loginId,
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
    this.isLeave,
    this.status,
  });

  /// ✅ Convert JSON → Dart Object
  factory ReportEmployeesLoginList.fromJson(Map<String, dynamic> json) {
    return ReportEmployeesLoginList(
      loginId: json['login_id'],
      employee: json['employee_id'],
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
      status: json['status'],
    );
  }

  /// ✅ Convert Dart Object → JSON
  Map<String, dynamic> toJson() {
    return {
      'name': loginId,
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

  // Map<String, dynamic> updateImageFile() {
  //   return {'name': id, 'in_photo': inPhoto};
  // }
}
