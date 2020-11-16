

import 'package:flutter/material.dart';
import 'package:lost_animal/models/animal.dart';
import 'package:lost_animal/services/storage.dart';

import '../../services/storage.dart';


class AnimalTile extends StatefulWidget {
  final Animal animal;
  final Storage storage = Storage();
  final Function toggleView;

  AnimalTile({this.animal, this.toggleView});

  @override
  _AnimalTileState createState() => _AnimalTileState(animal: animal, storage: storage);
}

class _AnimalTileState extends State<AnimalTile>{

  final Animal animal;
  final Storage storage;

  _AnimalTileState({this.animal, this.storage});


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
            onTap: () {
              print("--------------- onTap animal_tile no pic");
              widget.toggleView(4, id: animal.userid+animal.name+animal.animalType);
              },
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
            onTap: () {
              print("--------------- onTap animal_tile with pic");
              widget.toggleView(4, id: animal.userid+animal.name+animal.animalType);
              print("--------------- onTap animal_tile with pic 2");
              },
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
