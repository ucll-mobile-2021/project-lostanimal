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
  bool showHome = true;

  void toggleView() {
    setState(() => showHome = !showHome);
  }

  @override
  Widget build(BuildContext context) {
    if (showHome) {
      return Home(toggleView: toggleView);
    } else {
      return Post(toggleView: toggleView, user: user);
    }
  }
}
