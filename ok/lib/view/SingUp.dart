import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ok/view/HomePage.dart';
import 'package:provider/provider.dart';
import 'package:ok/controller/controller.dart';

class SingUp extends StatefulWidget {
  @override
  _SingUpState createState() => _SingUpState();
}

class _SingUpState extends State<SingUp> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String a = "Usuario nn encontrado";

  TextEditingController _email = TextEditingController();
  TextEditingController _telefone = TextEditingController();
  TextEditingController _nome = TextEditingController();
  TextEditingController _password = TextEditingController();

  CollectionReference ref = FirebaseFirestore.instance.collection("usuarios");
  @override
  String validateemail(value) {
    if (value.isEmpty) {
      return "Campo obrigatório *";
    } else if (!(value.contains('@') && value.contains('.com'))) {
      return "Digite um email válido *";
    } else {
      return null;
    }
  }

  String validatepass(value) {
    if (value.isEmpty) {
      return "Campo obrigatório *";
    } else if (value.toString().length < 7) {
      return "Digite uma senha com mais de 7 digitos";
    } else {
      return null;
    }
  }

  String validatename(value) {
    if (value.isEmpty) {
      return "Campo obrigatório *";
    } else {
      return null;
    }
  }

  String validatephone(value) {
    if (value.isEmpty) {
      return "Campo obrigatório *";
    } else if (value.toString().length < 11) {
      return "Digite o seu DDD + Número";
    } else {
      return null;
    }
  }

  void singupSave() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        UserCredential user = await _auth.createUserWithEmailAndPassword(
            email: _email.text.trim(), password: _password.text.trim());
        AddInfo(_email.text.trim(), _nome.text.trim(), _telefone.text.trim());
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
        if (user != null) {
          // UserUpdateInfo updateuser = UserUpdateInfo();
          // updateuser.displayName = _name;
          //  user.updateProfile(updateuser);
          await _auth.currentUser.updateProfile(displayName: _nome.text.trim());
          // await Navigator.pushReplacementNamed(context,"/") ;

        }
      } catch (e) {
        showError(a);
        print(e);
      }
    }
  }

  showError(String errormessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('ERROR'),
            content: Text(errormessage),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'))
            ],
          );
        });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[800],
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 250,
                child: Image(
                  image: AssetImage("assets/limpezadepele.png"),
                  fit: BoxFit.contain,
                ),
              ),
              Container(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: TextFormField(
                          validator: validatename,
                          controller: _nome,
                          decoration: InputDecoration(
                            labelText: "Name",
                            prefixIcon: Icon(Icons.person),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        child: TextFormField(
                          controller: _email,
                          validator: validateemail,
                          decoration: InputDecoration(
                              labelText: 'Email',
                              prefixIcon: Icon(Icons.email)),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        child: TextFormField(
                          controller: _telefone,
                          validator: validatephone,
                          decoration: InputDecoration(
                              labelText: "DDD + 9 + Phone",
                              prefixIcon: Icon(Icons.email)),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        child: TextFormField(
                          obscureText: true,
                          validator: validatepass,
                          controller: _password,
                          decoration: InputDecoration(
                              labelText: 'Senha',
                              prefixIcon: Icon(Icons.email)),
                        ),
                      ),
                      SizedBox(height: 30),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.only(left: 55, right: 55),
                          child: ElevatedButton(
                              child: Text("Cadastrar"),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.yellow[900],
                                minimumSize: Size(370, 50),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)),
                              ),
                              onPressed: () {
                                singupSave();
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
