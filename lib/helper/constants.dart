import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

var usersRef = FirebaseFirestore.instance.collection("users");
var chatsRef = FirebaseDatabase.instance.ref().child('chat_rooms');
var groupsRef = FirebaseDatabase.instance.ref().child('groups');
User? get currentUser => FirebaseAuth.instance.currentUser;