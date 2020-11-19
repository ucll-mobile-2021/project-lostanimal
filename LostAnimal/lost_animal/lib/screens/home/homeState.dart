import 'package:flutter/material.dart';
import 'package:lost_animal/models/animal.dart';
import 'package:lost_animal/models/user.dart';
import 'package:lost_animal/screens/home/home.dart';
import 'package:lost_animal/screens/home/personAnimals.dart';
import 'package:lost_animal/screens/post/addAnimalPicture.dart';
import 'package:lost_animal/screens/home/showAnimal.dart';
import 'package:lost_animal/screens/post/post.dart';

class HomeState extends StatefulWidget {
  final User user;
  HomeState({this.user});
  @override
  _HomeStateState createState() => _HomeStateState(user: user);
}

class _HomeStateState extends State<HomeState> {
  final User user;
  _HomeStateState({this.user});

  int toggleInt = 1;
  String animalId = '';
  Animal a;
  String error = '';

  void toggleView(int toggle, {String id = '', String error =''}) {
    setState(() => toggleInt = toggle);
    setState(() => animalId = id);
    setState(() => this.error = error);
  }

  @override
  Widget build(BuildContext context) {
    if (toggleInt == 1) {
      return Home(toggleView: toggleView, error: error);
    }
    if (toggleInt == 2) {
      return Post(toggleView: toggleView, user: user);
    }
    if (toggleInt == 3) {
      return AddAnimalPicture(toggleView: toggleView, animal: animalId);
    } 
    if (toggleInt == 4){
      return ShowAnimal(toggleView: toggleView, animalId: animalId);
    }
    if(toggleInt == 5){
      return PersonalAnimals(toggleView: toggleView, user: user);
    }
    else {
      return Home(toggleView: toggleView);
    }
  }
}
