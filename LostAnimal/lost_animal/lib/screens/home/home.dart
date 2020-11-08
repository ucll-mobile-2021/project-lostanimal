import 'package:flutter/material.dart';
import 'package:lost_animal/models/animal.dart';
import 'package:lost_animal/services/auth.dart';
import 'package:lost_animal/services/database.dart';
import 'package:provider/provider.dart';
import 'package:lost_animal/screens/home/Animal_List.dart';

class Home extends StatefulWidget {
  final Function toggleView;
  Home({this.toggleView});
  @override
  _HomeSState createState() => _HomeSState();
}

class _HomeSState extends State<Home> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Animal>>.value(
        value: DatabaseService().animals,
        child: Scaffold(
          backgroundColor: Colors.deepPurple[50],
          appBar: AppBar(
              title: Text('Lost Animals'),
              backgroundColor: Colors.deepPurpleAccent,
              elevation: 0.0,
              actions: <Widget>[
                FlatButton.icon(
                    onPressed: () async {
                      await _auth.signOut();
                    },
                    icon: Icon(Icons.person),
                    label: Text('logout')),
              ]),
          body: AnimalList(),
          bottomNavigationBar: BottomAppBar(
            child: Row(
              children: <Widget>[
                Spacer(),
                FlatButton.icon(
                    onPressed: () {
                      widget.toggleView(2);
                    },
                    icon: Icon(Icons.add),
                    label: Text('add')),
                FlatButton.icon(
                    onPressed: () async {
                      await _auth.signOut();
                    },
                    icon: Icon(Icons.settings),
                    label: Text('Change Radius'))
              ],
            ),
          ),
        ));
  }
}
