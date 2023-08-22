import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mondaytest/Views/screens/screen_log_in.dart';
import 'package:mondaytest/Views/screens/stream%20builder/streammulti_user.dart';
import 'package:mondaytest/notification_services.dart';

import '../../../Models/Student.dart';

class StreamSingleUser extends StatelessWidget {


  NotificationServices notificationServices = NotificationServices();

  @override


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: (){
          FirebaseAuth.instance.signOut().then((value){
            Get.offAll(ScreenLogIn());
          });
        }, icon: Icon(Icons.logout, color: Colors.black,))],
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Stream Single User', style: TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.w900,
          fontSize: 23,
        ),),
        centerTitle: true,
       ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser!.uid) // Use uid
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator.adaptive();
                  }

                  var data = snapshot.data!.data() as Map<String, dynamic>;
                  var user = Student.fromMap(data);

                  return ListTile(
                      title: Text(' ${user.name},  ${user.age}'),
                      subtitle: Text(' ${user.email}'));
                }),
          ),
          TextButton(onPressed: (){
            Get.to(StreammultiUser());
          }, child: Text('Stream Multi User'))
        ],
      ),
      );
  }
}
