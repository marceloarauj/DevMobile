import 'package:FurniCommerce/views/lista/vendaDTO.dart';
import 'package:FurniCommerce/views/lista/venda_services.dart';
import 'package:FurniCommerce/views/lista/vendas.dart';
import 'package:flutter/material.dart';

class Perfil extends StatelessWidget {
  String nome, avaliacao;
  int uid;

  Perfil({this.nome, this.avaliacao,this.uid});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PerfilPage(nome: this.nome, avaliacao: this.avaliacao,uid:this.uid),
    );
  }
}

class PerfilPage extends StatefulWidget {
  String nome, avaliacao;
  int uid;
  PerfilPage({this.nome, this.avaliacao,this.uid});

  @override
  _PerfilPage createState() => _PerfilPage();
}

class _PerfilPage extends State<PerfilPage> {
  VendaServices services = VendaServices();

  ItensLista itens = ItensLista();

  @override
  Widget build(BuildContext context) {
    Future<List<VendaDTO>> compras = services.obterVendaPorId(widget.uid);

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
                      "Compras",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: Container(
                        height: 540,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              FutureBuilder(future:compras,builder:(context,snapshot){
                                if(!snapshot.hasData){
                                  return Center(child: CircularProgressIndicator());
                                }else{
                                  return SingleChildScrollView(child:Column(children:itens.Vendas(snapshot.data, widget.uid, null)));
                                }
                              })
                            ]
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
