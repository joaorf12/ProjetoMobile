class Usuario {
  int? id;
  String nome;
  String email;
  String senha;

  Usuario(this.nome, this.email, this.senha, [this.id]);

  Map<String, dynamic> toMap() {
    return {'id': id, 'nome': nome, 'email': email, 'senha': senha};
  }

  @override
  String toString() {
    return 'Usuario{id: $id, nome: $nome, email: $email, senha: $senha}';
  }

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      json['nome'],
      json['email'],
      json['senha'],
      json['id'],
    );
  }
}
