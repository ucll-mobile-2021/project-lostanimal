import 'package:flutter/material.dart';
import 'package:lost_animal/models/user.dart';
import 'package:lost_animal/screens/authenticate/authenticate.dart';
import 'package:lost_animal/screens/home/homeState.dart';
import 'package:lost_animal/screens/post/post.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    //return either Home or Authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return HomeState(user: user);
    }
  }
}
