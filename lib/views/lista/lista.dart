import 'package:FurniCommerce/views/lista/vendas.dart';
import 'package:FurniCommerce/views/perfil/perfil.dart';
import 'package:FurniCommerce/views/relatorio/relatorio.dart';
import 'package:FurniCommerce/views/venda/venda.dart';
import 'package:flutter/material.dart';
import 'dart:io';
class Lista extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ListaView(nome: nome),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.brown),
    );
  }

  Lista({Key key, this.nome}) : super(key: key);

  String nome;
}

class ListaView extends StatefulWidget {
  ListaView({Key key, this.nome = "teste"}) : super(key: key);
  String nome;

  @override
  _ListaView createState() => _ListaView();
}

class _ListaView extends State<ListaView> {
  ItensLista itens = ItensLista();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bem vindo, ${widget.nome} !"),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            Container(
              child: ListTile(
                leading: Icon(
                  Icons.border_all,
                  color: Colors.white,
                ),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Venda()),
                ),
                title: Text(
                  'Inicio',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              decoration: BoxDecoration(color: Colors.brown),
            ),
            Container(
              child: ListTile(
                leading: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Venda()),
                ),
                title: Text(
                  'Venda',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              decoration: BoxDecoration(color: Colors.brown),
            ),
            Container(
              child: ListTile(
                leading: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Perfil(nome: 'Teste',avaliacao: '4.5',)),
                ),
                title: Text(
                  'Perfil',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              decoration: BoxDecoration(color: Colors.brown),
            ),
            Container(
              child: ListTile(
                leading: Icon(
                  Icons.data_usage,
                  color: Colors.white,
                ),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Relatorio()),
                ),
                title: Text(
                  'Relatórios',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              decoration: BoxDecoration(color: Colors.brown),
            ),
            Container(
              child: ListTile(
                leading: Icon(
                  Icons.exit_to_app,
                  color: Colors.white,
                ),
                onTap: () => exit(0),
                title: Text(
                  'Sair',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              decoration: BoxDecoration(color: Colors.brown),
            )
          ],
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(children: itens.Vendas()),
        ),
      ),
    );
  }
}
