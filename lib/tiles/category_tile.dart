import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educ_app/screens/aluno_screen.dart';

import 'package:educ_app/screens/frequencia_screen.dart';
import 'package:educ_app/screens/nota_screen.dart';
import 'package:flutter/material.dart';

class CategoryTile extends StatelessWidget {

  final DocumentSnapshot snapshot;
  CategoryTile(this.snapshot);

  @override
  Widget build(BuildContext context) {

    return ListTile(
      leading: CircleAvatar(
        radius: 25.0,
        backgroundColor: Colors.transparent,
        backgroundImage: NetworkImage(snapshot.data["icon"]),
      ),
      title: Text(snapshot.data["title"]),
      trailing: Icon(Icons.keyboard_arrow_right),

      onTap: (){

        if(snapshot.data["title"] == "Lançar Frequencia"){
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context)=>FrequenciaScreen(snapshot))
          );
        }

        if(snapshot.data["title"] == "Lançar Notas"){
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context)=>NotaScreen(snapshot))
          );
        }

        if(snapshot.data["title"] == "Visualizar Alunos"){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context)=>AlunoScreen(snapshot))
        );
        }



      },

    );
  }
}
