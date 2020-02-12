import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educ_app/models/user.dart';
import 'package:educ_app/screens/aluno_frequencia_screen.dart';
import 'package:educ_app/screens/teste_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:educ_app/main.dart';
import 'package:http/http.dart' as http;

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {

  Resp resp;

  bool hasData = false;
  final storage = new FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    getJSONData();
  }

  lerToken() async{
    String s = await storage.read(key: "protectToken");
    return s;

  }

  //Quero usar o token armazenado Aqui
  getJSONData() async {
    var token = await lerToken();
    //var teste = token.replaceAll(new RegExp('""'),'');
    print(token);

    var response = await http.get(
        Uri.encodeFull(
            "http://treinamento.educ.ifrn.edu.br/api/educ/diario/meus_diarios/"),
        //headers: {"Authorization": "Token dfba99dbad894452f843d1af00ffbcd559c63e59"
        headers: {"Authorization": "Token ${token}"

        });

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
    return (!hasData)
        ? CircularProgressIndicator()
        :
    Stack(

      children: <Widget>[
        _buildBodyBack(),
        CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              //Onde deixa o item fixo no Scroll
              floating: true,
              snap:
              true, // quando abaixar a tela o titulo vai sumir. Quando subir, ele reaparece.
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text("Educ Panel"),
                centerTitle: true,
              ),
            ),
            SliverToBoxAdapter(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: [
                    DataColumn(
                        label: Text('Componente',
                            style: TextStyle(fontSize: 20))),
                    DataColumn(
                        label: Text('Frequencia',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 20))),
                    DataColumn(
                        label: Text('Notas',
                            style: TextStyle(fontSize: 20))),
                    DataColumn(
                        label: Text('Qtd Alunos',
                            style: TextStyle(fontSize: 20))),
                    DataColumn(
                        label: Text('Professor',
                            style: TextStyle(fontSize: 20))),
                    DataColumn(
                        label:
                        Text('Sala', style: TextStyle(fontSize: 20))),
                    DataColumn(
                        label:
                        Text('Turma', style: TextStyle(fontSize: 20)))
                  ],
                  rows: <DataRow>[
                    DataRow(cells: [
                      DataCell(Text(
                        resp.componente.text,
                        style: TextStyle(color: Colors.white),

                      ),
                          onTap:()=> Navigator.push(context,
                              MaterialPageRoute(builder: (contex) => listFrequencia()))
                      ),
                      DataCell(Text(
                        resp.percentualLancamentoFrequencia.toString(),
                        style: TextStyle(color: Colors.white),
                      )),
                      DataCell(Text(
                        resp.percentualLancamentoNotas.toString(),
                        style: TextStyle(color: Colors.white),
                      )),
                      DataCell(Text(
                        resp.qtdAlunos.toString(),
                        style: TextStyle(color: Colors.white),
                      )),
                      DataCell(Text(
                        resp.professor.text,
                        style: TextStyle(color: Colors.white),
                      )),
                      DataCell(Text(
                        resp.sala.text,
                        style: TextStyle(color: Colors.white),
                      )),
                      DataCell(Text(
                        resp.turma.text,
                        style: TextStyle(color: Colors.white),
                      )),
                    ])
                  ],
                ),
              ),

            ),

          ],

        ),



      ],
    );
  }


}