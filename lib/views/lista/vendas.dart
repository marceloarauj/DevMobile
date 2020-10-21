import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItensLista {
  List<Widget> Vendas() {
    return <Widget>[
      ElementoLista(Tipo:Tipo.EmAndamento),
      ElementoLista(Tipo:Tipo.Entregue),
      ElementoLista(Tipo:Tipo.Disponivel),
      ElementoLista(Tipo:Tipo.EmColeta),
      ElementoLista(Tipo:Tipo.EmAndamento),
      ElementoLista(Tipo:Tipo.Disponivel),
      ElementoLista(Tipo:Tipo.EmAndamento),
      ElementoLista(Tipo:Tipo.Disponivel),
      ElementoLista(Tipo:Tipo.EmAndamento),
      ElementoLista(Tipo:Tipo.EmAndamento),
      ElementoLista(Tipo:Tipo.Entregue),
      ElementoLista(Tipo:Tipo.EmAndamento),
      ElementoLista(Tipo:Tipo.EmAndamento)
    ];
  }
}

class ElementoLista extends StatelessWidget {
  
  final Tipo;

  const ElementoLista({Key key, this.Tipo}) : super(key: key);

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
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 10,left: 10),
                child: Text("ABCDEF123"),
              ),
              Padding(padding: EdgeInsets.only(top: 10,left: 60),
                child: Text("Data"),
              ),
              Padding(padding: EdgeInsets.only(top: 10,left: 120),
                child: Situacao(tipo:Tipo),
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
      width: 70,
      height:30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: cor()
      ),
    );
  }

  Color cor(){
    if(tipo == Tipo.Disponivel){
      return Colors.green;
    }
    if(tipo == Tipo.EmAndamento){
      return Colors.yellow;
    }
    if(tipo == Tipo.Entregue){
      return Colors.blue;
    }
    if(tipo == Tipo.EmColeta){
      return Colors.brown;
    }
    return Colors.transparent;
  }
}

enum Tipo { EmColeta,Disponivel, EmAndamento, Entregue }
