import 'dart:convert';

import 'package:http/http.dart';

class LoginServices {

  Map<String, String> headers = {"Content-type": "application/json"};

  Future<bool> LoginRequest(String login, String senha) async{
    String url = "https://furnicommerce.herokuapp.com/login";

    String json = '{"email": "${login}", "senha": "${senha}"}';

    Response response = await post(url,headers: headers,body: json);

    String jsonResponse = response.body;

    return jsonDecode(jsonResponse);
  }

  Future<Map<String,String>> RegisterRequest(String nome,String email,String senha, String cpf,String endereco) async{

    String url = "https://furnicommerce.herokuapp.com/register";

    String json = '{"nome":"${nome}","email":"${email}","cpf":"${cpf}","endereco":"${endereco}","senha":"${senha}"}';

    Response response = await post(url,headers: headers,body:json);
    
    String jsonResponse = response.body;

    return jsonDecode(jsonResponse);

  }
}
