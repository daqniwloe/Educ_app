import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:educ_app/globals.dart' as globals;


//DefaultTabController

class listFrequencia extends StatefulWidget {

  @override
  _HomeTabState createState() => _HomeTabState();
  bool _value1 = false;
}



class _HomeTabState extends State<listFrequencia> {


  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
    bool _value1 = false;
  }

  List<Widget> _buildCells(int count) {
    return List.generate(
      count,
      (index) => Container(
        alignment: Alignment.center,
        width: 120.0,
        height: 60.0,
        color: Colors.white,
        margin: EdgeInsets.all(4.0),
        child: Text(names[
            index]), // Se eu rodar, vai ficar toda a tabela com nome " teste" como faço para deixar cada campo com um nome diferente?
      ),
    );
  }

  List<String> names = ['Danilo', 'Alan', 'Bojack', 'Diana'];

  List<Widget> _buildRows(int count) {
    return List.generate(
      count,
      (index) => Row(
        children: _textBox(names.length),
      ),
    );
  }

  List<Widget> _textBox(int count) {

   // bool formKey = GlobalKey<_HomeTabState>();
    bool _value1 = false;
   // bool _value2 = false;

    return List.generate(
      count,
      (index) => Container(

        alignment: Alignment.center,
        width: 120.0,
        height: 60.0,
        color: Colors.white,
        margin: EdgeInsets.all(4.0),

        child: Column(
          children: <Widget>[
            //Text("Janeiro"),

            // O checkbox ta selecionando tudo
             Checkbox(

              value: globals.value1,
              onChanged: (bool value){

                print(globals.value1);
                setState(() {

                  globals.value1 = value;

                });
              },

            ),

          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool _value1 = false;
    //_textBox(names.length);
    return Scaffold(
      appBar: AppBar(
        title: Text("Lançar Frequência"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _buildCells(names.length),
            ),
            Flexible(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _buildRows(names.length),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
