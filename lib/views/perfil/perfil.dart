import 'package:FurniCommerce/views/lista/vendas.dart';
import 'package:flutter/material.dart';

class Perfil extends StatelessWidget {
  String nome, avaliacao;

  Perfil({this.nome, this.avaliacao});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PerfilPage(nome: this.nome, avaliacao: this.avaliacao),
    );
  }
}

class PerfilPage extends StatefulWidget {
  String nome, avaliacao;
  PerfilPage({this.nome, this.avaliacao});

  @override
  _PerfilPage createState() => _PerfilPage();
}

class _PerfilPage extends State<PerfilPage> {
  ItensLista itens = ItensLista();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 40),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    child: Text('${this.widget.nome}'),
                  ),
                  Container(
                    child: Text('Avaliação: ${this.widget.avaliacao}'),
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Text(
                      "Vendas",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: Container(
                        height: 540,
                        child: SingleChildScrollView(
                          child: Column(
                            children: itens.Vendas(null,null,null),
                          ),
                        ),
                      ))
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}
