import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Edit extends StatefulWidget {
  DocumentSnapshot docToEdit;
  Edit({this.docToEdit});
  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  TextEditingController titulo = TextEditingController();
  TextEditingController conteudo = TextEditingController();

  @override
  void initState() {
    titulo = TextEditingController(text: widget.docToEdit.data()["titulo"]);
    conteudo = TextEditingController(text: widget.docToEdit.data()["conteudo"]);
    super.initState();
  }

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
              widget.docToEdit.reference.update({
                "titulo": titulo.text,
                "conteudo": conteudo.text
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
          Divider(height: 10.0, color: Colors.grey),
          FlatButton(
            onPressed: () {
              widget.docToEdit.reference.delete().whenComplete(
                  () => Navigator.popAndPushNamed(context, "/home"));
            },
            child: Text(
              'Deletar',
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
