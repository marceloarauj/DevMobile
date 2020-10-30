import 'package:http/http.dart';

class LoginServices {

  Future<bool> LoginRequest(String login, String senha) async{
    String url = "https://furnicommerce.herokuapp.com/login";

    Map<String, String> headers = {"Content-type": "application/json"};

    String json = '{"email": "${login}", "senha": "${senha}"}';

    Response response = await post(url,headers: headers,body: json);

    int status = response.statusCode;
    print(status);
    if(status != 200){
      return false;
    }

    return true;
  }

}

class PostLogin {}
