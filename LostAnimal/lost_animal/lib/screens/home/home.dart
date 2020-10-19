import 'package:flutter/material.dart';
import 'package:lost_animal/models/animal.dart';
import 'package:lost_animal/services/auth.dart';
import 'package:lost_animal/services/database.dart';
import 'package:provider/provider.dart';
import 'package:lost_animal/screens/home/Animal_List.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Animal>>.value(
        value: DatabaseService().animals,
        child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Lost Animals') ,
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              onPressed: () async{
                await _auth.signOut();
              }, 
              icon: Icon(Icons.person), 
              label: Text('logout')
              )
          ]),
          body: AnimalList(),
      ),
    );
  }
}