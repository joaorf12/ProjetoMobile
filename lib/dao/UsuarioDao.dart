import 'package:projeto/dao/openDatabaseDB.dart';
import 'package:projeto/model/Usuario.dart';

import 'dart:async';
import 'package:sqflite/sqflite.dart';

class UsuarioDao{
  insertUsuario(Usuario usuario) async {
    final db = await getDatabase();

    await db.insert(
      'usuario',
      usuario.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

  }

  Future<List<Usuario>> usuarios() async {
    final db = await getDatabase();

    final List<Map<String, dynamic>> maps = await db.query('usuario');

    return List.generate(maps.length, (i) {
      return Usuario(
        maps[i]['nome'],
        maps[i]['email'],
        maps[i]['senha'],
        maps[i]['id']
      );
    });
  }

  Future<Usuario> getUsuario(String email) async {
    final db = await getDatabase();

    final List<Map<String, dynamic>> maps = await db.query(
        'usuario',
        where: 'email = ?',
        whereArgs: [email]
    );

      return Usuario(
          maps[0]['nome'],
          maps[0]['email'],
          maps[0]['senha'],
          maps[0]['id']
      );
  }

  Future<void> updateUsuario(Usuario usuario) async {
    final db = await getDatabase();

    await db.update(
      'usuario',
      usuario.toMap(),
      where: 'id = ?',
      whereArgs: [usuario.id],
    );
  }

  Future<void> deleteUsuario(int id) async {
    final db = await getDatabase();

    await db.delete(
      'usuario',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteDatabase() => databaseFactory.deleteDatabase("db");
}