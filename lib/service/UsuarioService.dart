import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:projeto/model/Usuario.dart';

class UsuarioService{
  Future<List<Usuario>> getUsuarios() async {
    final response = await http
        .get(Uri.parse('http://10.0.2.2:8080/usuario/usuarios'));

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));

      return jsonResponse.map<Usuario>( (json) => Usuario.fromJson(json) ).toList();
    }
    else {
    throw Exception('Failed to load usuarios');
    }
  }
}