import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:FurniCommerce/views/lista/vendaDTO.dart';
import 'package:FurniCommerce/views/lista/venda_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'lista.dart';

class ItensLista {
  List<Widget> Vendas(List<VendaDTO> vendas, int uid, ListaViewUser lista,
      int perfil, bool ehPerfil) {
    List<ElementoLista> elementos = List<ElementoLista>();

    for (var venda in vendas) {
      elementos.add(ElementoLista(
          observacao: venda.observacao,
          ehPerfil: ehPerfil,
          perfil: perfil,
          lista: lista,
          uid: uid,
          id: venda.venda_id,
          tipo: DeParaTipo(venda.status_venda),
          movel: DeParaMovel(venda.movel),
          data: FormatedData(venda.data_venda)));
    }
    return elementos;
  }

  Tipo DeParaTipo(int tipo) {
    if (tipo == 1) {
      return Tipo.Disponivel;
    }
    if (tipo == 2) {
      return Tipo.Comprado;
    }
    if (tipo == 3) {
      return Tipo.Entregue;
    }

    return null;
  }

  String DeParaMovel(int movel) {
    if (movel == 1) {
      return 'Cama';
    }
    if (movel == 2) {
      return 'Sofá';
    }
    if (movel == 3) {
      return 'Poltrona';
    }
    if (movel == 4) {
      return 'Armário';
    }
    if (movel == 5) {
      return 'Mesa';
    }
    if (movel == 6) {
      return 'Cadeira';
    }
    if (movel == 7) {
      return 'Estante';
    }

    return null;
  }

  String FormatedData(String data) {
    String ano = data.substring(0, 4);
    String mes = data.substring(5, 7);
    String dia = data.substring(8, 10);

    return '${dia}/${mes}/${ano}';
  }
}

class ElementoLista extends StatefulWidget {
  ElementoLista(
      {Key key,
      this.tipo,
      this.data,
      this.movel,
      this.id,
      this.uid,
      this.perfil,
      this.ehPerfil,
      this.observacao,
      this.lista})
      : super(key: key);

  VendaServices services = VendaServices();
  Tipo tipo;
  final String data;
  final String movel;
  final int id;
  final int uid;
  final ListaViewUser lista;
  final int perfil;
  final bool ehPerfil;
  final String observacao;

  @override
  _ElementoLista createState() => _ElementoLista();
}

class _ElementoLista extends State<ElementoLista> {
  String DeParaMovel(int movel) {
    if (movel == 1) {
      return 'Cama';
    }
    if (movel == 2) {
      return 'Sofá';
    }
    if (movel == 3) {
      return 'Poltrona';
    }
    if (movel == 4) {
      return 'Armário';
    }
    if (movel == 5) {
      return 'Mesa';
    }
    if (movel == 6) {
      return 'Cadeira';
    }
    if (movel == 7) {
      return 'Estante';
    }

    return null;
  }

  Image fromBase64Image(String imageB64) {
    Uint8List bytes = Base64Decoder().convert(imageB64);
    return Image.memory(bytes);
  }

