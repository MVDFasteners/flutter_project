import 'package:flatten/controllers/my_controller.dart';
import 'package:flatten/helpers/widgets/my_text_utils.dart';

class InvoiceController extends MyController {
  List<String> dummyTexts =
      List.generate(12, (index) => MyTextUtils.getDummyText(60));
}
