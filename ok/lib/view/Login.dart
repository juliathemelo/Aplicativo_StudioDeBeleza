import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ok/view/Welcome.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _email, _password;

  checkAuth() async {
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        print(user);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Start()));
      }
    });
    @override
    void initState() {
      super.initState();
      this.checkAuth();
    }
  }

  @override
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
                            validator: (input) {
                              if (input.isEmpty) return "Inserir Email";
                            },
                            decoration: InputDecoration(
                                labelText: "Email",
                                prefixIcon: Icon(Icons.email)),
                            onSaved: (input) => _email = input),
                      ),
                      SizedBox(height: 10),
                      Container(
                        child: TextFormField(
                            validator: (input) {
                              if (input.length < 6)
                                return "Senha Precisa Ter No Minimo 6 Caracteres";
                            },
                            decoration: InputDecoration(
                                labelText: "Senha",
                                prefixIcon: Icon(Icons.lock)),
                            obscureText: true,
                            onSaved: (input) => _password = input),
                      ),
                      SizedBox(height: 50),
                      RaisedButton(
                          padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
                          onPressed: login,
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
                        MaterialPageRoute(builder: (context) => Start()));
                  }),
            ],
          ),
        ),
      ),
    );
  }

  showError(String errormessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Erro"),
            content: Text(errormessage),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Ok"),
              ),
            ],
          );
        });
  }

  login() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        UserCredential user = await _auth.signInWithEmailAndPassword(
            email: _email, password: _password);
      } catch (e) {
        showError(e.message);
        print(e);
      }
    }
  }
}
