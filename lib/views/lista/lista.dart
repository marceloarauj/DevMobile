import 'package:FurniCommerce/views/lista/vendaDTO.dart';
import 'package:FurniCommerce/views/lista/venda_services.dart';
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
      home: ListaView(nome: nome,uid:uid),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.brown),
    );
  }

  Lista({Key key, this.nome,this.uid}) : super(key: key);

  int uid;
  String nome;
}

class ListaView extends StatefulWidget {
  ListaView({Key key, this.nome = "teste",this.uid}) : super(key: key);
  String nome;
  int uid;

  @override
  ListaViewUser createState() => ListaViewUser();
}

class ListaViewUser extends State<ListaView> {
  ItensLista itens = ItensLista();
  Future<List<VendaDTO>> vendas = VendaServices().ObterVendas();
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bem vindo, ${widget.nome} !"),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            InkWell(child: Container(
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
            )),
            InkWell(child:Container(
              child: ListTile(
                leading: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Venda(uid: widget.uid)),
                ),
                title: Text(
                  'Venda',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              decoration: BoxDecoration(color: Colors.brown),
            )),
            InkWell(child:Container(
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
            )),
            InkWell(child:Container(
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
            )),
            InkWell(child:Container(
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
            ))
          ],
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: FutureBuilder(future: vendas,builder: (context,snapshot){
            if(!snapshot.hasData){
              return Container(height:500,child:Center(child: CircularProgressIndicator()));
            }else{
              return Column(children: itens.Vendas(snapshot.data,widget.uid,this));
            }
          })),
        ),
    );
  }
}
