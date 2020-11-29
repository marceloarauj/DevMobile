import 'package:FurniCommerce/views/lista/vendaDTO.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItensLista {
  List<Widget> Vendas(List<VendaDTO> vendas) {
    List<ElementoLista> elementos = List<ElementoLista>();

    for (var venda in vendas) {

      elementos.add(ElementoLista(Tipo: DeParaTipo(venda.status_venda),
                                  movel: DeParaMovel(venda.movel),
                                  data:FormatedData(venda.data_venda)));
    }
    return elementos;
  }

  Tipo DeParaTipo(int tipo) {
    if (tipo == 1) {return Tipo.Disponivel;}
    if (tipo == 2) {return Tipo.Comprado;}
    if (tipo == 3) {return Tipo.Entregue;}
    
    return null;
  }
  String DeParaMovel(int movel){
    if(movel == 1){return 'Cama';}
    if(movel == 2){return 'Sofá';}
    if(movel == 3){return 'Poltrona';}
    if(movel == 4){return 'Armário';}
    if(movel == 5){return 'Mesa';}
    if(movel == 6){return 'Cadeira';}
    if(movel == 7){return 'Estante';}

    return null;
  }
  String FormatedData(String data){
    String ano = data.substring(0,4);
    String mes = data.substring(5,7);
    String dia = data.substring(8,10);

    return '${dia}/${mes}/${ano}';
  }
}

class ElementoLista extends StatelessWidget {
  final Tipo;
  final String data;
  final String movel;

  const ElementoLista({Key key, this.Tipo, this.data, this.movel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
          height: 75,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Color.fromRGBO(240, 240, 240, 0),
              border: Border.all(width: 0.2, color: Colors.grey)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 10, left: 10),
                child: Text("${movel}"),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, left: 0),
                child: Text("${data}"),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, right: 10),
                child: Situacao(tipo: Tipo),
              ),
            ],
          )),
    );
  }
}

class Situacao extends StatelessWidget {
  const Situacao({Key key, this.tipo}) : super(key: key);
  final Tipo tipo;

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
    if (tipo == Tipo.Disponivel) {
      return Colors.green;
    }
    if (tipo == Tipo.Comprado) {
      return Colors.brown;
    }
    if (tipo == Tipo.Entregue) {
      return Colors.blue;
    }

    return Colors.transparent;
  }

  Text texto() {
    if (tipo == Tipo.Disponivel) {
      return Text("Disponível", style: TextStyle(color: Colors.white));
    }
    if (tipo == Tipo.Comprado) {
      return Text("Comprado", style: TextStyle(color: Colors.white));
    }
    if (tipo == Tipo.Entregue) {
      return Text("Entregue", style: TextStyle(color: Colors.white));
    }
    return Text("");
  }
}

enum Tipo { Disponivel, Comprado, Entregue }
