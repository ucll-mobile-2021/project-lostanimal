
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
        bool exists = false;
        
      await lostAnimalCollection.document(userid+name+animalType).get().then((docSnapshot) => {if(docSnapshot.exists){
        exists = true,
        print('bestaat')
      }else{
          lostAnimalCollection.document(userid+name+animalType).setData({
            'name': name,
            'beschrijving': beschrijving,
            'animalType': animalType,
            'straatnaam': straatnaam,
            'huisnr': huisnr,
            'gemeente': gemeente,
            'userid': userid 
                   
      }),
      print('bestaat niet')
      }}); 

      if(exists){
        print('return null');
        return null;
      }
      else{
        print('userid');
        return userid;
      }      
  
      
    
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

  
}
