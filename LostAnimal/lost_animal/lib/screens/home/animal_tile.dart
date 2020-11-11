

import 'package:flutter/material.dart';
import 'package:lost_animal/models/animal.dart';
import 'package:lost_animal/services/storage.dart';

class AnimalTile extends StatelessWidget {
  final Animal animal;
  final Storage storage = Storage();

  AnimalTile({this.animal});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: storage.getAnimalProfileImage(animal.userid+animal.name+animal.animalType),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(!snapshot.hasData) return Padding(
          padding: EdgeInsets.only(top: 8.0),
        child: Card(
          margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
          child: ListTile(
            leading: CircleAvatar(
              radius: 50.0,
              backgroundColor: Colors.blue
            ),
            title: Text(animal.name),
            subtitle: Text(animal.animalType),
          ),
        )
        );
        final url = snapshot.data;
        return Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
          margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
          child: ListTile(
            leading: CircleAvatar(
              radius: 50.0,
              backgroundImage: NetworkImage(url),
            ),
            title: Text(animal.name),
            subtitle: Text(animal.animalType),
          ),
        ));
      }
      );
    
    
    
    /*Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
          margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
          child: ListTile(
            leading: CircleAvatar(
              radius: 50.0,
              backgroundImage: NetworkImage((storage.getAnimalProfileImage("4e71m62SYPU8GynkIBquxfUNvbQ2testerhond").toString()) ),
            ),
            title: Text(animal.name),
            subtitle: Text(animal.animalType),
          ),
        ));*/
  }
}
