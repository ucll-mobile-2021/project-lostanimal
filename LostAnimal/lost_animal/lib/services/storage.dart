import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class Storage {
  FirebaseStorage _storage =
      FirebaseStorage(storageBucket: "gs://lostanimal-e2a45.appspot.com");

  Future<String> uploadFile(File file, String animalId) async {

    var storageRef = _storage.ref().child("$animalId");
    var uploadTask = storageRef.putFile(file);
    var completedTask = await uploadTask.onComplete;
    String downloadUrl = await completedTask.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> getAnimalProfileImage(String animalId) async {
    return await _storage.ref().child("$animalId").getDownloadURL();
  }
}