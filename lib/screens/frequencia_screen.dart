import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educ_app/datas/aluno_data.dart';
import 'package:flutter/material.dart';

class FrequenciaScreen extends StatelessWidget {

  final DocumentSnapshot snapshot;

  FrequenciaScreen(this.snapshot);

  @override
  Widget build(BuildContext context) {


    return Scaffold(
        appBar: AppBar(
          title: Text(snapshot.data["title"]),
          centerTitle: true,
        ),
        body: FutureBuilder<QuerySnapshot>(
          future: Firestore.instance
              .collection("alunos")
              .document("lancarFrequencia")
              .collection("atributos")
              .getDocuments(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(),
              );
            else {
              List<AlunoData> alunos = [];
              for (DocumentSnapshot doc in snapshot.data.documents) {
                alunos.add(AlunoData.fromDocument(doc));
              }
              return DataTable(
                columns: [
                  DataColumn(label: Text('Nome')),
                  DataColumn(
                      label: Text(
                        'Matricula',
                        overflow: TextOverflow.ellipsis,
                      )),
                  DataColumn(label: Text('Frequência')),
                ],
                rows: _fillRows(alunos),
              );
            }
          },
        ));

  }

  List<DataRow> _fillRows(List<AlunoData> alunos) {
    List<DataRow> linhas = [];
    for (AlunoData aluno in alunos) {
      linhas.add(DataRow(cells: [
        DataCell(
          Text(
            aluno.nome,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        DataCell(Text(
          aluno.matricula.toString(),
          overflow: TextOverflow.ellipsis,
        )),
        DataCell(Text(
          aluno.frequencia[0],
          overflow: TextOverflow.ellipsis,
        )),
      ]));
    }
    return linhas;
  }

}