import 'package:flutter/material.dart';
import 'package:projeto/dao/LivroDao.dart';

import '../../model/Livro.dart';

class EditarLivro extends StatefulWidget {
  static const routeName = '/editarLivro';

  const EditarLivro({Key? key}) : super(key: key);

  @override
  State<EditarLivro> createState() => _EditarLivroState();
}

class _EditarLivroState extends State<EditarLivro> {
  @override
  Widget build(BuildContext context) {
    final livro = ModalRoute.of(context)?.settings.arguments as Livro;
    return MaterialApp(
      title: "Editar Livro",
      home: Scaffold(
        appBar: AppBar(
          title: Text('Editar Livro'),
          backgroundColor: Colors.grey.shade800,
          leading: BackButton(
            onPressed: () =>
                Navigator.of(context).pushReplacementNamed('/livro', arguments: livro),
          ),
          actions: <Widget>[
            IconButton(
                onPressed: () => Navigator.of(context).pushReplacementNamed('/livros'),
                icon: const Icon(Icons.home)
            ),
            IconButton(
                onPressed: () => Navigator.of(context).pushReplacementNamed('/'), 
                icon: const Icon(Icons.exit_to_app)
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    //color: Colors.amber,
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: TextField(
                      controller: TextEditingController(text: livro.nome),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(80.0)),
                          labelText: "Nome"),
                      onChanged: (text) => livro.nome = text,
                    ),
                  ),
                  Container(
                    //color: Colors.purple,
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: TextField(
                      controller: TextEditingController(text: livro.autor),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(80.0)),
                          labelText: "Autor"),
                      onChanged: (text) => livro.autor = text,
                    ),
                  ),
                  Container(
                    //color: Colors.amber,
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: TextField(
                      controller: TextEditingController(text: livro.genero),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(80.0)),
                          labelText: "Gênero"),
                      onChanged: (text) => livro.genero = text,
                    ),
                  ),
                  Container(
                    //color: Colors.purple,
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: TextField(
                      controller: TextEditingController(text: livro.ano_publi.toString()),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(80.0)),
                          labelText: "Ano de publicação"),
                      onChanged: (text) => {
                        if(text.isEmpty) {
                          livro.ano_publi = 0
                        }
                        else{
                          livro.ano_publi = int.parse(text)
                        }
                      },
                    ),
                  ),
                  Container(
                    //color: Colors.purple,
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: TextField(
                      controller: TextEditingController(text: livro.num_pag.toString()),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(80.0)),
                          labelText: "Número de páginas"),
                      onChanged: (text) => {
                        if(text.isEmpty) {
                          livro.num_pag = 0
                        }
                        else{
                          livro.num_pag = int.parse(text)
                        }
                      },
                    ),
                  ),
                  /*Container(
                    padding: EdgeInsets.all(20),
                    width: 200,
                    child:
                    ElevatedButton(
                      child: Text('Escolher capa'),
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size.fromHeight(50),
                          shape: StadiumBorder()),
                      onPressed: () async {

                      },
                    ),
                  ),*/
                  /*Container(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    width: 200,
                    child:
                    ElevatedButton(
                      child: Text('Escolher pdf'),
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size.fromHeight(50),
                          shape: StadiumBorder()),
                      onPressed: () async {

                      },
                    ),
                  ),*/
                  Container(
                    //color: Colors.blueAccent,
                    padding: EdgeInsets.all(20),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            minimumSize: Size.fromHeight(50),
                            shape: StadiumBorder()),
                        child: Text("Editar"),
                        onPressed: () {
                          var verificacao = livro.nome != "" && livro.autor != "" && livro.genero != "" &&
                              livro.ano_publi != 0 && livro.num_pag != 0;
                          if (verificacao){
                            new LivroDao().updateLivro(livro);
                            _showMyDialog(livro, 'Confirmação!', "Editado com sucesso.");
                          } else {
                            _showMyDialog( null, 'Atenção!', "Algum campo está vazio.");
                          }
                        }),
                  )
                ]),
          ),
        ),
      ),
    );
  }
  Future<void> _showMyDialog(livro, title, mensagem) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(mensagem),
                /*Text('Would you like to approve of this message?'),*/
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Confirmar'),
              onPressed: () {
                if(livro != null){
                  Navigator.of(context).pushReplacementNamed('/livro', arguments: livro);
                }
                else{
                  Navigator.pop(context);
                }
              },
            ),
          ],
        );
      },
    );
  }
}
