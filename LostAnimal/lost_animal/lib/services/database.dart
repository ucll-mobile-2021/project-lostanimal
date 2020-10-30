import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lost_animal/models/animal.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  // collection reference
  final CollectionReference lostAnimalCollection =
      Firestore.instance.collection('animals');

  Future updateUserData() async {
    return lostAnimalCollection.document(uid).collection("animals");
  }

  // animal list from snapshot
  List<Animal> _animalListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Animal(
          beschrijving: doc.data['beschrijving'] ?? '',
          name: doc.data['name'] ?? '');
    }).toList();
  }

  // get animals stream
  Stream<List<Animal>> get animals {
    return lostAnimalCollection.snapshots().map(_animalListFromSnapshot);
  }
}
