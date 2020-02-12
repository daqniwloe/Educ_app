import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educ_app/datas/aluno_data.dart';
import 'package:flutter/material.dart';

class AulaScreen extends StatelessWidget {
  final DocumentSnapshot snapshot;

  AulaScreen(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Lançar Aulas"),
          centerTitle: true,
        ),

        body: FutureBuilder<QuerySnapshot>(
          future: Firestore.instance
              .collection("aulas")
              .document("lancarAula")
              .collection("materias")
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
              return
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: [
                      DataColumn(label: Text('Matéria')),
                      DataColumn(
                          label: Text(
                            'Assunto',
                            overflow: TextOverflow.ellipsis,
                          )),
                      DataColumn(label: Text('Data')),

                    ],
                    rows: _fillRows(alunos),
                  ),
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
            "matematica",
            overflow: TextOverflow.ellipsis,
          ),
        ),
        DataCell(Text(
          aluno.matematica[0],
          overflow: TextOverflow.ellipsis,
        )),
        DataCell(Text(
          aluno.data.toString(),
          overflow: TextOverflow.ellipsis,
        )),

      ]));
    }
    return linhas;
  }
}