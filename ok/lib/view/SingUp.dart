import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ok/view/HomePage.dart';

class SingUp extends StatefulWidget {
  @override
  _SingUpState createState() => _SingUpState();
}

class _SingUpState extends State<SingUp> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _email, _password, _name, _phone;

  String a = "Usuario nn encontrado";

  checkAuth() async {
    _auth.authStateChanges().listen((user) async {
      if (user != null) {
        Navigator.pushReplacementNamed(context, "/");
      }
    });
  }

  TextEditingController email = TextEditingController();
  TextEditingController telefone = TextEditingController();
  TextEditingController nome = TextEditingController();

  CollectionReference ref = FirebaseFirestore.instance.collection("usuarios");
  @override
  void initState() {
    super.initState();
    this.checkAuth();
  }

  signUp() async {
    if (email != "@") {
      ref.add(
          {"email": email.text, "telefone": telefone.text, "nome": nome.text});
    }
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      try {
        UserCredential user = await _auth.createUserWithEmailAndPassword(
            email: _email, password: _password);
        if (user != null) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage()));
          await _auth.currentUser.updateProfile(displayName: _name);
        } else if (user != _email) {
          showError(a);
        }
      } catch (e) {
        showError(e.message);
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
                          validator: (input) {
                            if (input.isEmpty) return "Enter Name";
                          },
                          decoration: InputDecoration(
                            labelText: "Name",
                            prefixIcon: Icon(Icons.person),
                          ),
                          onSaved: (input) => _name = input,
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        child: TextFormField(
                            controller: email,
                            validator: (input) {
                              if (input.isEmpty) return 'Enter Email';
                            },
                            decoration: InputDecoration(
                                labelText: 'Email',
                                prefixIcon: Icon(Icons.email)),
                            onSaved: (input) => _email = input),
                      ),
                      SizedBox(height: 10),
                      Container(
                        child: TextFormField(
                            controller: telefone,
                            validator: (input) {
                              if (input.length < 11)
                                return 'Enter Phone with DDD';
                            },
                            decoration: InputDecoration(
                                labelText: "DDD + 9 + Phone",
                                prefixIcon: Icon(Icons.email)),
                            onSaved: (input) => _email = input),
                      ),
                      SizedBox(height: 10),
                      Container(
                        child: TextFormField(
                            obscureText: true,
                            validator: (input) {
                              if (input.length < 6)
                                return 'Enter Password, Minimum 6 Character';
                            },
                            decoration: InputDecoration(
                                labelText: 'Senha',
                                prefixIcon: Icon(Icons.email)),
                            onSaved: (input) => _email = input),
                      ),
                      SizedBox(height: 30),
                      RaisedButton(
                        padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
                        onPressed: signUp,
                        child: Text('SignUp',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold)),
                        color: Colors.yellow[900],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
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
