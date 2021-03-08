import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        onPressed: () {},
      ),
      body: GridView.builder(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemCount: 10,
          itemBuilder: (_, index) {
            return Container(
              margin: EdgeInsets.all(15),
              height: 150,
              color: Colors.grey[300],
            );
          }),
    );
  }
}
