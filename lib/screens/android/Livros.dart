import 'package:flutter/material.dart';
import 'package:projeto/dao/LivroDao.dart';

import '../../model/Livro.dart';
import '../../service/LivroService.dart';
import 'TelaLivro.dart';

class Livros extends StatefulWidget {
  const Livros({Key? key}) : super(key: key);

  @override
  State<Livros> createState() => _LivrosState();
}

class _LivrosState extends State<Livros> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Livros',
      home: Scaffold(
        appBar: AppBar(
            title: Text('Livros'),
            backgroundColor: Colors.grey.shade800,
            actions: <Widget>[
              IconButton(
                  onPressed: () =>
                      Navigator.of(context).pushReplacementNamed('/'),
                  icon: const Icon(Icons.exit_to_app))
            ]),
        body:FutureBuilder<List<Livro>>(
            future: LivroService().getLivros(),
            initialData: [],
            builder: (context, snapshot){
              final List<Livro>? livros = snapshot.data;
              //return snapshot.hasData?
              return ListView.builder(
                padding: const EdgeInsets.all(10.0),
                itemCount: livros?.length,
                itemBuilder: (context, i) {
                  final Livro livro = livros![i];
                  return opcoes(livro);
                },

              );
            },
          ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/cadLivro');
          },
          backgroundColor: Colors.green,
          child: const Icon(Icons.add),
        ),
    ),
    );
  }

  opcoes(livro) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushReplacementNamed('/livro', arguments: livro);
      },
      child: Container(
        height: 124.0,
        width: 300.0,
        margin: new EdgeInsets.only(left: 10.0, top: 20.0, bottom: 20.0),
        decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: new BorderRadius.circular(8.0),
            boxShadow: <BoxShadow>[
              new BoxShadow(
                color: Colors.black54,
                blurRadius: 5.0,
                offset: new Offset(2.0, 5.0),
              )
            ]),
        child: ListTile(
            title: Text(
              livro.nome,
              style: TextStyle(fontSize: 20),
            ),
            subtitle: Text(
              "Autor: " +
                  livro.autor +
                  "\n"
                      "Gênero: " +
                  livro.genero +
                  "\n"
                      "Ano de publicação: " +
                  livro.ano_publi.toString() +
                  "\n"
                      "Numero de páginas: " +
                  livro.num_pag.toString() +
                  "\n",
              style: TextStyle(fontSize: 16),
            )),
      ),
    );
  }
}
