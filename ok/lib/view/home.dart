import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ok/view/edit_nota.dart';
import "add_nota.dart";

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ref = FirebaseFirestore.instance.collection("notas");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MyFavorited"),
        actions: <Widget>[],
        backgroundColor: Colors.red[700],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.red[700],
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => Add()));
        },
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: ref.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: snapshot.hasData ? snapshot.data.docs.length : 0,
                itemBuilder: (_, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => Edit(
                                    docToEdit: snapshot.data.docs[index],
                                  )));
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      height: 250,
                      color: Colors.grey[300],
                      child: Column(
                        children: [
                          Text(
                              snapshot.data.docs[index]
                                  .data()["titulo"]
                                  .toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20)),
                          Divider(height: 15.0, color: Colors.grey),
                          Text(snapshot.data.docs[index].data()["conteudo"]),
                        ],
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
