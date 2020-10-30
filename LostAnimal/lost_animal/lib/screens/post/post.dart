import 'package:flutter/material.dart';
import 'package:lost_animal/services/database.dart';
import 'package:lost_animal/shared/constants.dart';
import 'package:lost_animal/shared/loading.dart';
import 'package:lost_animal/models/user.dart';

class Post extends StatefulWidget {
  final Function toggleView;
  final User user;
  Post({this.toggleView, this.user});

  @override
  _PostState createState() => _PostState(user: user);
}

class _PostState extends State<Post> {
  //final AuthService _auth = AuthService();
  final DatabaseService _db = DatabaseService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  User user;
  _PostState({this.user});

  //textfield state
  String name = '';
  String animalType = '';
  String beschrijving = '';
  String straatnaam = '';
  String huisnummer = '';
  String woonplaats = '';

//extra param
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              title: Text('post your missing animal'),
              actions: <Widget>[
                FlatButton.icon(
                    onPressed: () {
                      widget.toggleView();
                    },
                    icon: Icon(Icons.home),
                    label: Text('Home'))
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'name'),
                        validator: (val) => val.isEmpty
                            ? 'Enter name of the lost animal'
                            : null,
                        onChanged: (val) {
                          setState(() => name = val);
                        }),
                    SizedBox(height: 20.0),
                    TextFormField(
                        decoration: textInputDecoration.copyWith(
                            hintText: 'animaltype'),
                        validator: (val) => val.length < 6
                            ? 'give the type of your animal'
                            : null,
                        onChanged: (val) {
                          setState(() => animalType = val);
                        }),
                    SizedBox(height: 20.0),
                    TextFormField(
                        decoration: textInputDecoration.copyWith(
                            hintText: 'description'),
                        validator: (val) => val.length < 6
                            ? 'give a description of the lost animal'
                            : null,
                        onChanged: (val) {
                          setState(() => beschrijving = val);
                        }),
                    SizedBox(height: 20.0),
                    TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'street'),
                        validator: (val) => val.length < 6
                            ? 'give the streetname of the spot where the animal has been seen last'
                            : null,
                        onChanged: (val) {
                          setState(() => straatnaam = val);
                        }),
                    SizedBox(height: 20.0),
                    TextFormField(
                        decoration: textInputDecoration.copyWith(
                            hintText: 'house number'),
                        validator: (val) =>
                            val.length < 6 ? 'give the house number' : null,
                        onChanged: (val) {
                          setState(() => huisnummer = val);
                        }),
                    SizedBox(height: 20.0),
                    TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'city'),
                        validator: (val) =>
                            val.length < 6 ? 'give the city' : null,
                        onChanged: (val) {
                          setState(() => woonplaats = val);
                        }),
                    SizedBox(height: 20.0),
                    RaisedButton(
                      color: Colors.pink[400],
                      child: Text(
                        'Post',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        await _db.updateAnimalData(
                            name,
                            beschrijving,
                            animalType,
                            straatnaam,
                            huisnummer,
                            woonplaats,
                            user.getUid());
                      },
                    ),
                    SizedBox(height: 12.0),
                    //Text(
                    //error,
                    //style: TextStyle(color: Colors.red, fontSize: 14.0),
                    //)
                  ],
                ),
              ),
            ),
          );
  }
}
