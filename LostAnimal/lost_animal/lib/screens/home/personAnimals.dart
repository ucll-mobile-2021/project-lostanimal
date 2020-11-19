import 'package:flutter/material.dart';
import 'package:lost_animal/models/animal.dart';
import 'package:lost_animal/models/user.dart';
import 'package:lost_animal/screens/home/PersonalAnimal_List.dart';
import 'package:lost_animal/services/database.dart';
import 'package:provider/provider.dart';

class PersonalAnimals extends StatefulWidget{
  final Function toggleView;
  final User user;
  PersonalAnimals({this.toggleView, this.user});
  
  @override
  _PersonalAnimalsState createState() => _PersonalAnimalsState(user: user);
}

class _PersonalAnimalsState extends State<PersonalAnimals>{
  User user;

  _PersonalAnimalsState({this.user});

  
  @override
  Widget build(BuildContext context){
    return StreamProvider<List<Animal>>.value(
      value: DatabaseService().animals,
      child: Scaffold(
       resizeToAvoidBottomInset: false,
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              title: Text('post your missing animals'),
              actions: <Widget>[
                FlatButton.icon(
                    onPressed: () {
                      widget.toggleView(1);
                    },
                    icon: Icon(Icons.home),
                    label: Text('Home'))
              ],
            ),
      body:PersonalAnimalList(toggleView: widget.toggleView, user: user),

    ));
  }
}