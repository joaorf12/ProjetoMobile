import 'package:flutter/material.dart';

import 'screens/android/Cadastro.dart';
import 'screens/android/CadastroLivro.dart';
import 'screens/android/EditarLivro.dart';
import 'screens/android/Livros.dart';
import 'screens/android/Login.dart';
import 'screens/android/TelaLivro.dart';

void main(){
  runApp(MaterialApp(initialRoute: '/', routes: {
    '/': (context) => Login(),
    '/cadastro': (context) => Cadastro(),
    '/livros': (context) => Livros(),
    TelaLivro.routeName: (context) => TelaLivro(),
    EditarLivro.routeName: (context) => EditarLivro(),
    '/cadLivro': (context) => CadastroLivro(),
  }));
}