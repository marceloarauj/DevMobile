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
  Future<List<VendaDTO>> vendas;
  List<VendaDTO> vendasCarregadas;
  List<VendaDTO> vendasFiltro = null;

  bool disponivel = true;
  void disponivelCheck(bool value) => state(() => disponivel = value);

  bool comprado = true;
  void compradoCheck(bool value) => state(() => comprado = value);

  bool entregue = true;
  void entregueCheck(bool value) => state(() => entregue = value);

  Function state;

  bool cama = true;
  bool sofa = true;
  bool mesa = true;
  bool poltrona = true;
  bool armario = true;
  bool cadeira = true;
  bool estante = true;

  void camaCheck(bool value) => state(() => cama = value);
  void sofaCheck(bool value) => state(() => sofa = value);
  void mesaCheck(bool value) => state(() => mesa = value);
  void poltronaCheck(bool value) => state(() => poltrona = value);
  void armarioCheck(bool value) => state(() => armario = value);
  void cadeiraCheck(bool value) => state(() => cadeira = value);
  void estanteCheck(bool value) => state(() => estante = value);

  List<VendaDTO> filtrar() {
    vendasFiltro = List<VendaDTO>();
    List<VendaDTO> removeList = List<VendaDTO>();

    for (var item in vendasCarregadas) {
      if (cama && item.movel == 1) {
        vendasFiltro.add(item);
      }
      if (sofa && item.movel == 2) {
        vendasFiltro.add(item);
      }
      if (poltrona && item.movel == 3) {
        vendasFiltro.add(item);
      }
      if (armario && item.movel == 4) {
        vendasFiltro.add(item);
      }
      if (mesa && item.movel == 5) {
        vendasFiltro.add(item);
      }
      if (cadeira && item.movel == 6) {
        vendasFiltro.add(item);
      }
      if (estante && item.movel == 7) {
        vendasFiltro.add(item);
      }
    }

    for (var item in vendasFiltro) {
      if (item.status_venda == 1 && !disponivel) {
        removeList.add(item);
      }
      if (item.status_venda == 2 && !comprado) {
        removeList.add(item);
      }
      if (item.status_venda == 3 && !entregue) {
        removeList.add(item);
      }
    }
    for (var item in removeList) {
      vendasFiltro.remove(item);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    vendas = VendaServices().ObterVendas();
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Bem vindo, ${widget.nome} !"),
      ),
      drawer: Drawer(
        elevation: 3,
        child: Container(
          decoration: BoxDecoration(color: Colors.brown[100],border:Border(right: BorderSide(width: 2,color: Colors.black))),
          
          child:ListView(
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
              decoration: BoxDecoration(color: Colors.brown,border: Border(right: BorderSide(width:1,color: Colors.black),bottom: BorderSide(width: 1,color: Colors.black))),
            )),
            InkWell(
                child: Container(
              child: ListTile(
                leading: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onTap: () async=> {
                  Navigator.pop(context),
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Venda(uid: widget.uid)),
                  ),
                  setState(()=>{print('sss')})
                },
                title: Text(
                  'Venda',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              decoration: BoxDecoration(color: Colors.brown,border: Border(right: BorderSide(width:1,color: Colors.black),bottom: BorderSide(width: 1,color: Colors.black))),
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
              decoration: BoxDecoration(color: Colors.brown,border: Border(right: BorderSide(width:1,color: Colors.black),bottom: BorderSide(width: 1,color: Colors.black))),
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
              decoration: BoxDecoration(color: Colors.brown,border: Border(right: BorderSide(width:1,color: Colors.black),bottom: BorderSide(width: 1,color: Colors.black))),
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
              decoration: BoxDecoration(color: Colors.brown,border: Border(right: BorderSide(width:1,color: Colors.black),bottom: BorderSide(width: 1,color: Colors.black))),
            ))
          ],
        )
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
                    vendasCarregadas = snapshot.data;
                    if (vendasFiltro == null) {
                      vendasFiltro = vendasCarregadas;
                    }
                    return Column(
                        children: itens.Vendas(vendasFiltro, widget.uid, this,
                            widget.perfil, false));
                  }
                })),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        mini: true,
        backgroundColor: Colors.black,
        onPressed: () => {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return StatefulBuilder(builder: (context, setState) {
                  state = setState;
                  return AlertDialog(
                    content: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.width * 0.95,
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
                                Situacao(tipo: Tipo.Disponivel)
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
                                Situacao(tipo: Tipo.Comprado)
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
                                Situacao(tipo: Tipo.Entregue)
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 30),
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: cama,
                                  activeColor: Colors.black,
                                  onChanged: camaCheck,
                                  checkColor: Colors.green,
                                ),
                                Text('Cama'),
                                Checkbox(
                                  value: sofa,
                                  activeColor: Colors.black,
                                  onChanged: sofaCheck,
                                  checkColor: Colors.green,
                                ),
                                Text('Sofá'),
                                Checkbox(
                                  value: mesa,
                                  activeColor: Colors.black,
                                  onChanged: mesaCheck,
                                  checkColor: Colors.green,
                                ),
                                Text('Mesa')
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: poltrona,
                                  activeColor: Colors.black,
                                  onChanged: poltronaCheck,
                                  checkColor: Colors.green,
                                ),
                                Text('Poltrona'),
                                Checkbox(
                                  value: armario,
                                  activeColor: Colors.black,
                                  onChanged: armarioCheck,
                                  checkColor: Colors.green,
                                ),
                                Text('Armário'),
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: cadeira,
                                  activeColor: Colors.black,
                                  onChanged: cadeiraCheck,
                                  checkColor: Colors.green,
                                ),
                                Text('Cadeira'),
                                Checkbox(
                                  value: estante,
                                  activeColor: Colors.black,
                                  onChanged: estanteCheck,
                                  checkColor: Colors.green,
                                ),
                                Text('Estante'),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 20),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RaisedButton(
                                    color: Colors.orange,
                                    child: Text(
                                      'Limpar',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () => {
                                          disponivel = false,
                                          comprado = false,
                                          entregue = false,
                                          cama = false,
                                          sofa = false,
                                          mesa = false,
                                          poltrona = false,
                                          armario = false,
                                          cadeira = false,
                                          estante = false,
                                          setState(() => {})
                                        }),
                                Padding(
                                  padding: EdgeInsets.only(left: 8),
                                ),
                                RaisedButton(
                                    color: Colors.green[900],
                                    child: Text(
                                      'Padrão',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () => {
                                          disponivel = true,
                                          comprado = true,
                                          entregue = true,
                                          cama = true,
                                          sofa = true,
                                          mesa = true,
                                          poltrona = true,
                                          armario = true,
                                          cadeira = true,
                                          estante = true,
                                          setState(() => {})
                                        }),
                                Padding(
                                  padding: EdgeInsets.only(left: 8),
                                ),
                                RaisedButton(
                                    color: Colors.black,
                                    child: Text(
                                      'Filtrar',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () =>
                                        {filtrar(), Navigator.pop(context)})
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
