import 'package:FurniCommerce/views/venda/novavenda_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

import 'NovaVendaDTO.dart';

class Venda extends StatelessWidget {
  const Venda({Key key, this.uid}) : super(key: key);
  final int uid;

  @override
  Widget build(BuildContext context) {

    return NovaVenda(uid:uid);
  }
}

class NovaVenda extends StatefulWidget {
  const NovaVenda({Key key, this.uid}) : super(key: key);
  final int uid;

  @override
  _NovaVenda createState() => _NovaVenda();
}

class _NovaVenda extends State<NovaVenda> {
  int movel = 0;
  bool podeCadastrar = false;
  bool podeAbrirCamera = false;
  VendaServices novaVendaServices = VendaServices();
  TextEditingController valor = TextEditingController();
  TextEditingController observacao = TextEditingController();
  final moneyMask = MoneyMaskedTextController(thousandSeparator: '',decimalSeparator: '.');

  @override
  Widget build(BuildContext context) {
    BuildContext mainContext = context;
    return WillPopScope(
      onWillPop: ()async{
        await Navigator.pop(context);
      },
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("Cadastro de venda"),
          ),
          backgroundColor: Colors.grey[300],
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: Container(
                        width: 300,
                          padding:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.grey,
                              border: Border.all()),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              items: _moveis(),
                              value: movel,
                              icon: Icon(Icons.widgets),
                              onChanged: (valor) {
                                setState(() {
                                  movel = valor;
                                });
                              },
                            ),
                          ))),
                  Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Container(
                      width: 300,
                      child: TextFormField(
                        controller: moneyMask,
                        maxLength: 8,
                        keyboardType:
                            TextInputType.numberWithOptions(signed: false),
                        decoration: InputDecoration(
                            labelText: 'Valor do móvel',
                            counterText: "",
                            prefixIcon: Icon(Icons.attach_money)),
                      ),
                    ),
                  ),
                  Container(
                    width: 300,
                    decoration:
                        BoxDecoration(color: Color.fromRGBO(200, 200, 200, 0)),
                    child: TextFormField(
                      maxLength: 10,
                      controller: observacao,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.remove_red_eye),
                        labelText: 'Observação',
                        counterText: ""
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Container(
                      width: 300,
                      child: Row(
                        children: <Widget>[
                          Text('Tire uma foto do móvel'),
                          Padding(
                              padding: EdgeInsets.only(left: 40),
                              child: Container(
                                decoration: BoxDecoration(color:Colors.grey[400],shape: BoxShape.circle),
                                child: IconButton(
                                  color: Colors.black,                                  
                                  icon: Icon(Icons.camera_alt),
                                  onPressed: () =>
                                      setState(() => {novaVendaServices.imageB64 ='' ,podeAbrirCamera = true})),
                              ))
                        ],
                      ),
                    ),
                  ),
                  novaVendaServices.abrirCamera(podeAbrirCamera,setState),
                  
                  Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: Container(
                        child: RaisedButton(
                          color: Colors.green[300],
                          child: Text('Cadastrar Venda'),
                          onPressed: () => {
                            podeInserirVenda(
                                context, widget.uid, novaVendaServices.imageB64, movel,context),
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                        ),
                      ))
                ],
              ),
            ),
          )),
    );
  }

  podeInserirVenda(BuildContext context, int uid, String imageB64, int movel,BuildContext mainContext) async {
    if (imageB64 == '') {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return StatefulBuilder(builder: (context, setState) {
              return AlertDialog(
                content: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 30,
                  child: Center(child: Text('A imagem é obrigatória')),
                ),
              );
            });
          });
          return null;
    }
    if (movel == 0 || moneyMask.text == '') {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return StatefulBuilder(builder: (context, setState) {
              return AlertDialog(
                content: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 30,
                  child: Center(child: Text('Móvel e valor são obrigatórios')),
                ),
              );
            });
          });
      return null;
    }
    await Navigator.pop(mainContext);
    Future<List<NovaVendaDTO>> novaVenda =
        novaVendaServices.NovaVendaRequest(widget.uid, novaVendaServices.imageB64, movel,double.parse(moneyMask.text),observacao.text);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 30,
                child: Center(child: FutureBuilder(future: novaVenda,builder: (context,snapshot){
            if(!snapshot.hasData){
              return Container(height:500,child:Center(child: CircularProgressIndicator()));
            }else{
              return Container(child:Text("Venda cadastrada !"));
            }
          })),
              ),
            );
          });
        });
  }

  List<DropdownMenuItem> _moveis() {
    return [
      DropdownMenuItem(
        child: Text("Selecione um móvel"),
        value: 0,
      ),
      DropdownMenuItem(
        child: Text("Cama"),
        value: 1,
      ),
      DropdownMenuItem(
        child: Text("Sofá"),
        value: 2,
      ),
      DropdownMenuItem(
        child: Text("Poltrona"),
        value: 3,
      ),
      DropdownMenuItem(
        child: Text("Armário"),
        value: 4,
      ),
      DropdownMenuItem(
        child: Text("Mesa"),
        value: 5,
      ),
      DropdownMenuItem(
        child: Text("Cadeira"),
        value: 6,
      ),
      DropdownMenuItem(
        child: Text("Estante"),
        value: 7,
      ),
    ];
  }
}
