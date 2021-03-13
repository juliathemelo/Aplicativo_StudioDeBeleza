import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

String error;
getEmail(user) {
  try {
    return user.email;
  } catch (e) {
    return 'erro';
  }
}

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<String> singIn({String email, String password}) async {
    try {
      // ignore: unused_local_variable
      UserCredential user = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "Logged in";
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "ERROR_EMAIL_ALREADY_IN_USE":
        case "account-exists-with-different-credential":
        case "email-already-in-use":
          error = "Este e-mail já cadastrado.";
          break;
        case "ERROR_WRONG_PASSWORD":
        case "wrong-password":
          error = "Combinação de e-mail/senha incorreta.";

          break;
        case "ERROR_USER_NOT_FOUND":
        case "user-not-found":
          error = "Nenhum usuário foi encontrado com este endereço de e-mail.";

          break;
        case "ERROR_USER_DISABLED":
        case "user-disabled":
          error = "Usuário desativado.";

          break;
        case "ERROR_TOO_MANY_REQUESTS":
        case "operation-not-allowed":
          error =
              "Foram realizadas muitas requisições para acessar esta conta.";

          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
        case "operation-not-allowed":
          error = "Erro de servidor, tente novamente mais tarde.";

          break;
        case "ERROR_INVALID_EMAIL":
        case "invalid-email":
          error = "E-mail inválido.";

          break;
        default:
          error = "O login falhou, tente novamente.";

          break;
      }
    }
    if (error != null) {
      return Future.error(error);
    } else {
      return null;
    }
  }
}

class Servico {
  final int position;
  final String name;
  final String iconImage;
  final String description;
  final List<String> images;

  Servico(this.position,
      {this.name, this.iconImage, this.description, this.images});
}

List<Servico> servico = [
  Servico(1,
      name: "Sobrancelha Simples",
      iconImage: "assets/detalhe.png",
      description:
          "Preço: 35,00 - Não Acompanha Henna. Serviço de limpeza e desenho para a sua sobrancelha dando um novo olhar glamouroso. Agende agora o seu serviço.",
      images: ["assets/limpezadepele.png", "assets/promocao.png"]),
];
