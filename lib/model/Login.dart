import 'dart:convert';
import 'package:flutter/cupertino.dart';

class Login{
  String email;
  String senha;
  String permissao;
  String token;

  Login(this.email, this.senha, this.permissao, this.token);

  factory Login.fromJson(Map<String, dynamic> json){
    Map<String, dynamic> permissaoDecode = json['permissao'];
    return Login(json['email'], "",
        permissaoDecode['nome'], json['token']);
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'senha': senha,
      'permissao': permissao,
      'token': token,
    };
  }

}