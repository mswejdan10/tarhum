import 'package:flutter/material.dart';
import 'package:medicare/screens/home.dart';
import 'package:medicare/auth/loginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth extends StatelessWidget {
  const Auth();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          return Home();
        } else {
          return loginScreen();
        }
      }),
    ));
  }
}
