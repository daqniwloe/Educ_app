import 'dart:convert';

import 'package:educ_app/models/user.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;

//aluno_frequencia_screen


class aluno_frequencia_screen extends StatefulWidget {

  @override
  _HomeTabState createState() => _HomeTabState();
}


class _HomeTabState extends State<aluno_frequencia_screen> {

  Resp2 resp2;
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

  getJSONData() async {
    var token = await lerToken();
    //var teste = token.replaceAll(new RegExp('""'),'');
    print(token);

    var response = await http.get(
        Uri.encodeFull(
            "http://treinamento.educ.ifrn.edu.br/api/educ/diario/1410/"),
        //headers: {"Authorization": "Token dfba99dbad894452f843d1af00ffbcd559c63e59"
        headers: {"Authorization": "Token ${token}"

        });

    print('Response status: ${response.statusCode}');
    //print('Response body: ${response.body}');

    Map userMap = jsonDecode(response.body);
    resp2 = Resp2.fromJson(userMap["result"][0]);
    print(resp2.situacao);

    setState(() {
      Map userMap = jsonDecode(response.body);
      resp2 = Resp2.fromJson(userMap["result"][0]);
      hasData = true;
    });

    //  List<User> users = userMap['result'].map<User>((json)=>
    //     User.fromJson(json),
    //  ).toList();
    // print(users.toString());
  }



  Widget _buildBodyBack() => Container(
    decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromARGB(255, 51, 55, 232),
          Color.fromARGB(255, 56, 113, 255),
        ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
  );

  @override
  Widget build(BuildContext context) {

    return
      //(!hasData)
          //? CircularProgressIndicator()
          //:

      Scaffold(


        //_buildBodyBack(),
    //Onde deixa o item fixo no Scroll

        appBar: AppBar(
          title: Text("Alunos Diário"),
          centerTitle: true,
        ),

        body:
        DataTable(
          columns: [
            DataColumn(
                label: Text('Aluno',
                    style: TextStyle(fontSize: 20))),
            DataColumn(
                label: Text('Diário',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 20))),
            DataColumn(
                label: Text('Faltas',
                    style: TextStyle(fontSize: 20))),
            DataColumn(
                label: Text('Série',
                    style: TextStyle(fontSize: 20))),
            DataColumn(
                label: Text('Situação',
                    style: TextStyle(fontSize: 20))),

          ],
          rows: <DataRow>[
            DataRow(cells: [
              DataCell(Text(
                resp2.aluno.text,
                style: TextStyle(color: Colors.white),

              ),
                  //onTap:()=> Navigator.push(context,
                     // MaterialPageRoute(builder: (contex) => aluno_frequencia_screen()))
              ),
              DataCell(Text(
                resp2.diario.text,
                style: TextStyle(color: Colors.white),
              )),
              DataCell(Text(
                resp2.get_qtd_faltas.toString(),
                style: TextStyle(color: Colors.white),
              )),
              DataCell(Text(
                resp2.get_serie.text,
                style: TextStyle(color: Colors.white),
              )),
              DataCell(Text(
                resp2.situacao,
                style: TextStyle(color: Colors.white),
              )),

            ])
          ],
        ),
      );


  }

}
