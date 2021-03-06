import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lost_animal/models/animal.dart';
import 'package:lost_animal/screens/post/avatar.dart';
import 'package:lost_animal/services/database.dart';
import 'package:lost_animal/services/storage.dart';
import 'package:url_launcher/url_launcher.dart';

class AddAnimalPicture extends StatefulWidget {
  final Function toggleView;
  final String animal;

  AddAnimalPicture({this.toggleView, this.animal});

  @override
  _AddAnimalPictureState createState() =>
      _AddAnimalPictureState(animalId: animal);
}

class _AddAnimalPictureState extends State<AddAnimalPicture> {
  final DatabaseService _db = DatabaseService();
  final Storage _storage = Storage();
  File _image;

  final String animalId;
  _AddAnimalPictureState({this.animalId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _db.getAnimal(animalId),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) return Container();
          final Animal animal = snapshot.data;
          return Scaffold(
              backgroundColor: Colors.brown[100],
              appBar: AppBar(
                backgroundColor: Colors.brown[400],
                elevation: 0.0,
                title: Text('your missing animal'),
                actions: <Widget>[
                  FlatButton.icon(
                      onPressed: () {
                        widget.toggleView(1);
                      },
                      icon: Icon(Icons.home),
                      label: Text('Home'))
                ],
              ),
              body: SingleChildScrollView(
                  child: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                child: Column(
                  children: <Widget>[
                    Avatar(
                      animalId: animal.userid + animal.name + animal.animalType,
                      onTap: () async {
                        await ImagePicker.pickImage(source: ImageSource.gallery)
                            .then((image) {
                          setState(() {
                            _image = image;
                          });
                        });
                        await _storage.uploadFile(_image, animal);
                        widget.toggleView(5);
                      },
                    ),
                    SizedBox(height: 20.0),
                    Text('name: ' + animal.name,
                        style: TextStyle(height: 2, fontSize: 25)),
                    SizedBox(height: 20.0),
                    Text('type: ' + animal.animalType,
                        style: TextStyle(height: 2, fontSize: 25)),
                    SizedBox(height: 20.0),
                    Text('beschrijving: ' + animal.beschrijving,
                        style: TextStyle(height: 2, fontSize: 25)),
                    SizedBox(height: 20.0),
                    Text(
                        'Adres: ${animal.straatnaam} ${animal.huisnr} ${animal.gemeente}',
                        style: TextStyle(height: 2, fontSize: 25)),
                    FlatButton(
                      onPressed: () => launch("tel:+32${animal.phonenr.toString()}"),
                      child: new Text(
                      'phone number: 0${animal.phonenr}',
                        style: TextStyle(height: 2, fontSize: 25),
                        ))
                  ],
                ),
              )));
        });
  }
}
