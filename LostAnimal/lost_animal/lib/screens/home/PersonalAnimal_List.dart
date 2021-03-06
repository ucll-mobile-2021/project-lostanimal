import 'package:flutter/material.dart';
import 'package:lost_animal/models/animal.dart';
import 'package:lost_animal/models/user.dart';
import 'package:lost_animal/screens/home/personalAnimalTile.dart';
import 'package:provider/provider.dart';

class PersonalAnimalList extends StatefulWidget {
  final Function toggleView;
  final User user;

  PersonalAnimalList({this.toggleView, this.user});
  @override
  _PersonalAnimalListState createState() => _PersonalAnimalListState(user: user);
}

class _PersonalAnimalListState extends State<PersonalAnimalList> {
  User user;

  _PersonalAnimalListState({this.user});
  
  @override
  Widget build(BuildContext context) {
    List animals = Provider.of<List<Animal>>(context);
    if(animals == null){
      animals = new List<Animal>();
    }
    return ListView.builder(
      itemCount: animals == null ? 0 : animals.length,
      key: Key(animals.length.toString()),
      itemBuilder: (context, index) {
        return PersonalAnimalTile(animal: animals[index], toggleView: widget.toggleView, user: user);
      },
    );
  }
}