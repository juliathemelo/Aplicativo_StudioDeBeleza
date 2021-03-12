import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PlanosContainer extends StatelessWidget {
  final Key key;
  final double width;
  final double height;
  final double horizontal;
  final double vertical;
  final String text;
  final String image;
  final action;

  const PlanosContainer(
      {this.key,
      @required this.width,
      @required this.height,
      @required this.horizontal,
      @required this.vertical,
      @required this.text,
      this.image,
      this.action});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
        child: Container(
            width: width,
            height: height,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment(0, -0.5),
                    colors: [Colors.yellow[900].withOpacity(1), Colors.black]),
                image: DecorationImage(
                    image: AssetImage(image),
                    fit: BoxFit.cover,
                    alignment: Alignment.topRight,
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.6), BlendMode.dstATop)),
                borderRadius: BorderRadius.circular(80)),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(),
                SizedBox(
                  width: 25,
                ),
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
                Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 25,
                )
              ],
            )),
      ),
    );
  }
}

var _firestore = FirebaseFirestore.instance;

class StudioUser {
  String email;
  String name;
  String telefone;
  StudioUser(this.email, this.name, this.telefone);

  Map<String, dynamic> toMap() {
    return {"email": email, "nome": name, "telefone": telefone};
  }
}

AddInfo(email, name, telefone) {
  var user = StudioUser(email, name, telefone);
  _firestore.collection("usuarios").doc(email).set(user.toMap());
}
