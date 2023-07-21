import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:projeto/dao/LoginDao.dart';

import '../model/Login.dart';

class LoginService{

  final String API_REST = "http://10.0.2.2:8080";

  Map<String, String> headers = <String, String>{
    "Content-type":"application/json",
  };


  String? tokenUsuarioLogado(){
    LoginDao().getUsuarioLogado().then((value) {
      print("-->> token: "+value!.token);
      return value!.token;
    });
  }


  Future<bool> login( String email, String senha ) async{

    final conteudo = json.encode(<String, String>{'email': email, 'senha': senha});

    final resposta = await http.post(Uri.parse(API_REST+"/login"),headers: headers, body: conteudo);
    debugPrint("Status Code: "+resposta.statusCode.toString());
    debugPrint("valor: "+resposta.body.toString());

    if(resposta.statusCode == 200){

      Login usuarioLogado = Login.fromJson(jsonDecode(resposta.body));

      new LoginDao().adicionar(usuarioLogado);
      return true;
    }

    return false;
  }

}