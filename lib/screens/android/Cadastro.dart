import 'package:flutter/material.dart';
import 'package:projeto/dao/UsuarioDao.dart';
import 'package:projeto/model/Usuario.dart';
import 'package:projeto/screens/android/Login.dart';

import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({Key? key}) : super(key: key);

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  late String nome;
  late String email;
  late String senha;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "App Mobile",
      home: Scaffold(
          appBar: AppBar(
            title: Text("Cadastro"),
            backgroundColor: Colors.grey.shade800,
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    //color: Colors.red,
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 70),
                    child: FlutterLogo(
                      size: 80,
                    ),
                  ),
                  Container(
                    //color: Colors.amber,
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(80.0)),
                          labelText: "Nome"),
                      onChanged: (value) {
                        nome = value;
                      },
                    ),
                  ),
                  Container(
                    //color: Colors.amber,
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(80.0)),
                          labelText: "Email"),
                      onChanged: (value) {
                        email = value;
                      },
                    ),
                  ),
                  Container(
                    //color: Colors.purple,
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(80.0)),
                          labelText: "Senha"),
                      onChanged: (value) {
                        senha = value;
                      },
                    ),
                  ),
                  Container(
                    //color: Colors.blueAccent,
                    padding: EdgeInsets.all(20),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size.fromHeight(50),
                            shape: StadiumBorder()),
                        child: Text("Cadastrar-se"),
                        onPressed: () async {
                          //_showMyDialog();
                          //new UsuarioDao().deleteDatabase();
                          new UsuarioDao().insertUsuario(new Usuario(nome, email, senha));
                          Navigator.of(context).pushReplacementNamed('/');
                        }),
                  )
                ],
              ),
            ),
          )),
    );
  }

  // Future<void> _showMyDialog() async {
  //   return showDialog<void>(
  //     context: context,
  //     barrierDismissible: false, // user must tap button!
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title:  Text('Confirmação!'),
  //         content:  SingleChildScrollView(
  //           child: ListBody(
  //             children: <Widget>[
  //               Text('Cadastro feito com sucesso.'),
  //               /*Text('Would you like to approve of this message?'),*/
  //             ],
  //           ),
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             child: const Text('Confirmar'),
  //             onPressed: () {
  //               Navigator.push(context,
  //                   MaterialPageRoute(builder: (context) {
  //                     return Login();
  //                   }));
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}
