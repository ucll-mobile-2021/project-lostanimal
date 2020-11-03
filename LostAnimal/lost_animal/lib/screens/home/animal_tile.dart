import 'package:flutter/material.dart';
import 'package:lost_animal/models/animal.dart';

class AnimalTile extends StatelessWidget {
  final Animal animal;

  AnimalTile({this.animal});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
          margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
          child: ListTile(
            leading: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.brown[30],
            ),
            title: Text(animal.name),
            subtitle: Text(animal.animalType),
          ),
        ));
  }
}
