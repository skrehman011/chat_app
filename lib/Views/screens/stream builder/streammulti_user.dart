import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Models/Student.dart';

class StreammultiUser extends StatelessWidget {
  const StreammultiUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () { Get.back(); }, icon: Icon(Icons.arrow_back, color: Colors.black,),),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Stream Multi User', style: TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.w900,
          fontSize: 23,
        ),),
        centerTitle: true,
      ),
      body:StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (BuildContext context, snapshot){
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator.adaptive();
          }

          List<Student> users=snapshot.data!.docs.map((e) => Student.fromMap(e.data() as Map<String,dynamic>)).toList();

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (BuildContext context, int index) {
              Student user = users[index];
              return  ListTile(
                title: Text(user.name),
                subtitle: Text(user.email),
                trailing: Text(user.password),
              );
            },);
        },
      ),
    );
  }
}
