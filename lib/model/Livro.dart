class Livro {
  int? id;
  String nome;
  String autor;
  String genero;
  int num_pag;
  int ano_publi;
  //String capa;
  //String pdf;

  Livro(this.nome, this.autor, this.genero, this.num_pag, this.ano_publi,
       [this.id]);

  Map<String, dynamic> toMap() {
    return {'id': id, 'nome': nome, 'autor': autor, 'genero': genero, 'num_pag': num_pag, 'ano_publi': ano_publi};
  }

  factory Livro.fromJson(Map<String, dynamic> json){
    print(json);
    return Livro(json['nome'], json['autor'], json['genero'], json['num_pag'], json['ano_publi'], json['id']);
  }

  @override
  String toString() {
    return 'Usuario{id: $id, nome: $nome, autor: $autor, genero: $genero, num_pag: $num_pag, ano_publi: $ano_publi}';
  }
}
