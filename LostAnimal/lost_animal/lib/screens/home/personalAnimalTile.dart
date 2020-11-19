

import 'package:flutter/material.dart';
import 'package:lost_animal/models/animal.dart';
import 'package:lost_animal/models/user.dart';
import 'package:lost_animal/services/database.dart';
import 'package:lost_animal/services/storage.dart';

import '../../services/storage.dart';


class PersonalAnimalTile extends StatefulWidget {
  final Animal animal;
  final Storage storage = Storage();
  final Function toggleView;
  final User user;

  PersonalAnimalTile({this.animal, this.toggleView, this.user});

  @override
  _PersonalAnimalTileState createState() => _PersonalAnimalTileState(animal: animal, storage: storage, user: user);
}

class _PersonalAnimalTileState extends State<PersonalAnimalTile>{

  final DatabaseService _db = DatabaseService();
  final User user;
  final Animal animal;
  final Storage storage;
  bool loading = false;
  String error ="Animal has been deleted";

  _PersonalAnimalTileState({this.animal, this.storage, this.user});


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: storage.getAnimalProfileImage(animal.userid+animal.name+animal.animalType),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(animal.userid != user.uid) return Container();
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
            subtitle: Column(
              children: <Widget> [
                Text(animal.animalType),
                FlatButton.icon(
                  onPressed: () async{
                    setState(() => loading = true);
                   await _db.deleteAnimal(animal.userid+animal.name+animal.animalType);
                   widget.toggleView(1, error: error);
                  },
                  icon: Icon(Icons.delete_forever_sharp),
                  label: Text('delete'),
                )
                ]),
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
            subtitle: Column(
              children: <Widget> [
                Text(animal.animalType),
                FlatButton.icon(
                  onPressed: () async{
                   await _db.deleteAnimal(animal.userid+animal.name+animal.animalType);
                   await storage.deleteFile(animal.userid+animal.name+animal.animalType);
                   widget.toggleView(1, error: error);
                  },
                  icon: Icon(Icons.delete_forever_sharp),
                  label: Text('delete'),
                )
                ]),
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
