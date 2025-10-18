import 'dart:async';

import 'package:flatten/controllers/my_controller.dart';
import 'package:flatten/helpers/utils/generator.dart';
import 'package:flatten/models/chat.dart';
import 'package:flutter/material.dart';

class ChatsController extends MyController {
  List<ChatModel> chats = [];
  List<ChatModel> filteredChats = [];
  ChatModel? selectedChat;

  late Timer _timer;
  int _nowTime = 0;
  String timeText = "00 : 00";
  TextEditingController messageController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  ScrollController? scrollController;

  void onChangeChat(ChatModel singleChatData) {
    selectedChat = singleChatData;
    update();
  }
  
  void sendMessage() {
    if (selectedChat != null) {
      selectedChat!.messages.add(
          ChatMessageModel(-1, messageController.text, DateTime.now(), true));
      messageController.clear();
      scrollToBottom(isDelayed: true);
      update();
    }
  }

  void scrollToBottom({bool isDelayed = false}) {
    final int delay = isDelayed ? 400 : 0;
    Future.delayed(Duration(milliseconds: delay), () {
      scrollController!.animateTo(scrollController!.position.maxScrollExtent,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOutCubicEmphasized);
    });
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (Timer timer) {
      _nowTime = _nowTime + 1;
      timeText = Generator.getTextFromSeconds(time: _nowTime);
      update();
    });
  }

  @override
  void onInit() {
    super.onInit();
    ChatModel.dummyList.then((value) {
      filteredChats = value;
      selectedChat = chats[0];
      update();
    });
    ChatModel.dummyList.then((value) {
      chats = value;
      update();
    });
    scrollController = ScrollController();
    startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }
}
