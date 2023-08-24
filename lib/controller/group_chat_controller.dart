import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../Models/message_model.dart';
import '../helper/Fcm.dart';
import '../helper/constants.dart';
import '../helper/firebase_helpers.dart';

class GroupChatController extends GetxController {
  var isEmojiVisible = false.obs;
  FocusNode focusNode = FocusNode();
  var textEditingController = TextEditingController();
  String group_id;

  @override
  void onInit() {
    super.onInit();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        isEmojiVisible.value = false;
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
    textEditingController.dispose();
  }

  void pickImage() async {
    var pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      var file = File(pickedFile.path);
      var url = await FirebaseStorageUtils.uploadImage(file, 'group_chats/$group_id', DateTime.now().millisecondsSinceEpoch.toString());
      sendMessage(url, type: 'image');
    }
  }

  void sendMessage(String text, {String type = 'text'}) async {
    if (text.isNotEmpty) {
      var timestamp = DateTime.now().millisecondsSinceEpoch;

      var message = MessageModel(
          id: timestamp.toString(), text: text, sender_id: currentUser!.uid, timestamp: timestamp, receiver_id: group_id, message_type: type);

      var roomPath = groupsRef.child(group_id);
      roomPath.child("messages").child(timestamp.toString()).set(message.toMap());
      roomPath.child("lastMessage").set(jsonEncode(message.toMap()));
      textEditingController.clear();
    }
  }

  GroupChatController({
    required this.group_id,
  });
}
