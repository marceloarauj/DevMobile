import 'package:FurniCommerce/library/login_inputs.dart';
import 'package:FurniCommerce/views/lista/lista.dart';
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
  bool ehLogin = false;

  TextEditingController cpf = TextEditingController();
  TextEditingController endereco = TextEditingController();
  TextEditingController nome = TextEditingController();

  @override
  _LoginView createState() => _LoginView();
}

class _LoginView extends State<LoginView> {
  LoginServices services = LoginServices();
  TextEditingController login = TextEditingController();
  TextEditingController senha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/bg.jpg"),
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.4), BlendMode.srcOver),
              fit: BoxFit.fill,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top: 40)),
                ehLogin(),
                Padding(padding: EdgeInsets.only(top: 40)),
                LoginInput(
                  text: "Email",
                  value: login,
                  password: false,
                ),
                Padding(padding: EdgeInsets.only(top: 20)),
                LoginInput(
                  text: "Senha",
                  value: senha,
                  password: true,
                ),
                Padding(padding: EdgeInsets.only(top: 40)),
                Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    height: 50,
                    child: RaisedButton(
                      onPressed: () => {
                        services.Login(login.text, senha.text),
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Lista(nome:"ERT")),
                        )
                      },
                      elevation: 3.5,
                      color: Colors.green,
                      child: Container(
                        child: buttonEhLogin(),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                    )),
              ],
            ),
          )),
      floatingActionButton: FloatingActionButton(
          child: Icon(getIconLogin()),
          onPressed: () => setLoginRegistrarButton()),
    );
  }

  Widget ehLogin() {
    if (widget.ehLogin) {
      return Container(
        color: Colors.black.withOpacity(0.1),
        width: MediaQuery.of(context).size.width * 0.5,
        child: Image.asset('assets/logo.png'),
      );
    }
    return Container(
      child: Column(
        children: <Widget>[
          Padding(padding: EdgeInsets.only(top: 40)),
          LoginInput(
            text: "Nome",
            value: widget.nome,
            password: false,
          ),
          Padding(padding: EdgeInsets.only(top: 20)),
          LoginInput(
            text: "CPF",
            value: widget.endereco,
            password: false,
          ),
          Padding(padding: EdgeInsets.only(top: 20)),
          LoginInput(
            text: "Endereço",
            value: widget.cpf,
            password: false,
          ),
        ],
      ),
    );
  }

  Text buttonEhLogin() {
    if (widget.ehLogin) {
      return Text('Login');
    }
    return Text('Registrar');
  }

  setLoginRegistrarButton() {
    setState(() {
      widget.cpf.text = '';
      widget.endereco.text = '';
      widget.nome.text = '';
      login.text = '';
      senha.text = '';
      widget.ehLogin = !widget.ehLogin;
    });
  }

  IconData getIconLogin() {
    if (widget.ehLogin) {
      return Icons.person_add;
    }
    return Icons.portrait;
  }
}
