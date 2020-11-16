import 'package:flutter/material.dart';
import 'package:lost_animal/services/database.dart';
import 'package:lost_animal/services/storage.dart';

class Avatar extends StatelessWidget {
  final String animalId;
  final Function onTap;
  final Storage storage = Storage();
  final DatabaseService db = DatabaseService();

  Avatar({this.animalId, this.onTap});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: storage.getAnimalProfileImage(animalId),
        // ignore: missing_return
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          print("**********************************************************");
          if (!snapshot.hasData) {
            print("+++++++++++++++++++");
            return GestureDetector(
                onTap: onTap,
                child: CircleAvatar(
                  radius: 50.0,
                  child: Icon(Icons.photo_camera),
                ));
          }
          if (snapshot.hasData) {
            final url = snapshot.data;
            print("********************************************************** ${url}");
            return GestureDetector(
                onTap: onTap,
                child: CircleAvatar(
                  radius: 50.0,
                  backgroundImage: NetworkImage(url),
                ));
          }
        });
    /* return GestureDetector(
      onTap: onTap,
      child: Center(
        child: avatarUrl == null
            ? CircleAvatar(
                radius: 50.0,
                child: Icon(Icons.photo_camera),
              )
            : CircleAvatar(
                radius: 50.0,
                backgroundImage: NetworkImage(avatarUrl),
              ),
      ),
    );*/
  }
}
