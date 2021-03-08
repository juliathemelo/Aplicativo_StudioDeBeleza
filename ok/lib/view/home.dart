import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.dashboard),
            tooltip: "Tips",
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.navigate_next),
            tooltip: 'Next page',
            onPressed: () {},
          ),
        ],
        backgroundColor: Colors.red[700],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.red[700],
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => Add()));
        },
      ),
      body: StreamBuilder(
          stream: ref.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount:
                    snapshot.hasData ? snapshot.data.documents.length : 0,
                itemBuilder: (_, index) {
                  return Container(
                    margin: EdgeInsets.all(15),
                    height: 150,
                    color: Colors.grey[300],
                    child: Column(
                      children: [
                        Text(snapshot.data.documents[index].data["titulo"]),
                      ],
                    ),
                  );
                });
          }),
    );
  }
}
