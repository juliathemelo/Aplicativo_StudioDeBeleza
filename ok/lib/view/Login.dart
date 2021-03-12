import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ok/view/HomePage.dart';
import 'package:ok/view/Welcome.dart';

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

  void singinpSave() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        UserCredential user = await _auth.signInWithEmailAndPassword(
            email: _email.text.trim(), password: _password.text.trim());
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
        if (user != _email.text.trim()) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('ERROR'),
                  content: Text("Usuario nn encontrado"),
                  actions: <Widget>[
                    FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('OK'))
                  ],
                );
              });

          // UserUpdateInfo updateuser = UserUpdateInfo();
          // updateuser.displayName = _name;
          //  user.updateProfile(updateuser);
          await _auth.currentUser
              .updateProfile(displayName: _email.text.trim());
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
                          onPressed: singinpSave,
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
