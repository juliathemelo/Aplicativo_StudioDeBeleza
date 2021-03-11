import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ok/controller/controller.dart';
import 'package:ok/view/sobrancelhasim.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _HomePageState createState() => _HomePageState();
}

const double paddefault = 15;
final user = FirebaseAuth.instance.currentUser;

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final ScrollController cont = ScrollController();
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Serviços",
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
        ),
        backgroundColor: Colors.yellow[900],
        leading: IconButton(
          icon: Icon(
            Icons.person_outline_outlined,
          ),
          color: Colors.white,
          splashRadius: 20,
          iconSize: 25,
          onPressed: () {},
        ),
      ),
      body: Container(
        child: ListView(
          controller: cont,
          children: <Widget>[
            SizedBox(height: paddefault),
            SizedBox(height: 15),
            PlanosContainer(
              width: 1,
              height: 100,
              horizontal: 15,
              vertical: 10,
              image: "assets/promocao.png",
              text: "Promoções",
              action: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SobramcelhaSimples()));
              },
            ),
            SizedBox(height: 15),
            PlanosContainer(
              width: 1,
              height: 100,
              horizontal: 15,
              vertical: 10,
              text: "Sobrancelha Simples",
              image: "assets/sobrancelhasimples.jpg",
              action: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SobramcelhaSimples()));
              },
            ),
            SizedBox(height: 15),
            PlanosContainer(
              width: 1,
              height: 100,
              horizontal: 15,
              vertical: 10,
              text: "Sobrancelha Completa",
              image: "assets/sobrancelhacompleta.jpg",
              action: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SobramcelhaSimples()));
              },
            ),
            SizedBox(height: 15),
            PlanosContainer(
              width: 1,
              height: 100,
              horizontal: 15,
              vertical: 10,
              text: "Limpeza De Pele",
              image: "assets/sobrancelhacompleta.jpg",
              action: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SobramcelhaSimples()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
