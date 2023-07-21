import 'dart:io';

import 'package:flutter/material.dart';
import 'package:projeto/dao/ComentarioDao.dart';
import 'package:projeto/dao/LivroDao.dart';
import 'package:projeto/dao/PdfApi.dart';
import 'package:projeto/model/Comentario.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:projeto/screens/android/LerLivro.dart';

import '../../model/Livro.dart';

class TelaLivro extends StatefulWidget {
  static const routeName = '/livro';

  const TelaLivro({Key? key}) : super(key: key);

  @override
  State<TelaLivro> createState() => _TelaLivroState();
}

class _TelaLivroState extends State<TelaLivro> {
  int idUsuario = 1; //Valor fixo para teste
  List<Comentario> comentarios = new ComentarioDao().getComentarios();

  @override
  Widget build(BuildContext context) {
    final livro = ModalRoute.of(context)?.settings.arguments as Livro;
    return MaterialApp(
      title: "Livro",
      home: Scaffold(
        appBar: AppBar(
            title: Text('Livro'),
            backgroundColor: Colors.grey.shade800,
            leading: BackButton(
              onPressed: () =>
                  Navigator.of(context).pushReplacementNamed('/livros'),
            ),
            actions: <Widget>[
              IconButton(
                  onPressed: () =>
                      Navigator.of(context).pushReplacementNamed('/livros'),
                  icon: const Icon(Icons.home)),
              IconButton(
                  onPressed: () =>
                      Navigator.of(context).pushReplacementNamed('/'),
                  icon: const Icon(Icons.exit_to_app))
            ]),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(20),
                        width: 120,
                        height: 200,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: new BorderRadius.circular(8.0),
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                    "https://marketplace.canva.com/EAE4oJOnMh0/1/0/1003w/canva-capa-de-livro-de-suspense-O7z4yw4a5k8.jpg"))),
                        /*child: const Image(
                          image: NetworkImage(
                              'https://marketplace.canva.com/EAE4oJOnMh0/1/0/1003w/canva-capa-de-livro-de-suspense-O7z4yw4a5k8.jpg'),
                        ),*/
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text('Nome: ' + livro.nome),
                            padding: EdgeInsets.all(10),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text('Autor: ' + livro.autor),
                            padding: EdgeInsets.all(10),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text('Gênero: ' + livro.genero),
                            padding: EdgeInsets.all(10),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text('Número de páginas: ' +
                                livro.num_pag.toString()),
                            padding: EdgeInsets.all(10),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text('Ano de publicação: ' +
                                livro.ano_publi.toString()),
                            padding: EdgeInsets.all(10),
                          ),
                          Container(
                            child: RatingBar.builder(
                              initialRating: 0,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: false,
                              itemCount: 5,
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 2.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Container(),
                  idUsuario == 1
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              //color: Colors.blueAccent,
                              padding: EdgeInsets.all(10),
                              width: 100,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      minimumSize: Size.fromHeight(50),
                                      shape: StadiumBorder()),
                                  child: Text("Ler"),
                                  onPressed: () async {
                                    final path = 'assets/pdfTeste.pdf';
                                    final file = await PdfApi.loadAsset(path);
                                    openPDF(context, file);
                                  }),
                            ),
                            Container(
                              //color: Colors.blueAccent,
                              padding: EdgeInsets.all(10),
                              width: 100,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      minimumSize: Size.fromHeight(50),
                                      shape: StadiumBorder()),
                                  child: Text("Editar"),
                                  onPressed: () => Navigator.of(context)
                                      .pushReplacementNamed('/editarLivro',
                                          arguments: livro)),
                            ),
                            Container(
                              //color: Colors.blueAccent,
                              padding: EdgeInsets.all(10),
                              width: 100,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      minimumSize: Size.fromHeight(50),
                                      shape: StadiumBorder()),
                                  child: Text("Excluir"),
                                  onPressed: () {
                                    if (livro.id != null){
                                      new LivroDao().deleteLivro(livro.id);
                                      Navigator.of(context).pushReplacementNamed('/livros');
                                    }
                                  },
                            ),
                            )],
                        )
                      : Container(
                          //color: Colors.blueAccent,
                          padding: EdgeInsets.all(10),
                          width: 200,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  minimumSize: Size.fromHeight(50),
                                  shape: StadiumBorder()),
                              child: Text("Ler"),
                              onPressed: () async {
                                final path = 'assets/pdfTeste.pdf';
                                final file = await PdfApi.loadAsset(path);
                                openPDF(context, file);
                              }),
                        ),
                  Center(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Text('Comentários'),
                          padding: EdgeInsets.all(10),
                        )
                      ],
                    ),
                  ),
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                         comentarios.map((comentario) => ListTile(
                          titleAlignment: ListTileTitleAlignment.center,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          leading: CircleAvatar(
                            child: Text("Autor"),
                          ),
                          title: Text(comentario.autor,
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          subtitle: Text(comentario.text,
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[900]
                            ),),
                        )).toList(),
                    ),
                  )

                  ]),
          ),
        ),
      ),
    );
  }

  void openPDF(BuildContext context, File file) => Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => LerLivro(file: file))
  );
}


