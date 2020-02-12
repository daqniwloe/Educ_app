import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Resp {
  Componente componente;
  int percentualLancamentoFrequencia;
  int percentualLancamentoNotas;
  int qtdAlunos;
  int id;
  Professor professor;
  Sala sala;
  Turma turma;



  Resp(this.componente, this.percentualLancamentoFrequencia, this.percentualLancamentoNotas,
      this.qtdAlunos, this.id, this.professor, this.sala, this.turma, );

  Resp.fromJson(Map<String, dynamic> json) {
    componente = Componente.fromJson(json["componente"]);
    percentualLancamentoFrequencia = int.parse(json["get_percentual_lancamento_frequencia"]);
    percentualLancamentoNotas = int.parse(json["get_percentual_lancamento_notas"]);
    qtdAlunos = int.parse(json["get_qtd_alunos"]);
    id = json["id"];
    professor = Professor.fromJson(json["professor"]);
    sala = Sala.fromJson(json["sala"]);
    turma = Turma.fromJson(json["turma"]);



  }

  Map toJson() {
    return {
      "componente": componente.toJson(),
      "get_percentual_lancamento_notas": percentualLancamentoNotas,
      "get_percentual_lancamento_frequencia": percentualLancamentoFrequencia,
      "get_qtd_alunos": qtdAlunos,
      "id": id,
      "professor": professor.toJson(),
      "sala": sala.toJson(),
      "turma": turma.toJson(),


    };
  }
}

class User {
  int id;

  String frequencia;
  String notas;
  String qtdAlunos;

  User(int id, String qtdAlunos, String frequencia, String notas) {
    this.id = id;
    this.qtdAlunos = qtdAlunos;
    this.frequencia = frequencia;
    this.notas = notas;
  }

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        frequencia = json['get_percentual_lancamento_frequencia'],
        notas = json['get_percentual_lancamento_notas'],
        qtdAlunos = json['get_qtd_alunos'];

  Map toJson() {
    return {
      'id': id,
      'get_percentual_lancamento_frequencia': frequencia,
      'get_percentual_lancamento_notas': notas,
      'get_qtd_alunos': qtdAlunos
    };
  }
}

class Componente {
  int id;

  String text;

  Componente(int id, String text) {
    this.id = id;
    this.text = text;
  }

  Componente.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        text = json['text'];

  Map toJson() {
    return {'id': id, 'text': text};
  }
}

class Professor {
  int id;

  String text;

  Professor(int id, String text) {
    this.id = id;
    this.text = text;
  }

  Professor.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        text = json['text'];

  Map toJson() {
    return {'id': id, 'text': text};
  }
}

class Sala {
  int id;

  String text;

  Sala(int id, String text) {
    this.id = id;
    this.text = text;
  }

  Sala.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        text = json['text'];

  Map toJson() {
    return {'id': id, 'text': text};
  }
}

class Turma {
  int id;

  String text;

  Turma(int id, String text) {
    this.id = id;
    this.text = text;
  }

  Turma.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        text = json['text'];

  Map<String, dynamic> toJson() => {'id': id, 'text': text};
}

// Detalhes Diário


class Resp2{

  Aluno aluno;
  Diario diario;
  int get_qtd_faltas;
  Get_serie get_serie;

  int id;

  String situacao;






  Resp2(this.aluno, this.diario, this.get_qtd_faltas, this.get_serie, this.id, this.situacao);

  Resp2.fromJson(Map<String, dynamic>json){
    aluno = Aluno.fromJson(json["aluno"]);
    diario = Diario.fromJson(json["diario"]);
    get_qtd_faltas = int.parse(json["get_qtd_faltas"]);
    get_serie = Get_serie.fromJson(json["get_serie"]);
    id = json["id"];
    situacao = json["situacao"];
  }

  Map toJson(){
    return {
      "aluno": aluno.toJson(),
      "diario":diario.toJson(),
      "get_qtd_faltas":get_qtd_faltas,
      "get_serie":get_serie.toJson(),
      "id":id,
      "situacao":situacao
    };
  }



}


class Aluno{
  int id;
  String text;

  Aluno(int id, String text){
    this.id = id;
    this.text = text;

  }

  Aluno.fromJson(Map<String, dynamic>json):
  id = json['id'],
  text = json['text'];

  Map<String, dynamic> toJson() =>{'id':id, 'text':text};
}

class Diario{
  int id;
  String text;

  Diario(int id, String text){
    this.id = id;
    this.text = text;

  }

  Diario.fromJson(Map<String, dynamic>json):
      id = json['id'],
      text = json['text'];

  Map<String, dynamic>toJson() => {'id':id, 'text':text};
}

class Get_serie{
  int id;
  String text;

  Get_serie(int id, String text){
    this.id = id;
    this.text = text;
  }

  Get_serie.fromJson(Map<String,dynamic>json):
      id = json['id'],
      text = json['text'];

  Map<String, dynamic> toJson() => {'id':id, 'text':text};
}