  Widget podeComprar(int status, int idVenda, int uid, BuildContext context,
      BuildContext modelContext) {
    BuildContext dialogContx = null;
    List<VendaDTO> venda;

    if (widget.ehPerfil) {
      return Container();
    }

    if (status == 1) {
      return RaisedButton(
          onPressed: () async => {
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
                            child: Center(child: Text('Comprando móvel...')),
                          ),
                        );
                      });
                    }),
                venda = await widget.services.comprarMovel(idVenda, uid),
                Navigator.pop(dialogContx),
                widget.tipo = Tipo.Comprado,
                setState(() => {}),
                Navigator.pop(modelContext)
              },
          elevation: 3.5,
          color: Colors.green,
          child: Container(
            child: Text("Comprar"),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0)));
    }
    if (widget.perfil == 1 && status == 2) {
      return Padding(
          padding: EdgeInsets.only(top: 10),
          child: Container(
              child: RaisedButton(
                  child: Text("Alterar Status"),
                  onPressed: () async {
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          dialogContx = context;
                          return StatefulBuilder(builder: (context, setState) {
                            dialogContx = context;
                            return AlertDialog(
                              content: Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                height: 30,
                                child:
                                    Center(child: CircularProgressIndicator()),
                              ),
                            );
                          });
                        });
                    await widget.services.entregar(idVenda);
                    Navigator.pop(dialogContx);
                    widget.tipo = Tipo.Entregue;
                    setState(() => {});
                    Navigator.pop(modelContext);
                  })));
    }
    if ((widget.perfil == 1 && status == 3) || widget.ehPerfil) {
      return Container();
    }

    return Padding(
        padding: EdgeInsets.only(top: 10),
        child: Container(child: Text("Produto não disponível")));
  }

  @override
  Widget build(BuildContext context) {
    BuildContext dialogContx;
    return Material(
      child: InkWell(
          onTap: () async {
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  dialogContx = context;
                  return StatefulBuilder(builder: (context, setState) {
                    dialogContx = context;
                    return AlertDialog(
                      content: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 30,
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    );
                  });
                });
            List<VendaDTO> venda =
                await widget.services.obterVendaPorId(widget.id);
            Navigator.pop(dialogContx);
            BuildContext modelContext;
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return StatefulBuilder(builder: (context, setState) {
                    modelContext = context;
                    return AlertDialog(
                      content: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.width,

                            child: Column(
                          children: [
                            Text("Preço R\$: ${venda[0].valor}",style: TextStyle(fontSize: 20),),
                            Padding(padding: EdgeInsets.only(top:10)),
                            Text("Vendedor: ${venda[0].usuario_vendedor}"),
                            Padding(padding: EdgeInsets.only(top:10)),
                            Text("Movel: ${DeParaMovel(venda[0].movel)}"),
                            Padding(padding: EdgeInsets.only(top:10)),
                            Text("Observação: ${venda[0].observacao}"),
                            Padding(padding: EdgeInsets.only(top:10)),
                            Container(
                              width: 300,
                              height: 200,
                              child: fromBase64Image(venda[0].imagem),
                            ),
                            Padding(padding: EdgeInsets.only(top:10)),
                            podeComprar(venda[0].status_venda, widget.id,
                                widget.uid, context, modelContext)
                          ],
                        ),
                      ),
                    );
                  });
                });
          },
          child: Container(
              height: 75,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(240, 240, 240, 0),
                  border: Border.all(width: 0.2, color: Colors.black),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[350],
                      blurRadius: 2.0, // soften the shadow
                      spreadRadius: 1.0, //extend the shadow
                      offset: Offset(
                        0.0, // Move to right 10  horizontally
                        0.0, // Move to bottom 10 Vertically
                      ),
                    )
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 10, left: 10),
                    child: Container(
                        width: 90,
                        child: Center(child: Text("${widget.movel}",style: TextStyle(
                          color: Colors.indigo[900]
                        ),))),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, left: 0),
                    child: Container(
                        width: 90,
                        child: Center(child: Text("${widget.data}",style: TextStyle(
                          color: Colors.indigo[900]
                        )))),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, right: 10),
                    child: Situacao(tipo: widget.tipo),
                  ),
                ],
              ))),
    );
  }
}

class Situacao extends StatefulWidget {
  const Situacao({Key key, this.tipo}) : super(key: key);
  final Tipo tipo;

  @override
  _Situacao createState() => _Situacao();
}

class _Situacao extends State<Situacao> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 85,
      height: 30,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(30), color: cor()),
      child: Center(child: texto()),
    );
  }

  Color cor() {
    if (widget.tipo == Tipo.Disponivel) {
      return Colors.green;
    }
    if (widget.tipo == Tipo.Comprado) {
      return Colors.brown;
    }
    if (widget.tipo == Tipo.Entregue) {
      return Colors.blue;
    }

    return Colors.transparent;
  }

  Text texto() {
    if (widget.tipo == Tipo.Disponivel) {
      return Text("Disponível", style: TextStyle(color: Colors.white));
    }
    if (widget.tipo == Tipo.Comprado) {
      return Text("Comprado", style: TextStyle(color: Colors.white));
    }
    if (widget.tipo == Tipo.Entregue) {
      return Text("Entregue", style: TextStyle(color: Colors.white));
    }
    return Text("");
  }
}

enum Tipo { Disponivel, Comprado, Entregue }
