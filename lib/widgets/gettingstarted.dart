import 'package:budget/widgets/Budgeter.dart';
import 'package:flutter/material.dart';

import 'package:budget/databases/user.dart';

class GettingStarted extends StatefulWidget {
  @override
  _GettingStartedState createState() => _GettingStartedState();
}

class _GettingStartedState extends State<GettingStarted> {
  
  bool isfinish = false;
  void finish(){
    setState(() {
      isfinish=!isfinish;
    });
  }
  TextEditingController amount = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return isfinish == false
        ? Scaffold(
            body: Container(
              width: double.infinity,
              color: Color.fromRGBO(230, 245, 229, 1),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image(
                      image: AssetImage("assets/logo.jpg"),
                      width: 200,
                    ),
                    Container(
                      margin: EdgeInsets.all(20),
                      child: Text(
                        "Before we get Started , Please tell us your Weekly Budget!",
                        style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(28, 153, 65, 1)),
                      ),
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 300,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: amount,
                            decoration: InputDecoration(
                              labelText: "Weekly Budget",
                            ),
                          ),
                        ),
                        FloatingActionButton(onPressed: (){
                        finish();
                        }, child: Icon(Icons.send,color: Color.fromRGBO(28, 153, 65, 1),),
                        backgroundColor: Color.fromRGBO(230, 255, 229, 1,))
                      ],
                    ),
                  ]),
            ),
          )
        : Budgeter(double.parse(amount.text));
  }
}
