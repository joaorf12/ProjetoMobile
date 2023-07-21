import 'package:flutter/material.dart';
import 'package:projeto/dao/LivroDao.dart';
import 'package:projeto/model/Livro.dart';
import 'package:projeto/service/LivroService.dart';

class CadastroLivro extends StatefulWidget {
  const CadastroLivro({Key? key}) : super(key: key);

  @override
  State<CadastroLivro> createState() => _CadastroLivroState();
}

class _CadastroLivroState extends State<CadastroLivro> {

  @override
  Widget build(BuildContext context) {
    final nomeController = TextEditingController();
    final autorController = TextEditingController();
    final generoController = TextEditingController();
    final ano_publiController = TextEditingController();
    final num_pagController = TextEditingController();

    return MaterialApp(
      title: "Cadastrar Livro",
      home: Scaffold(
        appBar: AppBar(
            title: Text('Cadastrar Livro'),
            backgroundColor: Colors.grey.shade800,
            leading: BackButton(
              onPressed: () =>
                  Navigator.of(context).pushReplacementNamed('/livros'),
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
            ]
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
                      controller: nomeController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(80.0)),
                          labelText: "Nome"),
                    ),
                  ),
                  Container(
                    //color: Colors.purple,
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: TextField(
                      controller: autorController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(80.0)),
                          labelText: "Autor"),
                    ),
                  ),
                  Container(
                    //color: Colors.amber,
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: TextField(
                      controller: generoController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(80.0)),
                          labelText: "Gênero"),
                    ),
                  ),
                  Container(
                    //color: Colors.purple,
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: ano_publiController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(80.0)),
                          labelText: "Ano de publicação"),
                    ),
                  ),
                  Container(
                    //color: Colors.purple,
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: num_pagController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(80.0)),
                          labelText: "Número de páginas"),
                    ),
                  ),
                  Container(
                    //color: Colors.blueAccent,
                    padding: EdgeInsets.all(20),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            minimumSize: Size.fromHeight(50),
                            shape: StadiumBorder()),
                        child: Text("Cadastrar"),
                        onPressed: () async {
                          cadastrar(nomeController.text,
                              autorController.text,
                              generoController.text,
                              ano_publiController.text,
                              num_pagController.text,
                              context);
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
          content:  SingleChildScrollView(
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

  cadastrar(String nome, String autor, String genero, String ano_publi, String num_pag, BuildContext context){
    bool valor;
    new LivroService().cadLivro(nome, autor, genero, int.parse(ano_publi), int.parse(num_pag)).then((value) {
      //if(value){
        print('Livro cadastrado... '+value.toString());
        //  Modular.to.navigate('/cadastrar_clientes');
        //Navigator.of(context).pushReplacementNamed('/livros');
        _showMyDialog(value, 'Confirmação!', "Cadastro feito com sucesso.");
    });
  }
}

