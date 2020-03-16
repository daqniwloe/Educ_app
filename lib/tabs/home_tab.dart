import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educ_app/models/user.dart';
import 'package:educ_app/screens/aluno_frequencia_screen.dart';
import 'package:educ_app/widgets/custom_drawer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:educ_app/main.dart';
import 'package:http/http.dart' as http;
import 'package:horizontal_data_table/horizontal_data_table.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  static const int sortName = 0;
  static const int sortStatus = 1;
  bool isAscending = true;
  int sortType = sortName;

  Resp resp;

  bool hasData = false;
  final storage = new FlutterSecureStorage();
  @override
  void initState() {
    super.initState();
    getJSONData();
  }

  lerToken() async {
    String s = await storage.read(key: "protectToken");
    return s;
  }


  getJSONData() async {
    var token = await lerToken();
    //var teste = token.replaceAll(new RegExp('""'),'');
    print(token);

    var response = await http.get(
        Uri.encodeFull(
            "http://treinamento.educ.ifrn.edu.br/api/educ/diario/meus_diarios/"),
        //headers: {"Authorization": "Token dfba99dbad894452f843d1af00ffbcd559c63e59"
        headers: {"Authorization": "Token ${token}"});

    print('Response status: ${response.statusCode}');
    //print('Response body: ${response.body}');

    Map userMap = jsonDecode(response.body);
    resp = Resp.fromJson(userMap["result"][0]);
    print(resp.componente.text);

    setState(() {
      Map userMap = jsonDecode(response.body);
      resp = Resp.fromJson(userMap["result"][0]);
      hasData = true;
    });

    //  List<User> users = userMap['result'].map<User>((json)=>
    //     User.fromJson(json),
    //  ).toList();
    // print(users.toString());

  }

  final _pageController = PageController(); // Controlar a PageView

  // Trabalhando o Degrade do app
  Widget _buildBodyBack() => Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromARGB(255, 51, 55, 232),
          Color.fromARGB(255, 56, 113, 255),
        ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
      );

  @override
  Widget build(BuildContext context) {
    // stack para quando quer escrever algo em cima de um fundo

    final List<String> lista = [
      'Componente',
      'Frequência',
      'Notas',
      'Qtd Alunos',
      'Professor',
      'Sala',
      'Turma'
    ];

    List<String> dataJson = [
      resp.componente.text,
      resp.percentualLancamentoFrequencia.toString(),
      resp.percentualLancamentoNotas.toString(),
      resp.qtdAlunos.toString(),
      resp.professor.text,
      resp.sala.text,
      resp.turma.text
    ];

//final List<String> dataJson = ['a','b','c','d','e','f', 'g' ];
    return (!hasData)
        ? Center(child: CircularProgressIndicator())
        : Container(
          child: HorizontalDataTable(
            leftHandSideColumnWidth: 100,
            rightHandSideColumnWidth: 600,
            isFixedHeader: true,
            headerWidgets: [
              Text('Titulo 01'),
              Text('Titulo 02'),
            ],
            leftSideItemBuilder: (BuildContext contex, index){return Text(resp.componente.text);},
            rightSideItemBuilder: (BuildContext contex, index){return Text('bbb');},
            itemCount: 5,
            rowSeparatorWidget: const Divider(
              color: Colors.black54,
              height: 1.0,
              thickness: 0.0,
            ),
          ),
          height: MediaQuery.of(context).size.height,
        );




    /*PageView(
            controller: _pageController,
            children: <Widget>[
              Scaffold(
                body: Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.05),
                      width: MediaQuery.of(context).size.width * 0.35,
                      height: double.infinity,
                      color: Colors.blue,
                      child: ListView.separated(
                        itemBuilder: (BuildContext context, index) {
                          return Column(
                            children: <Widget>[
                              Center(
                                child: Text(
                                  index.toString(),
                                  style: TextStyle(
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                        separatorBuilder: (BuildContext context, index) {
                          return Divider(
                            thickness: 2.0,
                          );
                        },
                        itemCount: lista.length,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.65,
                      height: double.infinity,
                      color: Colors.lightBlueAccent,
                      child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: lista.length,
                        separatorBuilder: (BuildContext context, index) {
                          return VerticalDivider(
                            width: 0.0,
                            thickness: 2.0,
                          );
                        },
                        itemBuilder: (BuildContext context, index) {
                          return Column(
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.60,
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                color: Colors.blue,
                                child: Center(
                                    child: Text(
                                  lista[index],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                              ),
                              Expanded(
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                      maxWidth:
                                          MediaQuery.of(context).size.width *
                                              0.60),
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: dataJson.length,
                                      itemBuilder:
                                          (BuildContext context, index) {
                                        return Column(
                                          children: <Widget>[
                                            Text(dataJson[index],
                                                style: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 18.0,
                                                )),
                                            Divider(
                                              thickness: 2.0,
                                            ),
                                          ],
                                        );
                                      }),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );*/
  }
  }


