import 'package:budget/widgets/LoginPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  Map<int, Color> color =
{
50:Color.fromRGBO(28, 153, 65, 1),
100:Color.fromRGBO(28, 153, 65, 1),
200:Color.fromRGBO(28, 153, 65, 1),
300:Color.fromRGBO(28, 153, 65, 1),
400:Color.fromRGBO(28, 153, 65, 1),
500:Color.fromRGBO(28, 153, 65, 1),
600:Color.fromRGBO(28, 153, 65, 1),
700:Color.fromRGBO(28, 153, 65, 1),
800:Color.fromRGBO(28, 153, 65, 1),
900:Color.fromRGBO(28, 153, 65, 1),
};
  @override
  Widget build(BuildContext context) {
    MaterialColor colorCustom = MaterialColor(0xFF1C9941, color);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: colorCustom,
        textTheme: TextTheme(
      bodyText1: TextStyle(),
      bodyText2: TextStyle(),
    ).apply(
      bodyColor: Colors.white, 
      displayColor: Colors.white, 
    ),
      ),
      home: LoginPage(),
    );
  }
}

