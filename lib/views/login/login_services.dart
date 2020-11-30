import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart';
import 'loginDTO.dart';

class LoginServices {

  Map<String, String> headers = {"Content-type": "application/json"};

  
  Future <List<LoginDTO>> LoginRequest(String login, String senha) async{
    
    String url = "https://furnicommerce.herokuapp.com/login";

    String json = '{"email": "${login}", "senha": "${senha}"}';

    Response response = await post(url,headers: headers,body: json);

    List<LoginDTO> loginResponse = LoginDTO().parseLogin(response.body);
    
    return loginResponse;
  }

  Future <List<LoginDTO>> RegisterRequest(String email, String senha,String endereco,String cpf,String nome) async{
    
    String url = "https://furnicommerce.herokuapp.com/register";

    Map<String, String> headers = {"Content-type": "application/json"};

    String json = '{"email": "${email}", "senha": "${senha}", "endereco":"${endereco}","nome":"${nome}","cpf":"${cpf}" }';

    Response response = await post(url,headers: headers,body: json);

    List<LoginDTO> loginResponse = LoginDTO().parseLogin(response.body);
    
    return loginResponse;
  }
}