import 'dart:convert';

class LoginDTO{

  LoginDTO({this.mensagem, this.usuario_id, this.nome, this.email, this.cpf, this.error});

  final int usuario_id;
  final String error;
  final String nome;
  final String email;
  final String cpf;
  final String mensagem;

  factory LoginDTO.fromJson(Map<String,dynamic> json){
    return LoginDTO(
      error: json['error'],
      nome: json['nome'],
      email:json['email'],
      cpf:json['cpf'],
      usuario_id: json['usuario_id'],
      mensagem: json['mensagem']
    );
  }

  List<LoginDTO> parseLogin(String responseBody){
    final data = jsonDecode(responseBody);

    return data.map<LoginDTO>((json) => LoginDTO.fromJson(json)).toList(); 
  }
}