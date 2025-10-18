import 'dart:math';

import 'package:flatten/controllers/my_controller.dart';
import 'package:flatten/helpers/extensions/string.dart';
import 'package:flatten/helpers/widgets/my_text_utils.dart';

class Data {
  final int id, qty;
  final String name;
  final String code;
  final double amount;

  Data(this.id, this.qty, this.name, this.code, this.amount);

  static List<Data> factory([int seeds = 10]) {
    return List.generate(
        seeds,
        (index) => Data(
            index + 1,
            Random().nextInt(100),
            MyTextUtils.getDummyText(2, withStop: false),
            MyTextUtils.getDummyText(1, withStop: false).toLowerCase(),
            (Random().nextDouble() * 100).toStringAsPrecision(2).toDouble()));
  }
}

class BasicTableController extends MyController {
  List<Data> datas = Data.factory();

  BasicTableController();

  void onSelect(int index) {}
}
