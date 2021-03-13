import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:ok/controller/controller.dart';
import 'package:ok/view/HomePage.dart';
import 'package:ok/view/Welcome.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String a = "Usuario nn encontrado";

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

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

  void singinSave() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _email.text.trim(), password: _password.text.trim());
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      } catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
          showError("Esse Email Não Está Cadastrado");
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
      } catch (_) {
        print("nn deu certo");
      }
    }
  }

  showError(String errormessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Erro'),
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
                alignment: Alignment.center,
                height: 250,
                child: Image(
                  image: AssetImage("assets/olhodesigner.png"),
                  fit: BoxFit.contain,
                ),
              ),
              Text(
                "Sing In To App ",
                style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 25,
                    color: Colors.yellow[900]),
              ),
              Text(
                "Welcome Back",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 35,
                    color: Colors.yellow[900]),
              ),
              SizedBox(height: 30),
              Container(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: TextFormField(
                          controller: _email,
                          validator: validateemail,
                          decoration: InputDecoration(
                              labelText: "Email",
                              prefixIcon: Icon(Icons.email)),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        child: TextFormField(
                          controller: _password,
                          validator: validatepass,
                          decoration: InputDecoration(
                              labelText: "Senha", prefixIcon: Icon(Icons.lock)),
                          obscureText: true,
                        ),
                      ),
                      SizedBox(height: 50),
                      RaisedButton(
                          padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
                          onPressed: singinSave,
                          child: Text(
                            "Login",
                            style: TextStyle(
                                color: Colors.yellow[800],
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          )),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                  child: Text(
                    "Create an Account ?",
                    style: TextStyle(
                        color: Colors.yellow[900], fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
