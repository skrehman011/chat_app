import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mondaytest/Views/screens/screen_sign_up.dart';
import 'package:mondaytest/controller/RegistrationController.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ScreenLogIn extends StatelessWidget {
  RegistrationController loginController = Get.put(RegistrationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF022138),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(top: 20, bottom: 10, left: 15, right: 15),
              height: 45.h,
              width: 80.w,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 3),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 23,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  TextField(
                    controller: loginController.emailcontroller,
                    style: TextStyle(color: Colors.blue),
                    decoration: InputDecoration(
                        icon: Icon(
                          Icons.email,
                          color: Colors.blue,
                          size: 16,
                        ),
                        hintText: 'Email',
                        hintStyle: TextStyle(
                          color: Colors.blue,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        )),
                  ),
                  TextField(
                    controller: loginController.passwordController,
                    style: TextStyle(color: Colors.blue),
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.lock,
                        color: Colors.blue,
                        size: 16,
                      ),
                      hintText: 'Password',
                      hintStyle: TextStyle(
                        color: Colors.blue,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5.h),
                    height: 7.h,
                    width: 80.w,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.blueAccent),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextButton(
                      onPressed: () {
                        loginController.Login();
                      },
                      child: Text('Submit'),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            'Forget Password?',
                            style: TextStyle(color: Colors.blue),
                          )),
                      TextButton(
                          onPressed: () {
                            Get.to(ScreenSignUp());
                          },
                          child: Text(
                            'SignUP',
                            style: TextStyle(color: Colors.blue),
                          )),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
