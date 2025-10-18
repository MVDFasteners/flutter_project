import 'dart:async';

import 'package:flatten/controllers/my_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_ticket_provider_mixin.dart';

class MusicController extends MyController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  String time = "0:00";
  int position = 0, repeatType = 0;
  int duration = 200;
  bool isPlaying = false;
  Timer? _timer;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      if (position >= (duration - 1)) {
        timer.cancel();
        position += 1;
        convertTime();
        isPlaying = false;
        animationController.reverse();
      } else {
        position += 1;
        convertTime();
      }
    });
  }

  void onPlay() {
    startTimer();
  }

  void onPause() {
    _timer!.cancel();
  }

  void convertTime() {
    int hour = (position / 3600).floor();
    int minute = ((position - 3600 * hour) / 60).floor();
    int second = (position - 3600 * hour - 60 * minute);
    String timing = "";
    if (second < 10) {
      timing += "$minute:0$second";
    } else {
      timing += "$minute:$second";
    }

    time = timing;
    update();
  }

  void onTrackDurationChange(double value) {
    position = value.floor();
    update();
    convertTime();
  }

  void musicPlay() {
    if (isPlaying) {
      animationController.reverse();
      onPause();
      update();
      isPlaying = false;
    } else {
      animationController.forward();
      onPlay();
      update();
      isPlaying = true;
    }
  }

  @override
  void onInit() {
    animationController =
        AnimationController(duration: Duration(milliseconds: 400), vsync: this);
    super.onInit();
  }

  @override
  void onClose() {
    animationController.dispose();
    if (_timer != null) _timer!.cancel();
    super.onClose();
  }

  Map songsName = {
    'popular': [
      {
        'singer_name': 'Olivia Rodrigo',
        'song_name': 'Drivers license',
      },
      {
        'singer_name': 'Nathan Evans',
        'song_name': 'Wellerman',
      },
      {
        'singer_name': 'Tiesto',
        'song_name': 'The Business',
      },
      {
        'singer_name': 'Lil Nas X',
        'song_name': 'Montero',
      },
      {
        'singer_name': 'Weeknd',
        'song_name': 'Save your tears',
      },
      {
        'singer_name': 'Dua Lipa',
        'song_name': 'Levitating',
      },
      {
        'singer_name': 'Kid Laroi',
        'song_name': 'Without You',
      },
      {
        'singer_name': 'Olivia Rodrigo',
        'song_name': 'Good 4 U',
      },
      {
        'singer_name': 'Weeknd',
        'song_name': 'Blinding Lights',
      },
      {
        'singer_name': 'Joel Corry ft Mnek',
        'song_name': 'Head & Heart',
      },
    ],
    'Latest': [
      {
        'singer_name': 'Riton',
        'song_name': 'Friday',
      },
      {
        'singer_name': 'Tion Wayne',
        'song_name': 'Body',
      },
      {
        'singer_name': 'Kid Laroi',
        'song_name': 'Without You',
      },
      {
        'singer_name': 'Olivia Rodrigo',
        'song_name': 'Good 4 U',
      },
      {
        'singer_name': 'Weeknd',
        'song_name': 'Blinding Lights',
      },
      {
        'singer_name': 'Joel Corry ft Mnek',
        'song_name': 'Head & Heart',
      },
    ],
    'songList': [
      {
        'singer_name': 'Joel Corry ft Mnek',
        'song_name': 'Bed',
      },
      {
        'singer_name': 'Ann-Marie',
        'song_name': 'Don\'t Play',
      },
      {
        'singer_name': 'A1 & J1',
        'song_name': 'Latest Trends',
      },
      {
        'singer_name': 'Justine Bieber',
        'song_name': 'Peaches',
      },
      {
        'singer_name': 'Tom Grennan',
        'song_name': 'Little bit of Love',
      },
      {
        'singer_name': 'Travis Scott & HVME',
        'song_name': 'Goosebumps',
      },
    ],
  };
}
