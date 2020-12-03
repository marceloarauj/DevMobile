import 'package:FurniCommerce/library/login_inputs.dart';
import 'package:FurniCommerce/views/lista/lista.dart';
import 'package:FurniCommerce/views/login/loginDTO.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'login_services.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginView(),
    );
  }
}

class LoginView extends StatefulWidget {
  bool ehLogin = true;

  TextEditingController cpf = TextEditingController();
  TextEditingController endereco = TextEditingController();
  TextEditingController nome = TextEditingController();
  var cpfFormat = MaskTextInputFormatter(mask: '###.###.###-##');

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
              image: AssetImage("assets/bg2.jpg"),
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.1), BlendMode.srcOver),
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
                  length: 50,
                  text: "Email",
                  value: login,
                  password: false,
                ),
                Padding(padding: EdgeInsets.only(top: 20)),
                LoginInput(
                  length: 40,
                  text: "Senha",
                  value: senha,
                  password: true,
                ),
                Padding(padding: EdgeInsets.only(top: 40)),
                Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    height: 50,
                    child: RaisedButton(
                      onPressed: () => {EfetuarLoginRegistro(context)},
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

  void EfetuarLoginRegistro(BuildContext context) async {
    if (this.widget.ehLogin) {
      await loginDialog(context);
    } else {
      await registerDialog(context);
    }
  }

  void registerDialog(BuildContext context) async {
    BuildContext dialogContx = null;

    if (widget.nome.text == '' ||
        widget.endereco.text == '' ||
        senha.text == '' ||
        widget.cpf.text == '' ||
        login.text == '') {

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return StatefulBuilder(builder: (context, setState) {
              return AlertDialog(
                content: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 30,
                  child: Center(child: Text('Existem campos não preenchidos')),
                ),
              );
            });
          });
      return null;
    }

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          dialogContx = context;
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 30,
                child: Center(child: Text('Registrando usuário...')),
              ),
            );
          });
        });
    List<LoginDTO> registro = await services.RegisterRequest(login.text,
        senha.text, widget.endereco.text, widget.cpf.text, widget.nome.text);

    Navigator.pop(dialogContx);

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 30,
                child: Center(child: Text(registro[0].mensagem)),
              ),
            );
          });
        });
  }

  void loginDialog(BuildContext context) async {
    List<LoginDTO> loginSucesso = null;
    String mensagem = 'Efetuando login...';
    BuildContext dialogContx = null;

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            dialogContx = context;
            return AlertDialog(
              content: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 30,
                child: Center(child: Text('${mensagem}')),
              ),
            );
          });
        });
    loginSucesso = await services.LoginRequest(login.text, senha.text);
    Navigator.pop(dialogContx);

    if (loginSucesso[0].usuario_id != null) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Lista(
                  nome: loginSucesso[0].nome,
                  perfil:loginSucesso[0].perfil,
                  uid: loginSucesso[0].usuario_id)));
    } else {
      mensagem = loginSucesso[0].error;
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return StatefulBuilder(builder: (context, setState) {
              dialogContx = context;
              return AlertDialog(
                content: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 30,
                  child: Center(child: Text('${mensagem}')),
                ),
              );
            });
          });
    }
  }

  Widget ehLogin() {
    if (widget.ehLogin) {
      return Container(
        color: Colors.black.withOpacity(0.0),
        width: MediaQuery.of(context).size.width * 0.5,
        child: Image.asset('assets/logo.png'),
      );
    }
    return Container(
      child: Column(
        children: <Widget>[
          Padding(padding: EdgeInsets.only(top: 40)),
          LoginInput(
            length: 50,
            text: "Nome",
            value: widget.nome,
            password: false,
          ),
          Padding(padding: EdgeInsets.only(top: 20)),
          LoginInput(
            mask: [widget.cpfFormat],
            length:14,
            text: "CPF",
            value: widget.cpf,
            password: false,
          ),
          Padding(padding: EdgeInsets.only(top: 20)),
          LoginInput(
            length: 50,
            text: "Endereço",
            value: widget.endereco,
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
