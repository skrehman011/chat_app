import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageUtils {

  static Future<String> uploadImage(File file, String path, String name) async {
    var ref = FirebaseStorage.instance.ref().child("$path/$name");
    await ref.putFile(file);
    var url = await ref.getDownloadURL();
    return url;
  }
}