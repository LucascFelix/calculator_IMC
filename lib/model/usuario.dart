// usuario.dart

class Usuario {
  int? id;
  String nome;
  String sobrenome;
  String email;
  String senha;

  Usuario({
    this.id,
    required this.nome,
    required this.sobrenome,
    required this.email,
    required this.senha,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'nome': nome,
      'sobrenome': sobrenome,
      'email': email,
      'senha': senha,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      id: map['id'],
      nome: map['nome'],
      sobrenome: map['sobrenome'],
      email: map['email'],
      senha: map['senha'],
    );
  }
}
