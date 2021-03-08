import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ok/view/add_nota.dart';
import 'package:ok/view/home.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/home': (context) => HomePage(),
        '/add': (context) => Add(),
      },
      title: 'My Favorite List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ScreenTela(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ScreenTela extends StatefulWidget {
  @override
  _ScreenTelaState createState() => _ScreenTelaState();
}

class _ScreenTelaState extends State<ScreenTela> {
  @override
  Widget build(BuildContext context) {
    return _introScreen();
  }
}

Widget _introScreen() {
  return Stack(
    children: <Widget>[
      SplashScreen(
        seconds: 5,
        gradientBackground: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: <Color>[Colors.red, Colors.blue],
        ),
        navigateAfterSeconds: HomePage(),
        loaderColor: Colors.transparent,
      ),
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/logomyfavorite.png"),
            fit: BoxFit.none,
          ),
        ),
      ),
    ],
  );
}
