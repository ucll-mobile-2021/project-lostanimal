import 'package:flutter/material.dart';
import 'package:lost_animal/screens/home/home.dart';
import 'package:lost_animal/screens/post/post.dart';

class HomeState extends StatefulWidget {
  @override
  _HomeStateState createState() => _HomeStateState();
}

class _HomeStateState extends State<HomeState> {
  bool showHome = true;

  void toggleView() {
    setState(() => showHome = !showHome);
  }

  @override
  Widget build(BuildContext context) {
    if (showHome) {
      return Home(toggleView: toggleView);
    } else {
      return Post(toggleView: toggleView);
    }
  }
}
