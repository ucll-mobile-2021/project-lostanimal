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

  Future updateAnimalData(
      String name,
      String beschrijving,
      String animalType,
      String straatnaam,
      String huisnr,
      String gemeente,
      int phonenr,
      String userid,
      {String avatarurl = null}) async {
    bool exists = false;

    await lostAnimalCollection
        .document(userid + name + animalType)
        .get()
        .then((docSnapshot) => {
              if (docSnapshot.exists)
                {exists = true, print('bestaat')}
              else
                {
                  lostAnimalCollection
                      .document(userid + name + animalType)
                      .setData({
                    'name': name,
                    'beschrijving': beschrijving,
                    'animalType': animalType,
                    'straatnaam': straatnaam,
                    'huisnr': huisnr,
                    'gemeente': gemeente,
                    'userid': userid,
                    'avatarurl': avatarurl,
                    'phonenr': phonenr
                  }),
                  print(phonenr)
                }
            });

    if (exists) {
      print('return null');
      return null;
    } else {
      print('userid');
      return userid;
    }
  }

  Future updateAnimalAvatarURL(Animal animal, String avatarurl) async {
    await lostAnimalCollection
        .document(animal.userid + animal.name + animal.animalType)
        .setData({
      'name': animal.name,
      'beschrijving': animal.beschrijving,
      'animalType': animal.animalType,
      'straatnaam': animal.straatnaam,
      'huisnr': animal.huisnr,
      'gemeente': animal.gemeente,
      'userid': animal.userid,
      'avatarurl': avatarurl
    });
  }

  // animal list from snapshot
  List<Animal> _animalListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Animal(
          animalType: doc.data['animalType'] ?? '',
          name: doc.data['name'] ?? '',
          userid: doc.data['userid'] ?? '');
    }).toList();
  }

  // get animals stream
  Stream<List<Animal>> get animals {
    return lostAnimalCollection.snapshots().map(_animalListFromSnapshot);
  }

  Future getAnimal(String animalId) async {
    Animal a;
    await lostAnimalCollection.document(animalId).get().then((docSnapshot) => {
          if (docSnapshot.exists)
            {
              a = Animal(
                  animalType: docSnapshot.data['animalType'] ?? '',
                  name: docSnapshot.data['name'] ?? '',
                  userid: docSnapshot.data['userid'] ?? '',
                  beschrijving: docSnapshot.data['beschrijving'] ?? '',
                  gemeente: docSnapshot.data['gemeente'] ?? '',
                  straatnaam: docSnapshot.data['straatnaam'] ?? '',
                  huisnr: docSnapshot.data['huisnr'] ?? '')
            }
          else
            {getAnimal(animalId)}
        });
    print(a.animalType);
    return a;
  }
}
