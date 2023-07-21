import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'db1.db');

  return openDatabase(
      path,
    onCreate: (db, version){
        db.execute('CREATE TABLE usuario(id INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT, email TEXT UNIQUE, senha TEXT)');
        db.execute('CREATE TABLE livro(id INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT, autor TEXT, genero TEXT, ano_publi INTEGER, num_pag INTEGER)');
        db.execute('CREATE TABLE LOGIN (id INTEGER PRIMARY KEY, email TEXT, senha TEXT, permissao TEXT, token TEXT) ');
    },
    version: 1,
  );
}