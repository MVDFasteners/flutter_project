import 'package:flatten/models/identifier_model.dart';

class User extends IdentifierModel {
  final String email, firstName, lastName;

  User(super.id, this.email, this.firstName, this.lastName);

  String get name => "$firstName $lastName";

  // static User fromJSON(Map<String, dynamic> json) {
  //   JSONDecoder decoder = JSONDecoder(json);
  //
  //   String firstName = decoder.getString('first_name');
  //   String lastName = decoder.getString('last_name');
  //
  //   String email = decoder.getString('email');
  //
  //   String mobileNumber = decoder.getString('mobile_number');
  //
  //   String? avatar = decoder.getImageURLOrNull('avatar');
  //
  //   return User(
  //     decoder.getId,
  //     email,
  //     firstName,
  //     lastName,
  //     mobileNumber,
  //     avatar: avatar,
  //   );
  // }
}

class UserModel {
  final String? userId;
  final String? fullName;
  final String? image;
  final String? department;
  final String? company;
  final int? stockUser;
  final int? accountUser;
  final int? attendanceUser;
  final int? dashboardUser;
  final String? employeeId;

  UserModel({
    this.userId,
    this.fullName,
    this.image,
    this.department,
    this.company,
    this.stockUser,
    this.accountUser,
    this.attendanceUser,
    this.dashboardUser,
    this.employeeId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final msg = json['message'] ?? {};

    return UserModel(
      userId: msg['user_id'] ?? '',
      fullName: msg['full_name'] ?? '',
      image: msg['image'] ?? '',
      department: msg['department'] ?? '',
      company: msg['company'] ?? '',
      employeeId: msg['employee_id'] ?? '',

      stockUser: int.tryParse(msg['stock_user']?.toString() ?? '0'),
      accountUser: int.tryParse(msg['accounts_user']?.toString() ?? '0'),
      attendanceUser: int.tryParse(msg['hr_user']?.toString() ?? '0'),
      dashboardUser: int.tryParse(msg['dashbord_user']?.toString() ?? '0'),
    );
  }

  // Optional: Convert User to JSON (if needed)
  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'full_name': fullName,
      'image': image,
      'department': department,
      'company': company,
    };
  }
}
