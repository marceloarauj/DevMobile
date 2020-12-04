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
    return ListaView(nome: nome, perfil: perfil, uid: uid);
  }

  Lista({Key key, this.nome, this.uid, this.perfil}) : super(key: key);

  int uid;
  int perfil;
  String nome;
}

class ListaView extends StatefulWidget {
  ListaView({Key key, this.perfil, this.nome = "teste", this.uid})
      : super(key: key);
  String nome;
  int uid;
  int perfil;

  @override
  ListaViewUser createState() => ListaViewUser();
}

class ListaViewUser extends State<ListaView> {
  ItensLista itens = ItensLista();
  Future<List<VendaDTO>> vendas = VendaServices().ObterVendas();

  bool disponivel = true;
  void disponivelCheck(bool value) => setState(() => disponivel = value);

  bool comprado = true;
  void compradoCheck(bool value) => setState(() => comprado = value);

  bool entregue = true;
  void entregueCheck(bool value) => setState(() => entregue = value);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bem vindo, ${widget.nome} !"),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            InkWell(
                child: Container(
              child: ListTile(
                leading: Icon(
                  Icons.border_all,
                  color: Colors.white,
                ),
                onTap: () => Navigator.pop(context),
                title: Text(
                  'Inicio',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              decoration: BoxDecoration(color: Colors.brown),
            )),
            InkWell(
                child: Container(
              child: ListTile(
                leading: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onTap: () => {
                  Navigator.pop(context),
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Venda(uid: widget.uid)),
                  ),
                },
                title: Text(
                  'Venda',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              decoration: BoxDecoration(color: Colors.brown),
            )),
            InkWell(
                child: Container(
              child: ListTile(
                leading: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                onTap: () => {
                  Navigator.pop(context),
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Perfil(
                            nome: widget.nome,
                            avaliacao: '4.5',
                            uid: widget.uid,
                            perfil: widget.perfil)),
                  )
                },
                title: Text(
                  'Perfil',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              decoration: BoxDecoration(color: Colors.brown),
            )),
            InkWell(
                child: Container(
              child: ListTile(
                leading: Icon(
                  Icons.data_usage,
                  color: Colors.white,
                ),
                onTap: () => {
                  Navigator.pop(context),
                  vendas.then((values) => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Relatorio(vendas: values)),
                        )
                      })
                },
                title: Text(
                  'Relatórios',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              decoration: BoxDecoration(color: Colors.brown),
            )),
            InkWell(
                child: Container(
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
            child: FutureBuilder(
                future: vendas,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Container(
                        height: 500,
                        child: Center(child: CircularProgressIndicator()));
                  } else {
                    return Column(
                        children: itens.Vendas(snapshot.data, widget.uid, this,
                            widget.perfil, false));
                  }
                })),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        backgroundColor: Colors.black,
        onPressed: () => {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return StatefulBuilder(builder: (context, setState) {
                  return AlertDialog(
                    content: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.width * 0.85,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: disponivel,
                                  activeColor: Colors.black,
                                  onChanged: disponivelCheck,
                                  checkColor: Colors.green,
                                ),
                                Text('Disponível')
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: comprado,
                                  activeColor: Colors.black,
                                  onChanged: compradoCheck,
                                  checkColor: Colors.green,
                                ),
                                Text('Comprado')
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: entregue,
                                  activeColor: Colors.black,
                                  onChanged: entregueCheck,
                                  checkColor: Colors.green,
                                ),
                                Text('Entregue')
                              ],
                            )
                          ],
                        )),
                  );
                });
              })
        },
      ),
    );
  }
}
