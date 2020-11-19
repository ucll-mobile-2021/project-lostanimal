import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:lost_animal/models/animal.dart';
import 'package:lost_animal/services/database.dart';

class Storage {
  DatabaseService _db = DatabaseService();
  FirebaseStorage _storage =
      FirebaseStorage(storageBucket: "gs://lostanimal-e2a45.appspot.com");

  Future<String> uploadFile(File file, Animal animal) async {
    String animalId = animal.userid + animal.name + animal.animalType;

    var storageRef = _storage.ref().child("$animalId");
    var uploadTask = storageRef.putFile(file);
    var completedTask = await uploadTask.onComplete;
    String downloadUrl = await completedTask.ref.getDownloadURL();
    await _db.updateAnimalAvatarURL(animal, downloadUrl);
    print(animal.avatarurl);
    return downloadUrl;
  }

  Future<String> getAnimalProfileImage(String animalId) async {
    print("*************** getAnimalProfileImage");
    print(await _storage.ref().child(animalId).getDownloadURL());
    return await _storage.ref().child(animalId).getDownloadURL();
  }

  Future<void> deleteFile(String animalId) async{
    await _storage.ref().child(animalId).delete();
  }
}
