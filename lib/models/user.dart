class User{

  int id;


  String frequencia;
  String notas;
  String qtdAlunos;

  User(int id, String qtdAlunos, String frequencia, String notas){
    this.id = id;
    this.qtdAlunos = qtdAlunos;
    this.frequencia = frequencia;
    this.notas = notas;

  }

  User.fromJson(Map<String, dynamic> json):
      id = json['id'],

      frequencia = json['get_percentual_lancamento_frequencia'],
      notas = json['get_percentual_lancamento_notas'],
      qtdAlunos = json['get_qtd_alunos'];

  Map toJson(){
    return {'id': id,'get_percentual_lancamento_frequencia': frequencia,
      'get_percentual_lancamento_notas': notas, 'get_qtd_alunos': qtdAlunos
    };
  }

}

class Componente{
  int id;

  String text;

  Componente(int id, String text){
    this.id = id;
    this.text = text;
  }

  Componente.fromJson(Map<String, dynamic> json):
        id = json['id'],

        text = json['text'];

  Map toJson(){
    return {'id': id, 'text': text};
  }
}

class Professor{
  int id;

  String text;

  Professor(int id, String text){
    this.id = id;
    this.text = text;
  }

  Professor.fromJson(Map<String, dynamic> json):
        id = json['id'],

        text = json['text'];

  Map toJson(){
    return {'id': id, 'text': text};
  }
}

class Sala{
  int id;

  String text;

  Sala(int id, String text){
    this.id = id;
    this.text = text;
  }

  Sala.fromJson(Map<String, dynamic> json):
        id = json['id'],

        text = json['text'];

  Map toJson(){
    return {'id': id, 'text': text};
  }
}

class Turma{
  int id;

  String text;

  Turma(int id, String text){
    this.id = id;
    this.text = text;
  }

  Turma.fromJson(Map<String, dynamic> json):
        id = json['id'],

        text = json['text'];

  Map <String, dynamic> toJson() =>
     {
       'id': id,
       'text': text
     };


}

