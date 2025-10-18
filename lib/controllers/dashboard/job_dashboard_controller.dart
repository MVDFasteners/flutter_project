import 'package:flatten/controllers/my_controller.dart';
import 'package:flatten/helpers/widgets/my_text_utils.dart';
import 'package:flatten/models/recent_application_model.dart';

class JobDashboardController extends MyController {
  List<String> dummyTexts = List.generate(12, (index) => MyTextUtils.getDummyText(60));
  List<JobRecentApplicationModel> recentApplication = [];

  @override
  void onInit() {
    JobRecentApplicationModel.dummyList.then((value) {
      recentApplication = value.sublist(0, 5);
      update();
    });
    super.onInit();
  }
}
