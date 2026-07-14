import 'package:flatten/helpers/theme/app_style.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

final DateFormat dateFormatter = DateFormat('dd/MM/yyyy');
final DateFormat timeFormatter = DateFormat('jms');

// String baseUrl = "http://208.115.124.12:8000";
const String baseUrl = "https://erp.mvdfastener.in";
// String baseUrl = "http://192.168.1.143:8000";
String backendUrl = "http://192.168.1.43:3000";

toastMessage({String message = ""}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    fontSize: 30.0,
  );
}

void showCustomToast(String message, context) {
  FToast fToast = FToast();
  fToast.init(context); // Use your BuildContext if available

  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: AppColors.notificationSuccessBGColor,
    ),
    child: Text(
      message,
      style: TextStyle(
        fontSize: 22, // 👈 Bigger size here
        color: AppColors.notificationSuccessTextColor,
        fontWeight: FontWeight.bold,
      ),
    ),
  );

  fToast.showToast(
    child: toast,
    gravity: ToastGravity.CENTER,
    toastDuration: const Duration(seconds: 2),
  );
}

Map<String, int> monthMap = {
  'Jan': 1,
  'Feb': 2,
  'Mar': 3,
  'Apr': 4,
  'May': 5,
  'Jun': 6,
  'Jul': 7,
  'Aug': 8,
  'Sep': 9,
  'Oct': 10,
  'Nov': 11,
  'Dec': 12,
};

List<String> completedDateListPerMonth() {
  DateTime today = DateTime.now();
  int year = today.year;
  int month = today.month;
  int date = today.day;
  List<String> completedDates = [];

  for (int day = 1; day <= date; day++) {
    // ✅ Always use 2-digit month and day
    String formattedDate =
        "${year.toString()}-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}";
    completedDates.add(formattedDate);
  }

  print("Days completed in month: ${completedDates.length}");
  print("List of completed dates: $completedDates");
  return completedDates;
}

Map<String, int> calculateWorkHours(String startTime, String endTime) {
  // if(startTime =)
  if (startTime == null ||
      startTime == "" ||
      endTime == "" ||
      endTime == null) {
    return {"hours": 0, "minutes": 0};
  }
  DateTime start = DateFormat("HH:mm:ss").parse(startTime);
  DateTime end = DateFormat("HH:mm:ss").parse(endTime);

  Duration diff = end.difference(start);
  int hours = diff.inHours;
  int minutes = diff.inMinutes.remainder(60);

  return {"hours": hours, "minutes": minutes};
}

String calculateTime(String? time) {
  time = time ?? DateTime.now().toString();

  final DateFormat inputFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
  final DateTime dateTime = inputFormat.parse(time);

  final DateFormat outputFormat = DateFormat('dd MMM yy hh:mm a');
  return outputFormat.format(dateTime);
}

String timeStringToStringWithAmPM({required String railwayTime}) {
  DateTime parsedTime = DateFormat("HH:mm:ss").parse(railwayTime);
  String formattedTime = DateFormat("hh:mm a").format(parsedTime);
  return formattedTime;
}

class AppConstant {
  static int androidAppVersion = 2;
  static int iOSAppVersion = 2;
  static String version = "2.0.0";

  static String get appName => 'Flatten';
}
