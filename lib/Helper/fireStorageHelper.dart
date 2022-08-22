import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class fireStorageHelper{
  fireStorageHelper._();
  static fireStorageHelper helper =fireStorageHelper._();
  FirebaseStorage firebaseStorage  = FirebaseStorage.instance;
////Upload Photo on Firebase Storage
  Future<String> uploadImage(File file, [String folderName = 'profiles']) async {

    String filePath = file.path;
    String fileName = filePath.split('/').last;
    String path = 'images/$folderName/$fileName';
    Reference reference = firebaseStorage.ref(path);
    await reference.putFile(file);
    String imageUrl = await reference.getDownloadURL();

    return imageUrl;
  }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////



}