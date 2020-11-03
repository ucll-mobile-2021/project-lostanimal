import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lost_animal/models/animal.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  // collection reference
  final CollectionReference lostAnimalCollection =
      Firestore.instance.collection('animals');

  Future updateUserData() async {
    return lostAnimalCollection;
  }

  Future updateAnimalData(String name, String beschrijving, String animalType,
      String straatnaam, String huisnr, String gemeente, String userid) async {
    print(lostAnimalCollection.toString());
    try {
      return await lostAnimalCollection
          .document(userid + name + animalType)
          .setData({
        'name': name,
        'beschrijving': beschrijving,
        'animalType': animalType,
        'straatnaam': straatnaam,
        'huisnr': huisnr,
        'gemeente': gemeente,
        'userid': userid
      });
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // animal list from snapshot
  List<Animal> _animalListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Animal(
          animalType: doc.data['animalType'] ?? '',
          name: doc.data['name'] ?? '');
    }).toList();
  }

  // get animals stream
  Stream<List<Animal>> get animals {
    return lostAnimalCollection.snapshots().map(_animalListFromSnapshot);
  }
}
