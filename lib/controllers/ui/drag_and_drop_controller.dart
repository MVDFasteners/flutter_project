import 'package:flatten/controllers/my_controller.dart';
import 'package:flatten/models/customer.dart';

class DragDropController extends MyController {
  List<Customer> customers = [];

  DragDropController();

  @override
  void onInit() {
    super.onInit();
    Customer.dummyList.then((value) {
      customers = value;
      update();
    });
  }

  void onReorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    Customer customer = customers.removeAt(oldIndex);
    customers.insert(newIndex, customer);
    update();
  }
}
