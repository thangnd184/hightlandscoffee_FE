import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlandcoffeeapp/widgets/login_with_more.dart';
import 'package:highlandcoffeeapp/widgets/my_button.dart';
import 'package:highlandcoffeeapp/widgets/my_text_form_field.dart';
import 'package:highlandcoffeeapp/themes/theme.dart';
import 'package:highlandcoffeeapp/widgets/text_form_field_email.dart';
import 'package:highlandcoffeeapp/widgets/text_form_field_password.dart';

class LoginUserWithEmailAndPasswordPage extends StatefulWidget {
  final Function()? onTap;
  const LoginUserWithEmailAndPasswordPage({super.key, required this.onTap});

  @override
  State<LoginUserWithEmailAndPasswordPage> createState() => _LoginUserWithEmailAndPasswordPageState();
}

class _LoginUserWithEmailAndPasswordPageState extends State<LoginUserWithEmailAndPasswordPage> {
  final _emailController = TextEditingController();
  final _passWordController = TextEditingController();
  bool isLoggedIn = false;
  bool isObsecure = false;

  //
  void loginUserEmail() async {
  String email = _emailController.text.trim();
  String password = _passWordController.text.trim();

  if (email.isEmpty || password.isEmpty) {
    // Show an alert if either email or password is empty
    showEmptyFieldsAlert();
  } else {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      QuerySnapshot users = await FirebaseFirestore.instance
          .collection('Users')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (users.docs.isNotEmpty) {
        String userName = users.docs[0]['email'];
        showSuccessAlert("Đăng nhập thành công với email: $userName");
        Navigator.pushReplacementNamed(context, '/home_page');
      } else {
        showSuccessAlert("Đăng nhập thành công với email: $email");
      }
      showSuccessAlert("Đăng nhập thành công với email: $email");
    } on FirebaseAuthException catch (e) {
      showNotification("Email hoặc mật khẩu không chính xác");
      print("Authentication Error: ${e.message}");
    }
  }
}

//
void showNotification(String message) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(
            "Thông báo",
            style: GoogleFonts.arsenal(
              color: primaryColors,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          content: Text(message),
          actions: [
            CupertinoDialogAction(
              child: Text("OK", style: TextStyle(color: blue)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void dispose() {
    _emailController.text.trim();
    _passWordController.text.trim();

    super.dispose();
  }

  //
  void showSuccessAlert(String message) {
  showCupertinoDialog(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        title: Text(
          "Thông báo",
          style: GoogleFonts.arsenal(
            color: primaryColors,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        content: Text(message),
        actions: [
          CupertinoDialogAction(
            child: Text("OK", style: TextStyle(color: blue)),
            onPressed: () {
              Navigator.of(context).pop();
              // Bạn có thể thêm bất kỳ hành động nào sau khi người dùng nhấn OK
            },
          ),
        ],
      );
    },
  );
}

  //
  void showEmptyFieldsAlert() {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text("Thông báo",
              style: GoogleFonts.arsenal(
                  color: primaryColors,
                  fontWeight: FontWeight.bold,
                  fontSize: 18)),
          content: Text("Đăng nhập không hợp lệ, vui lòng thử lại"),
          actions: [
            CupertinoDialogAction(
              child: Text("OK", style: TextStyle(color: blue)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Padding(
        padding: const EdgeInsets.only(
            left: 18.0, top: 100.0, right: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //title email
            Text(
              'Đăng nhập',
              style: GoogleFonts.arsenal(
                  fontSize: 30.0, fontWeight: FontWeight.bold, color: brown),
            ),
            SizedBox(
              height: 190.0,
            ),
            //form email
            TextFormFieldEmail(
              hintText: 'Email',
              prefixIconData: Icons.email,
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _emailController.clear();
                    });
                  },
                  icon: Icon(Icons.clear, color: primaryColors,)),
              controller: _emailController,
              iconColor: primaryColors,
            ),
            SizedBox(
              height: 20.0,
            ),
            //form password
            TextFormFieldPassword(
              hintText: 'Nhập mật khẩu',
              prefixIconData: Icons.vpn_key_sharp,
              suffixIcon: IconButton(
                icon: Icon(
                  isObsecure ? Icons.visibility : Icons.visibility_off,
                  color: primaryColors,
                ),
                onPressed: () {
                  setState(() {
                    isObsecure = !isObsecure;
                  });
                },
              ),
              controller: _passWordController,
              iconColor: primaryColors,
              obscureText: !isObsecure,
            ),
            SizedBox(
              height: 20.0,
            ),
            //edit password
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Quên mật khẩu?',
                  style: GoogleFonts.roboto(
                      color: blue, decoration: TextDecoration.underline),
                )
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            //button login
            MyButton(
              text: 'Đăng nhập',
              onTap: loginUserEmail,
              buttonColor: primaryColors,
            ),
            SizedBox(
              height: 40.0,
            ),
            //or continue with
            Row(
              children: [
                Expanded(
                  child: Divider(
                    thickness: 1,
                    color: grey,
                  ),
                ),
                Text(
                  '      hoặc      ',
                  style: GoogleFonts.roboto(color: grey),
                ),
                Expanded(
                  child: Divider(
                    thickness: 1,
                    color: grey,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 50.0,
            ),
            //or login with facebook, email, google,...
            Center(
                child: Text('ĐĂNG NHẬP BẰNG',
                    style: GoogleFonts.roboto(color: grey))),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                LoginWithMore(imagePath: 'assets/icons/facebook.png'),
                LoginWithMore(imagePath: 'assets/icons/google.png'),
                LoginWithMore(imagePath: 'assets/icons/apple.png'),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            //text tip
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Chưa có tài khoản? ',
                    style: GoogleFonts.roboto(color: grey)),
                GestureDetector(
                  onTap: widget.onTap,
                  child: Text(
                    'Đăng ký ngay!',
                    style: GoogleFonts.roboto(
                        color: blue,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}