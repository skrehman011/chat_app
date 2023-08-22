import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mondaytest/Models/message_model.dart';
import 'package:mondaytest/Models/user_model.dart';
import 'package:mondaytest/Views/screens/screen_all_users.dart';
import 'package:mondaytest/Views/screens/screen_chat.dart';
import 'package:mondaytest/Views/screens/screen_log_in.dart';
import 'package:mondaytest/helper/Fcm.dart';
import 'package:mondaytest/helper/constants.dart';

import 'Models/Student.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    updateMyToken();
    startLastSeenUpdates();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('home page'),
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut().then((value) => Get.offAll(ScreenLogIn()));
              },
              icon: Icon(
                Icons.logout,
                color: Colors.black,
              ))
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: usersRef.doc(currentUser!.uid).collection('inbox').snapshots(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          var lastMessages = snapshot.data!.docs.map((e) => MessageModel.fromMap(e.data() as Map<String, dynamic>)).toList();

          return lastMessages.isNotEmpty
              ? ListView.builder(
                  itemCount: lastMessages.length,
                  itemBuilder: (BuildContext context, int index) {
                    var message = lastMessages[index];

                    String oppositeUserId = message.sender_id == currentUser!.uid ? message.receiver_id : message.sender_id;
                    bool sentByMe = message.sender_id == currentUser!.uid;

                    return FutureBuilder<DocumentSnapshot>(
                        future: usersRef.doc(oppositeUserId).get(),
                        builder: (context, userSnapshot) {
                          if (userSnapshot.connectionState == ConnectionState.waiting) {
                            return SizedBox();
                          }

                          var user = Student.fromMap(userSnapshot.data!.data() as Map<String, dynamic>);

                          return ListTile(
                            title: Text(user.name),
                            leading: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.pink),
                              alignment: Alignment.center,
                              child: Text(
                                user.name[0].toUpperCase(),
                                style: TextStyle(fontSize: 20, color: Colors.white),
                              ),
                            ),
                            subtitle: Text(
                              "${sentByMe ? "You: " : ""}${message.text}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            onTap: () {
                              Get.to(ScreenChat(receiver: user));
                            },
                          );
                        });
                  },
                )
              : Center(
                  child: Text("No chats"),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(ScreenAllUsers());
        },
        child: Icon(Icons.chat),
      ),
    );
  }

  void updateMyToken() async {
    var token = await FCM.generateToken();
    usersRef.doc(currentUser!.uid).update({
      "token": token
    });
  }

  void startLastSeenUpdates() {
    Timer.periodic(Duration(seconds: 10), (timer) {
      usersRef.doc(currentUser!.uid).update({
        'lastSeen': DateTime.now().millisecondsSinceEpoch
      });
    });
  }
}
