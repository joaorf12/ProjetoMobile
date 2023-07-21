import 'package:projeto/dao/openDatabaseDB.dart';
import 'package:projeto/model/Livro.dart';

import 'dart:async';
import 'package:sqflite/sqflite.dart';

class LivroDao{
  insertLivro(Livro livro) async {
    final db = await getDatabase();

    await db.insert(
      'livro',
      livro.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

  }

  Future<List<Livro>> getLivros() async {
    final db = await getDatabase();

    final List<Map<String, dynamic>> maps = await db.query('livro');

    return List.generate(maps.length, (i) {
      return Livro(
          maps[i]['nome'],
          maps[i]['autor'],
          maps[i]['genero'],
          maps[i]['num_pag'],
          maps[i]['ano_publi'],
          maps[i]['id']
      );
    });
  }

  Future<void> updateLivro(Livro livro) async {
    final db = await getDatabase();

    await db.update(
      'livro',
      livro.toMap(),
      where: 'id = ?',
      whereArgs: [livro.id],
    );
  }

  Future<void> deleteLivro(int? id) async {
    final db = await getDatabase();

    await db.delete(
      'livro',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteDatabase() => databaseFactory.deleteDatabase("db");
}