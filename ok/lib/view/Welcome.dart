import 'package:flutter/material.dart';

class Start extends StatefulWidget {
  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[800],
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    "Welcome to ",
                    style: TextStyle(
                        fontWeight: FontWeight.w200,
                        fontSize: 35,
                        color: Colors.yellow[900]),
                  ),
                  Text(
                    "New Look",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 26,
                        color: Colors.yellow[900]),
                  ),
                  Image.asset(
                    "assets/rmpng.png",
                    width: 400.0,
                    height: 250.0,
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.yellow[900]),
                        borderRadius: BorderRadius.circular(70)),
                    child: Text(
                      "Login",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.yellow[900]),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
