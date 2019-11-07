import 'package:educ_app/main.dart';
import 'package:educ_app/models/user_model.dart';
import 'package:educ_app/tiles/drawer_tile.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CustomDrawer extends StatelessWidget {

  final PageController pageController; // Da permissao ao custom_drawer para mexer no pageControler

  CustomDrawer(this.pageController);

  @override
  Widget build(BuildContext context) {

    Widget _buildDrawerBack() => Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 51, 55, 232),
                Color.fromARGB(255, 56, 113, 255),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter
          )
      ),
    );

    return Drawer(
      child: Stack(
        children: <Widget>[
          _buildDrawerBack(),
          ListView(
            padding: EdgeInsets.only(left: 32.0, top:16.0),
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 8.0),
                padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
                height: 170.0,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 8.0,
                      left: 0.0,
                      child: Text("Menu Educ",
                        style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Positioned(
                      left: 0.0,
                      bottom: 25.0,
                      child: ScopedModelDescendant<UserModel>(

                        builder: (context, child, model){

                          return  Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Olá, ${!model.isLoggedIn() ? "" : model.userData["name"]}",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              GestureDetector( // Tag de Link
                                child: Text(
                                  !model.isLoggedIn() ?
                                  "Faça o Login"
                                  : "Sair",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                onTap: (){

                                      Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) => LoginApp())
                                      );

                                },
                              )
                            ],
                          );
                        },

                    )
                    )
                  ],
                ), // Utiliza o Stack quando quer posiconar as coisas
              ),
              Divider(), // Tag HR
              DrawerTile(Icons.home, "Início", pageController, 0),
              DrawerTile(Icons.school, "Alunos", pageController, 1),
              DrawerTile(Icons.class_, "Aulas", pageController, 2),
              DrawerTile(Icons.chat, "Chat", pageController, 3),
            ],
          )
        ],
      ),
    );

  }


}
