import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educ_app/tiles/category_tile.dart';
import 'package:flutter/material.dart';

class AlunosTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      //Chama o Firebase
      future: Firestore.instance.collection("alunos").getDocuments(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: CircularProgressIndicator(),
          );
        else {
          var dividedTiles = ListTile.divideTiles(
                  tiles: snapshot.data.documents.map((doc) {
                    return CategoryTile(doc);
                  }).toList(),
                  color: Colors.grey[500])
              .toList();

          return ListView(
            children: dividedTiles,
          );
        }
      },
    );
  }
}

/*Navigator.of(context).push(
                    MaterialPageRoute(builder: (context)=>AlunoScreen(snapshot))
                );*/
