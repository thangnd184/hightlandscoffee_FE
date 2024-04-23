import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:highlandcoffeeapp/pages/home/home_page.dart';
import 'package:highlandcoffeeapp/pages/login_and_register/toggle/login_register_switcher_user_page.dart';

class AuthUserPage extends StatefulWidget {
  const AuthUserPage({Key? key}) : super(key: key);

  @override
  State<AuthUserPage> createState() => _AuthUserPageState();
}

class _AuthUserPageState extends State<AuthUserPage> {
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginRegisterSwitcherUserPage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      return HomePage();
    } else {
      return LoginRegisterSwitcherUserPage();
    }
  }
}
