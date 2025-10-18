import 'package:flatten/controllers/my_controller.dart';
import 'package:flatten/helpers/extensions/extensions.dart';
import 'package:flatten/helpers/utils/my_string_utils.dart';
import 'package:flatten/helpers/widgets/my_form_validator.dart';
import 'package:flatten/models/employee.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmployeeListController extends MyController {
  List<EmployeeModel> employee = [];
  MyFormValidator basicValidator = MyFormValidator();
  DateTime? selectedDate;
  late Designation _designation;

  late TextEditingController nameTE, phoneNoTE, experienceTE;

  @override
  void onInit() {
    nameTE = TextEditingController(text: 'demo');
    phoneNoTE = TextEditingController(text: '8762346748');
    experienceTE = TextEditingController(text: '3');
    _designation = Designation.angular;
    EmployeeModel.dummyList.then((value) {
      employee = value;
      update();
    });
    super.onInit();
  }

  Future<void> pickDate() async {
    final DateTime? picked = await showDatePicker(
        context: Get.context!,
        initialDate: selectedDate ?? DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      update();
    }
  }

  void addData() {
    if (basicValidator.validateForm()) {
      employee.add(EmployeeModel(-1, nameTE.text, _designation.name,
          phoneNoTE.text, experienceTE.text.toDouble(), selectedDate));
      update();
      nameTE.clear();

      phoneNoTE.clear();
      experienceTE.clear();
    }
  }

  void onSelectDesignation(Designation designation) {
    _designation = designation;
    update();
  }

  String? validateName(String? text) {
    if (text == null || text.isEmpty) {
      return "Please enter name";
    } else if (!MyStringUtils.validateStringRange(text, 4, 20)) {
      return "Password length must between 4 and 20";
    }
    return null;
  }

  String? validatePhoneNumber(String? text) {
    if (text == null || text.isEmpty) {
      return "Please enter phone number";
    } else if (!MyStringUtils.validateStringRange(text, 10, 11)) {
      return "Password length must between 10 and 11";
    }
    return null;
  }

  String? validateEmail(String? text) {
    if (text == null || text.isEmpty) {
      return "Please enter email";
    } else if (!MyStringUtils.isEmail(text)) {
      return "Please enter valid email";
    }
    return null;
  }

  void removeData(int index) {
    employee.removeAt(index);
    update();
  }
}
