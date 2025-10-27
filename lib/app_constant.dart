import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

final DateFormat dateFormatter = DateFormat('dd/MM/yyyy');
final DateFormat timeFormatter = DateFormat('jms');

String baseUrl = "http://208.115.124.12:8000";
// String baseUrl = "http://192.168.1.143:8000";
String backendUrl = "http://192.168.1.43:3000";

toastMessage({String message = ""}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    fontSize: 16.0,
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

class AppConstant {
  static int androidAppVersion = 2;
  static int iOSAppVersion = 2;
  static String version = "2.0.0";

  static String get appName => 'Flatten';
}
