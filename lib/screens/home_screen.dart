import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educ_app/screens/aula_screen.dart';
import 'package:educ_app/screens/chat_screen.dart';
import 'package:educ_app/tabs/alunos_tab.dart';
import 'package:educ_app/tabs/home_tab.dart';
import 'package:educ_app/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';




class HomeScreen extends StatelessWidget {

  final _pageController = PageController();// Permite Controlar o PageView


  DocumentSnapshot get snapshot => null;



  @override
  Widget build(BuildContext context) {

    return PageView(
      controller: _pageController, // Chama a Variavel
      physics: NeverScrollableScrollPhysics(), //Impede dos containers ficarem passando de um lado para o outro
      children: <Widget>[
        Scaffold(
          body: HomeTab(),
          drawer: CustomDrawer(_pageController),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Alunos"),
            centerTitle: true,
          ),
          drawer:CustomDrawer(_pageController) ,
          body: AlunosTab(),
        ),
        Scaffold(



          body: AulaScreen(snapshot),
          drawer: CustomDrawer(_pageController) ,
        ),


        Scaffold(

          body: ChatScreen(),
          drawer: CustomDrawer(_pageController),

        ),

      ],
    );
  }
}