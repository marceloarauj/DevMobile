import 'package:flutter/material.dart';

class Relatorio extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RelatorioView(),
    );
  }

}
class RelatorioView extends StatefulWidget{

  @override
  _RelatorioView createState () => _RelatorioView();
}
class _RelatorioView extends State<RelatorioView>{
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }

}