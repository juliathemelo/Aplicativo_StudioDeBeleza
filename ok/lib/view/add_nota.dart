import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Add extends StatelessWidget {
  TextEditingController titulo = TextEditingController();
  TextEditingController conteudo = TextEditingController();

  CollectionReference ref = FirebaseFirestore.instance.collection("notas");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          splashRadius: 20,
          onPressed: () {
            Navigator.popAndPushNamed(context, "/home");
          },
        ),
        actions: [
          FlatButton(
            onPressed: () {
              ref.add({
                'titulo': titulo.text,
                'conteudo': conteudo.text
              }).whenComplete(
                  () => Navigator.popAndPushNamed(context, "/home"));
            },
            child: Text(
              'Salvar',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ],
        backgroundColor: Colors.red[700],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(border: Border.all()),
              child: TextField(
                controller: titulo,
                decoration: InputDecoration(hintText: 'Titulo'),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Container(
                decoration: BoxDecoration(border: Border.all()),
                child: TextField(
                  controller: conteudo,
                  maxLines: null,
                  expands: true,
                  decoration: InputDecoration(hintText: 'Conteúdo'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
