import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Lista extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: ListaView(),
      debugShowCheckedModeBanner: false,
    );
  }
  
}

class ListaView extends StatefulWidget{

  @override
  _ListaView createState() => _ListaView();
}

class _ListaView extends State<ListaView>{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text('AAAAA'),
            Text('BBBB')
          ],
        ),
      ),
    );
  }

}

class Venda extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

}