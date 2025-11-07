class EmployeeAttendance {
  String? employeeId;
  String? employeeName;
  String? company;
  List<ReportEmployeesLoginListMonthly> logList;

  EmployeeAttendance({
    this.employeeId,
    this.employeeName,
    this.company,
    required this.logList,
  });

  factory EmployeeAttendance.fromJson(Map<String, dynamic> json) {
    return EmployeeAttendance(
      employeeId: json['employee_id'],
      employeeName: json['employee_name'],
      company: json['company'],
      logList:
          (json['logList'] as List<dynamic>?)
              ?.map((e) => ReportEmployeesLoginListMonthly.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'employee_id': employeeId,
      'employee_name': employeeName,
      'company': company,
      'logList': logList.map((e) => e.toJson()).toList(),
    };
  }
}

class ReportEmployeesLoginListMonthly {
  String? loginId;
  String? inDate;
  String? outDate;
  String? inTime;
  String? outTime;
  String? inLocation;
  String? outLocation;
  String? remarks;
  String? inPhoto;
  String? outPhoto;
  String? message;
  String? isLeave;
  String? status;

  ReportEmployeesLoginListMonthly({
    this.loginId,
    this.inDate,
    this.outDate,
    this.inTime,
    this.outTime,
    this.inLocation,
    this.outLocation,
    this.remarks,
    this.inPhoto,
    this.outPhoto,
    this.message,
    this.isLeave,
    this.status,
  });

  factory ReportEmployeesLoginListMonthly.fromJson(Map<String, dynamic> json) {
    return ReportEmployeesLoginListMonthly(
      loginId: json['login_id'],
      inDate: json['in_date'],
      outDate: json['out_date'],
      inTime: json['in_time'],
      outTime: json['out_time'],
      inLocation: json['in_location'],
      outLocation: json['out_location'],
      remarks: json['remarks'],
      inPhoto: json['in_photo'],
      outPhoto: json['out_photo'],
      message: json['message'],
      isLeave: json['is_leave'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'login_id': loginId,
      'in_date': inDate,
      'out_date': outDate,
      'in_time': inTime,
      'out_time': outTime,
      'in_location': inLocation,
      'out_location': outLocation,
      'remarks': remarks,
      'in_photo': inPhoto,
      'out_photo': outPhoto,
    };
  }
}
