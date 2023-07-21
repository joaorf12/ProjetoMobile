class Comentario {
  int? id;
  String autor;
  String text;
  DateTime dt_hr;

  Comentario(this.autor, this.text, this.dt_hr,
      [this.id]);

  Map<String, dynamic> toMap() {
    return {'id': id, 'autor': autor, 'text': text, 'dt_hr': dt_hr};
  }

  @override
  String toString() {
    return 'Comentario{id: $id, autor: $autor, text: $text, dt_hr: $dt_hr}';
  }
}