import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educ_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:http/http.dart' as http;

class HomeTab extends StatelessWidget {
  Resp resp;

  @override
  Widget build(BuildContext context) {
    Future<String> getJSONData() async {
      var response = await http.get(
          Uri.encodeFull("http://treinamento.educ.ifrn.edu.br/api/educ/diario/meus_diarios/"),
          headers: {"Authorization": "Token dfba99dbad894452f843d1af00ffbcd559c63e59"});

      print('Response status: ${response.statusCode}');
      //print('Response body: ${response.body}');

      Map userMap = jsonDecode(response.body);
      resp = Resp.fromJson(userMap["result"][0]);
      print(resp.professor.text);

      //  List<User> users = userMap['result'].map<User>((json)=>
      //     User.fromJson(json),

      //  ).toList();

      // print(users.toString());
    }

    getJSONData();
    // Trabalhando o Degrade do app
    Widget _buildBodyBack() => Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromARGB(255, 51, 55, 232),
            Color.fromARGB(255, 56, 113, 255),
          ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        );

    // stack para quando quer escrever algo em cima de um fundo
    return Stack(
      children: <Widget>[
        _buildBodyBack(),
        CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              //Onde deixa o item fixo no Scroll
              floating: true,
              snap: true, // quando abaixar a tela o titulo vai sumir. Quando subir, ele reaparece.
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text("Educ Panel"),
                centerTitle: true,
              ),
            ),

            /* SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  DataColumn(label: Text('Nome')),
                  DataColumn(
                      label: Text(
                    'Matricula',
                    overflow: TextOverflow.ellipsis,
                  )),
                  DataColumn(label: Text('Notas')),
                  DataColumn(label: Text('Frequencia')),
                ],
              ),
            )*/
          ],
        )
      ],
    );
  }
}
