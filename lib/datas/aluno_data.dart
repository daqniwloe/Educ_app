import 'package:cloud_firestore/cloud_firestore.dart';

class AlunoData {
  String category;
  String id;

  String nome;
  int matricula;
  List notas;

  List frequencia;

  List matematica;
  List portugues;

  Timestamp data;

  AlunoData.fromDocument(DocumentSnapshot doc) {
    id = doc.documentID;
    nome = doc["nome"];
    matricula = doc["matricula"];
    notas = doc["notas"]; //+ 0.0 para virar Double

    frequencia = doc["frequencia"];

    matematica = doc["matematica"];
    portugues = doc["portugues"];
    data = doc["data"];


  }
}