import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request = "https://api.hgbrasil.com/finance?format=json&key=284133e5";

void main() async {
  runApp(MaterialApp(
    home: Home(),
    theme: ThemeData(
      hintColor: Colors.amber,
      primaryColor: Colors.white,
    ),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  double dolar;
  double euro;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "\$ Conversor \$",
        ),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapshot) {
          //onde snapshot é uma cópia dos dados recebidos no getData
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: Text(
                  "Carregando Dados...",
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 25.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            default:
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "Erro ao Carregar Dados!",
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 25.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              } else {
                dolar = snapshot.data["results"]["currencies"]["USD"]["buy"];
                euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];

                return SingleChildScrollView(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Icon(
                        Icons.monetization_on,
                        color: Colors.amber,
                        size: 150.0,
                      ),
                      Divider(),
                      TextField(
                        decoration: InputDecoration(
                          labelText: "Reais",
                          labelStyle: TextStyle(
                            color: Colors.amber,
                          ),
                          border: OutlineInputBorder(),
                          prefixText: "R\$ ",
                        ),
                        style: TextStyle(
                            color: Colors.amber,
                            fontSize: 25.0
                        ),
                      ),
                      Divider(),
                      TextField(
                        decoration: InputDecoration(
                          labelText: "Dólares",
                          labelStyle: TextStyle(
                            color: Colors.amber,
                          ),
                          border: OutlineInputBorder(),
                          prefixText: "US\$ ",
                        ),
                        style: TextStyle(
                            color: Colors.amber,
                            fontSize: 25.0
                        ),
                      ),
                      Divider(),
                      TextField(
                        decoration: InputDecoration(
                          labelText: "Euros",
                          labelStyle: TextStyle(
                            color: Colors.amber,
                          ),
                          border: OutlineInputBorder(),
                          prefixText: "€ ",
                        ),
                        style: TextStyle(
                            color: Colors.amber,
                            fontSize: 25.0
                        ),
                      ),
                    ],
                  ),
                );
              }
          }
        },
      ),
    );
  }
}

Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}
