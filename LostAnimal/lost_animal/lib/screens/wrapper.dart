import 'package:flutter/material.dart';
import 'package:lost_animal/models/user.dart';
import 'package:lost_animal/screens/authenticate/authenticate.dart';
import 'package:lost_animal/screens/home/home.dart';
import 'package:lost_animal/screens/post/post.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
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
