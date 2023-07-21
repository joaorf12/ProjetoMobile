import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import '../dao/LoginDAO.dart';
import '../model/Livro.dart';
import '../model/Usuario.dart';
class LivroService{

  final String API_REST = "http://10.0.2.2:8080";

  Future<List<Livro>> getLivros() async{

    return LoginDao().getUsuarioLogado().then((value) async {

      String token = " Bearer "+value!.token;
      Map<String, String> header = <String, String>{
        "Content-Type":"application/json",
        "Authorization": token
      };

      final response = await http.get(Uri.parse(API_REST+'/livro/livros'), headers: header);
      debugPrint("Status Code: "+response.statusCode.toString());
      debugPrint("valor: "+response.body.toString());
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));

        return jsonResponse.map<Livro>( (json)=> Livro.fromJson(json) ).toList();

      } else {
        throw Exception('Falha ao ler Cliente');
      }
    });

  }

  Future<Livro> cadLivro(String nome, String autor, String genero, int ano_publi, int num_pag) async {
    return LoginDao().getUsuarioLogado().then((value) async {

      String token = " Bearer "+value!.token;
      Map<String, String> header = <String, String>{
        "Content-Type":"application/json",
        "Authorization": token
      };

      final conteudo = json.encode(<String, dynamic>{'nome': nome,
        'autor': autor,
        'genero': genero,
        'ano_publi': ano_publi,
        'num_pag': num_pag
      });

      final response = await http.post(Uri.parse(API_REST+"/livro/save"),headers: header, body: conteudo);
      debugPrint("Status Code: "+response.statusCode.toString());
      debugPrint("valor: "+response.body.toString());
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));

        return Livro.fromJson(jsonResponse);

      } else {
        throw Exception();
      }
    });
  }

}