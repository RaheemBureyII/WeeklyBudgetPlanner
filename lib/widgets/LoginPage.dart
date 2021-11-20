import 'dart:async';

import 'package:budget/databases/user.dart';
import 'package:budget/widgets/gettingstarted.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isloggedin = false;
  bool isvisi = false;
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  void login() {
    setState(() {
      isloggedin = true;
    });
  }

  void visibility() {
    setState(() {
      isvisi = !isvisi;
    });
    Timer(Duration(seconds: 3), () {
      setState(() {
        isvisi = !isvisi;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return isloggedin == false
        ? Scaffold(
          resizeToAvoidBottomInset: false,
            body: Container(
              width: double.infinity,
              color: Color.fromRGBO(230, 245, 229, 1),
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                SizedBox(height: 100),
                Image(image: AssetImage("assets/logo.jpg")),
                Visibility(
                  child: Text("Username or password is incorrect",
                      style: TextStyle(color: Colors.red)),
                  visible: isvisi,
                ),
                SizedBox(height: 5),
                Container(
                  width: 300,
                  child: TextField(
                    controller: username,
                    decoration: InputDecoration(
                        labelText: "Username",
                        fillColor: Colors.white,
                        filled: true),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: 300,
                  child: TextField(
                    controller: password,
                    decoration: InputDecoration(
                        labelText: "Password",
                        fillColor: Colors.white,
                        filled: true),
                  ),
                ),
                SizedBox(height: 20),
                MaterialButton(
                  onPressed: () {
                    for (var x = 0; x < Users.length; x++) {
                      if (Users[x]["username"] == username.text &&
                          Users[x]["password"] == password.text) {
                           
                        login();
                      } else {
                        visibility();
                      }
                    }
                  },
                  child: Text("Login"),
                  color: Color.fromRGBO(28, 153, 65, 1),
                )
              ]),
            ),
          )
        : GettingStarted();
  }
}
