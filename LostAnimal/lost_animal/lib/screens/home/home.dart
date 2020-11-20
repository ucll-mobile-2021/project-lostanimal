import 'package:flutter/material.dart';
import 'package:lost_animal/models/animal.dart';
import 'package:lost_animal/services/auth.dart';
import 'package:lost_animal/services/database.dart';
import 'package:provider/provider.dart';
import 'package:lost_animal/screens/home/Animal_List.dart';

class Home extends StatefulWidget {
  final Function toggleView;
  final String error;
  Home({this.toggleView, this.error});
  @override
  _HomeSState createState() => _HomeSState(error: error);
}

class _HomeSState extends State<Home> {
  final AuthService _auth = AuthService();
  final String error;

  _HomeSState({this.error});
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
                    icon: Icon(Icons.exit_to_app_rounded),
                    label: Text('logout')),
                FlatButton.icon(
                  onPressed: () {
                    widget.toggleView(5);
                  }, 
                  icon: Icon(Icons.account_circle_sharp), 
                  label: Text(""),
                  
                )
              ]),
          
          body: AnimalList(toggleView: widget.toggleView),
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
                /*FlatButton.icon(
                    onPressed: () async {
                      await _auth.signOut();
                    },
                    icon: Icon(Icons.settings),
                    label: Text('Change Radius'))*/
              ],
            ),
          ),
        ));
  }
}
