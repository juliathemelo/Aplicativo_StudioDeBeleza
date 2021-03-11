import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ok/view/Welcome.dart';
import 'package:splashscreen/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.black),
      home: ScreenFirts(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ScreenFirts extends StatefulWidget {
  @override
  _ScreenFirtsState createState() => _ScreenFirtsState();
}

class _ScreenFirtsState extends State<ScreenFirts> {
  @override
  Widget build(BuildContext context) {
    return _screenFirst();
  }
}

Widget _screenFirst() {
  return Stack(
    children: <Widget>[
      SplashScreen(
        seconds: 4,
        gradientBackground: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[Colors.blueGrey[800], Colors.blueGrey[900]],
        ),
        navigateAfterSeconds: Start(),
        loaderColor: Colors.transparent,
      ),
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/rmsolopng.png"),
            fit: BoxFit.none,
          ),
        ),
      ),
    ],
  );
}
