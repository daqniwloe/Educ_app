import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educ_app/models/user_model.dart';
import 'package:educ_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:http/http.dart' as http;

void main() => runApp(LoginApp());

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: MaterialApp(
        title: 'Flutters Educ APP',
        theme: ThemeData(primarySwatch: Colors.blue, primaryColor: Colors.green),
        home: LoginPage(),
      ),
    );
  }
}

void postHTTP() async {
  var url = 'http://treinamento.educ.ifrn.edu.br/api/admin/user/get_token/';
  var response = await http.post(url, body: {'username': '790.463.984-04', 'password': '123'});

  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');
}

Future<String> getJSONData() async {
  var response = await http.get(
      Uri.encodeFull("http://treinamento.educ.ifrn.edu.br/api/educ/diario/meus_diarios/"),
      headers: {"Authorization": "Token dfba99dbad894452f843d1af00ffbcd559c63e59"});

  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');
}

Future<List<dynamic>> getJSONDataa() async {
  final response = await http.get(
      Uri.encodeFull("http://treinamento.educ.ifrn.edu.br/api/admin/user/269/"),
      headers: {"Authorization": "Token dfba99dbad894452f843d1af00ffbcd559c63e59"});

  print(response.body);
}

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  // f45d27
  // f5851f

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //getJSONData();

    return Scaffold(
        key: _scaffoldKey,
        body: ScopedModelDescendant<UserModel>(
          builder: (context, child, model) {
            if (model
                .isLoading) // Se o modelo estiver carregando Algo, irá retornar um Temporizador
              return Center(
                child: CircularProgressIndicator(),
              );
            return SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 2.5,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color(0xFF3337E8), Color(0xFF3871FF)],
                          ),
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(90))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Spacer(),
                          Align(
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.person,
                              size: 90,
                              color: Colors.white,
                            ),
                          ),
                          Spacer(),
                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 32, right: 7),
                              child: Text(
                                'EDUC',
                                style: TextStyle(color: Colors.white, fontSize: 30),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 2,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(top: 62),
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width / 1.2,
                            height: 45,
                            padding: EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(50)),
                                color: Colors.white,
                                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)]),
                            child: TextFormField(
                              scrollPadding: EdgeInsets.all(16.0),
                              controller: _emailController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                icon: Icon(
                                  Icons.email,
                                  color: Colors.grey,
                                ),
                                hintText: 'Login',
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: (text) {
                                if (text.isEmpty || text.contains("@")) return "Email Inválido";
                              },
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.2,
                            height: 45,
                            margin: EdgeInsets.only(top: 32),
                            padding: EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(50)),
                                color: Colors.white,
                                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)]),
                            child: TextFormField(
                              scrollPadding: EdgeInsets.all(16.0),
                              controller: _passController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                icon: Icon(
                                  Icons.vpn_key,
                                  color: Colors.grey,
                                ),
                                hintText: 'Senha',
                              ),
                              obscureText: true,
                              validator: (text) {
                                if (text.isEmpty || text.length < 6) return "Senha Inválida";
                              },
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: FlatButton(
                              onPressed: () {},
                              padding: const EdgeInsets.only(top: 7, right: 32),
                              child: Text(
                                'Esqueceu a senha ?',
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                          Container(
                            height: 45,
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: RaisedButton(
                              shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(30.0)),
                              color: Colors.blueAccent,
                              child: Text(
                                'Login'.toUpperCase(),
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  return Navigator.push(context,
                                      MaterialPageRoute(builder: (contex) => HomeScreen()));
                                }
                                ;
                                model.signIn(
                                    email: _emailController.text,
                                    pass: _passController.text,
                                    onSuccess: _onSuccess,
                                    onFail: _onFail);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }

  void _onSuccess() {
    Navigator.push(context, MaterialPageRoute(builder: (contex) => HomeScreen()));
  }

  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Falha ao Efetuar Login!"),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));
  }
}
