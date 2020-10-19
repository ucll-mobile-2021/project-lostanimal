import 'package:flutter/material.dart';
import 'package:lost_animal/models/animal.dart';
import 'package:provider/provider.dart';
import 'package:lost_animal/screens/home/animal_tile.dart';

class AnimalList extends StatefulWidget {
  @override
  _AnimalListState createState() => _AnimalListState();
}

class _AnimalListState extends State<AnimalList> {
  @override
  Widget build(BuildContext context) {

    final animals = Provider.of<List<Animal>>(context);
    

    return ListView.builder(
      
      itemCount: animals.length,
      itemBuilder: (context, index){
        return AnimalTile(animal: animals[index]);
      },
    );
  }
}