import 'dart:io';
import 'package:flatten/models/monthly%20attendance%20model.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

Future<void> exportAttendanceExcelSF({
  required List<EmployeeAttendance> employees,
  required int year,
  required int month,
}) async {
  final workbook = Workbook();
  final sheet = workbook.worksheets[0];
  sheet.name = 'Attendance';

  int days = DateTime(year, month + 1, 0).day;

  /// Header
  sheet.getRangeByIndex(1, 1).setText("Employee");
  for (int d = 1; d <= days; d++) {
    sheet.getRangeByIndex(1, d + 1).setText(d.toString().padLeft(2, '0'));
  }

  /// Data
  int row = 2;
  for (final emp in employees) {
    sheet.getRangeByIndex(row, 1).setText(emp.employeeName ?? '');

    for (int day = 1; day <= days; day++) {
      String date =
          "$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}";

      final log = emp.logList.firstWhere(
        (e) => e.inDate == date,
        orElse: () => ReportEmployeesLoginListMonthly(),
      );

      String value = "";
      if (log.inTime != null || log.outTime != null) {
        value = "${log.inTime ?? ''} - ${log.outTime ?? ''}";
      }
      sheet.getRangeByIndex(row, day + 1).setText(value);
    }
    row++;
  }

  /// Save
  final bytes = workbook.saveAsStream();
  workbook.dispose();

  final dir = await getApplicationDocumentsDirectory();
  final file = File("${dir.path}/Attendance_${year}_$month.xlsx");
  await file.writeAsBytes(bytes);

  await OpenFile.open(file.path);
}
