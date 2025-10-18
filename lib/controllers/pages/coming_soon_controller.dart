import 'dart:async';

import 'package:flatten/controllers/my_controller.dart';

class ComingSoonController extends MyController {
  Timer? countdownTimer;
  Duration myDuration = Duration(days: 15);

  void startTimer() {
    countdownTimer =
        Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
    update();
  }

  void setCountDown() {
    final reduceSecondsBy = 1;

    final seconds = myDuration.inSeconds - reduceSecondsBy;
    if (seconds < 0) {
      countdownTimer!.cancel();
    } else {
      myDuration = Duration(seconds: seconds);
    }
    update();
  }

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }
}
