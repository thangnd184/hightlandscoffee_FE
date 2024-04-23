import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:highlandcoffeeapp/pages/admin/admin_page.dart';
import 'package:highlandcoffeeapp/pages/login_and_register/toggle/login_register_switcher_admin_page.dart';
import 'package:highlandcoffeeapp/pages/login_and_register/toggle/login_register_switcher_user_page.dart';

class AuthAdminPage extends StatefulWidget {
  const AuthAdminPage({Key? key}) : super(key: key);

  @override
  State<AuthAdminPage> createState() => _AuthAdminPageState();
}

class _AuthAdminPageState extends State<AuthAdminPage> {
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginRegisterSwitcherAdminPage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      return AdminPage();
    } else {
      return LoginRegisterSwitcherAdminPage();
    }
  }
}
