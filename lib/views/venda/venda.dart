import 'package:flutter/material.dart';

class Venda extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NovaVenda(),
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class NovaVenda extends StatefulWidget {
  @override
  _NovaVenda createState() => _NovaVenda();
}

class _NovaVenda extends State<NovaVenda> {
  int movel = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cadastro de venda"),),
      body: Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(top: 30),
              child: Container(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
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
          Container(
            width: 300,
            child: TextFormField(
              maxLength: 6,
              keyboardType: TextInputType.numberWithOptions(signed: false),
              decoration: InputDecoration(
                  labelText: 'Valor do móvel',
                  prefixIcon: Icon(Icons.attach_money)),
            ),
          ),
          Container(
            width: 300,
            decoration: BoxDecoration(color: Color.fromRGBO(200, 200, 200, 0)),
            child: TextFormField(
              keyboardType: TextInputType.numberWithOptions(signed: false),
              decoration: InputDecoration(
                labelText: 'Observação',
              ),
            ),
          ),
          Container(
            child: RaisedButton(
              child: Text('Cadastrar Venda'),
              onPressed: () => {},
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
            ),
          )
        ],
      ),
    );
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
