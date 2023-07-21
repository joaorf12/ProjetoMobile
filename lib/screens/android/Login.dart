import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto/dao/UsuarioDao.dart';
import 'package:projeto/service/LoginService.dart';
import 'package:projeto/service/UsuarioService.dart';

import '../../service/LivroService.dart';


class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  Future<bool> login(email, senha) async {
    try {
      Future usuario = new UsuarioDao().getUsuario(email);
      if (await usuario.then((value) => value?.senha == senha)){
        return true;
      }
    }
    catch (e) {
      return false;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    String email = "";
    String senha = "";

    final loginController = TextEditingController();
    final senhaController = TextEditingController();

    return MaterialApp(
      title: "App Mobile",
      home: Scaffold(
          appBar: AppBar(
            title: Text("Login"),
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
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                    child: Image(
                      image: NetworkImage("https://png.pngtree.com/template/20190316/ourmid/pngtree-books-logo-image_79143.jpg"),
                      height: 200,
                      width: 200,
                    ),
                  ),
                  Container(
                    //color: Colors.amber,
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: TextField(
                      controller: loginController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(80.0)),
                          labelText: "Login"),
                    ),
                  ),
                  Container(
                    //color: Colors.purple,
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: TextField(
                      controller: senhaController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(80.0)),
                          labelText: "Senha"),
                    ),
                  ),
                  Container(
                    //color: Colors.blueAccent,
                    padding: EdgeInsets.all(20),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size.fromHeight(50),
                            shape: StadiumBorder()),
                        child: Text("Entrar"),
                        onPressed: () {
                          logar(loginController.text, senhaController.text, context);
                        }),
                  ),
                  Container(
                    //color: Colors.blueAccent,
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size.fromHeight(50),
                            shape: StadiumBorder()),
                        child: Text("Cadastrar-se"),
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed('/cadastro');
                        }),
                  )
                ],
              ),
            ),
          )),
    );
  }

  Future<void> _showMyDialog(context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title:  Text('Erro!'),
          content:  SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Email ou senha incorretos.'),
                /*Text('Would you like to approve of this message?'),*/
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Confirmar'),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                      return Login();
                    }));
              },
            ),
          ],
        );
      },
    );
  }

  logar(String email, String senha, BuildContext context){
    bool valor;
    new LoginService().login(email, senha).then((value) {
      if(value){
        print('Usuario logado... '+value.toString());
        //  Modular.to.navigate('/cadastrar_clientes');
        Navigator.of(context).pushReplacementNamed('/livros');
      }else{
        print('Usuario ou senha errados ');

        _showMyDialog(context);
      }
    });
  }
}
