import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeTab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    // Trabalhando o Degrade do app
    Widget _buildBodyBack() => Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 51, 55, 232),
            Color.fromARGB(255, 56, 113, 255),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight
        )
      ),
    );

    // stack para quando quer escrever algo em cima de um fundo
    return Stack(
      children: <Widget>[
        _buildBodyBack(),
        CustomScrollView(
          slivers: <Widget>[
            SliverAppBar( //Onde deixa o item fixo no Scroll
              floating: true,
              snap: true, // quando abaixar a tela o titulo vai sumir. Quando subir, ele reaparece.
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text("Educ Panel"),
                centerTitle: true,
              ),
            ),
            FutureBuilder<QuerySnapshot>(
              future: Firestore.instance
                .collection("home").orderBy("pos").getDocuments(),
              builder: (context, snapshot){
                if(!snapshot.hasData)
                  return SliverToBoxAdapter(
                    child: Container(
                      height: 200.0,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  );
                else
                  //Contar o número de Blocos
                  return SliverStaggeredGrid.count(
                      crossAxisCount: 2,
                    mainAxisSpacing: 1.0, //Espaçamento Vertical
                    crossAxisSpacing: 1.0, //Espaçamento Horizontal

                    staggeredTiles: snapshot.data.documents.map(

                        (doc){
                          return StaggeredTile.count(doc.data["x"], doc.data["y"]);
                  }
                    ).toList(),

                    children: snapshot.data.documents.map(
                        (doc){
                          return FadeInImage.memoryNetwork(
                              placeholder: kTransparentImage,
                              image: doc.data["image"],
                              fit: BoxFit.cover,
                          );
                        }
                    ).toList(),

                  );
              },
            )
          ],
        )
      ],
    );
  }
}
