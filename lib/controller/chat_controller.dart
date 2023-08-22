import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mondaytest/helper/constants.dart';

import '../Models/Student.dart';

class ChatController extends GetxController {

  var isEmojiVisible = false.obs;
  FocusNode focusNode = FocusNode();
  var textEditingController = TextEditingController();
  String receiver_id;
  Rx<Student?> receiverObservable = Rx(null);

  @override
  void onInit() {
    super.onInit();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        isEmojiVisible.value = false;
      }
    });
    startReceiverStream();
  }

  @override
  void onClose() {
    super.onClose();
    textEditingController.dispose();
  }

  ChatController({
    required this.receiver_id,
  });

  void startReceiverStream() {
    usersRef.doc(receiver_id).snapshots().listen((event) {
      receiverObservable.value = Student.fromMap(event.data() as Map<String, dynamic>);
    });
  }
}