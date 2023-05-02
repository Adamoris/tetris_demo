import 'package:tetris_basic/screens/login.dart';
import 'package:tetris_basic/screens/title.dart';
import 'package:flutter/material.dart';
import 'package:tetris_basic/services/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'size_config.dart';

class AuthChecker extends StatelessWidget {
  const AuthChecker({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    User? user = Auth().user;
    if (user == null) {
      return const LoginScreen();
    } else {
      Auth().verifyEmail().then((value) {
        if (value != null) {
          print("The user is verified!");
        } else {
          print("The user is not verified!");
        }
      });

      return const TitleScreen();
    }
  }
}
