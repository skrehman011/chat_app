import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mondaytest/Models/user_model.dart';
import 'package:mondaytest/helper/constants.dart';
import 'package:mondaytest/homepagestf.dart';

import '../Models/Student.dart';
import '../helper/Fcm.dart';

class RegistrationController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void SignUp() async {
    String name = nameController.text.trim();
    String email = emailcontroller.text.trim();
    String age = ageController.text.trim();
    String password = passwordController.text.trim();

    if (name.isEmpty || email.isEmpty || age.isEmpty || password.isEmpty) {
      Get.snackbar('Alert', 'Fill all the field');
    } else {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
         Get.snackbar('Success', 'User Register Successfully');
        emailcontroller.clear();
        nameController.clear();
        passwordController.clear();
        ageController.clear();

        Student user = Student(
          id: value.user!.uid,
          email: email,
          password: password,
          name: name,
          age: int.tryParse(age) ?? 0,
        );

        currentUser!.updateDisplayName(name);

        FirebaseFirestore.instance
            .collection('users')
            .doc(user.id)
            .set(user.toMap())
            .then((value) {
          Get.snackbar('Alert', 'Successfully Data Stored');
        });
        Get.offAll(HomePage());

        print(value.user!.email.toString());
      }).catchError((error) {
        Get.snackbar('Error', error.toString());
      });
    }
  }

  void anonymousSignup() async {
    FirebaseAuth.instance.signInAnonymously().then((value) async {
      var token = await FCM.generateToken();

      var user = UserModel(id: value.user!.uid, token: token ?? "");
      usersRef.doc(user.id).set(user.toMap()).then((value) {
        Get.offAll(HomePage());
      });
    });
  }

  void Login() async {
    String email = emailcontroller.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Alert', 'Fill all the field');
    } else {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        Get.snackbar('Success', 'Login SuccessFully');
        emailcontroller.clear();
        passwordController.clear();

        var myDoc = await usersRef.doc(currentUser!.uid).get();
        var obj = Student.fromMap(myDoc.data()!);
        currentUser!.updateDisplayName(obj.name);

        Get.offAll(HomePage());
        print(value.user!.email.toString());
      }).catchError((error) {
        Get.snackbar('error', error.toString());
      });
    }
  }

  var isEmojiVisible = false.obs;
  FocusNode focusNode = FocusNode();
  var textEditingController = TextEditingController();

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
}
