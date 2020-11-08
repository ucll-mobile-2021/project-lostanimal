import 'package:flutter/material.dart';
import 'package:lost_animal/models/user.dart';
import 'package:lost_animal/screens/home/home.dart';
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

  void toggleView(int toggle) {
    setState(() => toggleInt  = toggle);

  }

  @override
  Widget build(BuildContext context) {
    if (toggleInt == 1) {
      return Home(toggleView: toggleView);
    } 
    if(toggleInt ==2){
    
      return Post(toggleView: toggleView, user: user);
    }

    else {
      return Home(toggleView: toggleView);

    }
  }
}
