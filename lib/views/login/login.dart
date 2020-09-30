import 'package:FurniCommerce/library/login_inputs.dart';
import 'package:flutter/material.dart';

import 'login_services.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: LoginView(),
    );
  }
}

class LoginView extends StatefulWidget {
  @override
  _LoginView createState() => _LoginView();
}

class _LoginView extends State<LoginView> {
  LoginServices services = LoginServices();
  TextEditingController login = TextEditingController();
  TextEditingController senha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg.jpg"),
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.5), BlendMode.srcOver),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            LoginInput(text: "Email", value: login),
            Padding(padding: EdgeInsets.only(top: 20)),
            LoginInput(text: "Senha", value: senha),
            Padding(padding: EdgeInsets.only(top: 40)),
            Container(
                width: MediaQuery.of(context).size.width * 0.75,
                height: 50,
                child: RaisedButton(
                  onPressed: () => {services.Login(login.text, senha.text)},
                  elevation: 3.5,
                  color: Colors.green,
                  child: Container(
                    child: Text("Entrar"),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                ))
          ],
        ));
  }
}