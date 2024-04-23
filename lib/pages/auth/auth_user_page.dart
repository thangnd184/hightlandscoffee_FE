import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:highlandcoffeeapp/pages/home/home_page.dart';
import 'package:highlandcoffeeapp/pages/login_and_register/toggle/login_register_switcher_user_page.dart';

class AuthUserPage extends StatefulWidget {
  const AuthUserPage({super.key});

  @override
  State<AuthUserPage> createState() => _AuthUserPageState();
}

class _AuthUserPageState extends State<AuthUserPage> {
  late StreamSubscription<User?> _authStreamSubscription;
  @override
  void initState() {
    super.initState();
    _authStreamSubscription = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _authStreamSubscription.cancel();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
        if(snapshot.hasData){
          return HomePage();
        }
        else{
          return LoginRegisterSwitcherUserPage();
        }
      }),
    );
  }
}