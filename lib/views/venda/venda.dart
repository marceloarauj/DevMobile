import 'package:flutter/material.dart';

class Venda extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NovaVenda(),
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
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            decoration: BoxDecoration(            
              borderRadius: BorderRadius.circular(10.0),
              color:Colors.grey,
              border: Border.all()
            ),
            child: DropdownButtonHideUnderline(child: DropdownButton(
            
            items: _moveis(),
            value: movel,
            icon: Icon(Icons.widgets),
            onChanged: (valor) {
              setState(() {
                movel = valor;
              });
            },
          ),)
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
        child: Text("estante"),
        value: 7,
      ),
    ];
  }
}
