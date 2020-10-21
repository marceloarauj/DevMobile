import 'package:FurniCommerce/views/lista/vendas.dart';
import 'package:FurniCommerce/views/venda/venda.dart';
import 'package:flutter/material.dart';

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
                  Icons.add,
                  color: Colors.white,
                ),
                title: Text(
                  'Vendas',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              decoration: BoxDecoration(color: Colors.brown),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Perfil'),
            ),
            ListTile(
              leading: Icon(Icons.build),
              title: Text('Configurações'),
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Sair'),
              onTap:()=>                         Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Venda()),
                        ),
            ),
          ],
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: itens.Vendas()
          ),
        ),
      ),
    );
  }
}
