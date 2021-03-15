import 'package:flutter/material.dart';
import 'package:ok/controller/controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SobrancelhaSimples extends StatelessWidget {
  String telefone;

  SobrancelhaSimples({this.telefone});

  void lauchWhatsapp({@required number, @required message}) async {
    String url = "whatsapp://send?phone=$number=$message";
    await canLaunch(url) ? launch(url) : print("Can't Open Whatsapp");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[200],
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 300),
                        Text("Sobrancelha Simples",
                            style: TextStyle(
                                fontSize: 56,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                            textAlign: TextAlign.left),
                        Text("Tipo: Sobrancelha",
                            style: TextStyle(
                                fontSize: 31,
                                color: Colors.black,
                                fontWeight: FontWeight.w300),
                            textAlign: TextAlign.left),
                        Divider(color: Colors.black38),
                        SizedBox(height: 32),
                        Text(
                          "Preço: 35,00 - Não Acompanha Henna. Serviço de limpeza e desenho para a sua sobrancelha dando um novo olhar glamouroso. Agende agora o seu serviço.",
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w300),
                        ),
                        SizedBox(height: 32),
                        Divider(color: Colors.black38),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 32.0),
                    child: Text(
                      'Gallery',
                      style: TextStyle(
                        fontSize: 25,
                        color: const Color(0xff47455f),
                        fontWeight: FontWeight.w300,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    height: 250,
                    padding: const EdgeInsets.only(left: 32.0),
                    child: ListView(
                      children: <Widget>[
                        SizedBox(height: 15),
                        CarouselSlider(
                          options: CarouselOptions(
                            height: 180,
                            enlargeCenterPage: true,
                            autoPlay: true,
                            aspectRatio: 16 / 9,
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enableInfiniteScroll: true,
                            autoPlayAnimationDuration:
                                Duration(milliseconds: 800),
                            viewportFraction: 0.8,
                          ),
                          items: [
                            Container(
                              margin: EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                image: DecorationImage(
                                    image: AssetImage("assets/limpeza.jpg"),
                                    fit: BoxFit.cover),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(""),
                                  Padding(
                                    padding: const EdgeInsets.all(58),
                                    child: Text(
                                      "Cliente: Maju",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w300),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                image: DecorationImage(
                                    image: AssetImage("assets/hidratacao.jpg"),
                                    fit: BoxFit.cover),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(""),
                                  Padding(
                                    padding: const EdgeInsets.all(58),
                                    child: Text(
                                      "Cliente: Arthut",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w300),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                image: DecorationImage(
                                    image: AssetImage("assets/botox.jpg"),
                                    fit: BoxFit.cover),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(""),
                                  Padding(
                                    padding: const EdgeInsets.all(58),
                                    child: Text(
                                      "Cliente: Carla",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w300),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: RaisedButton(
                        color: Colors.yellow[800],
                        padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
                        onPressed: () {
                          lauchWhatsapp(
                              number: "+81996524630",
                              message:
                                  "Olá Roberta, Gostaria de marcar uma consulta de Sobrancelha Simples ! (Informar nome, horário e endereço)");
                        },
                        child: Text(
                          "Agendar Agora",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            Positioned(
              right: -64,
              child: Hero(tag: 1, child: Image.asset("assets/detalhe.png")),
            ),
            Positioned(
              top: 60,
              left: 32,
              child: Text(
                "1",
                style: TextStyle(
                  fontSize: 247,
                  color: Colors.black.withOpacity(0.08),
                  fontWeight: FontWeight.w900,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
