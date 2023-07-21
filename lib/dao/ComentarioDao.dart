import 'package:projeto/model/Comentario.dart';

class ComentarioDao{
  List<Comentario> getComentarios() {
    List<Comentario> comentarios = [];
    for (int i = 0 ; i < 10 ; i++ ){
      Comentario comentario = new Comentario("Autor "+i.toString(), "texto "+i.toString(), new DateTime(2023), i);
      comentarios.add(comentario);
    }
    return comentarios;
  }
}