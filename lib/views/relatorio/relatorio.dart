import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

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
  List<charts.Series> seriesList;
  List<VendaAno> vendas = [
    VendaAno(25,'2010', charts.ColorUtil.fromDartColor(Colors.blue)),
    VendaAno(50, '2013',charts.ColorUtil.fromDartColor(Colors.red)),
    VendaAno(90, '2015', charts.ColorUtil.fromDartColor(Colors.green)),
    VendaAno(900, '2016', charts.ColorUtil.fromDartColor(Colors.purple)),
    VendaAno(320, '2017', charts.ColorUtil.fromDartColor(Colors.yellow))

  ];

  @override
  Widget build(BuildContext context) {

    List<charts.Series<VendaAno,String>> series=[
      charts.Series(
        id:"Vendas",
        data: vendas,
        domainFn: (VendaAno series,_) => series.ano,
        measureFn: (VendaAno series,_)=>series.vendas,
        colorFn: (VendaAno series,_)=> series.barColor
      )
    ];

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              Expanded(
                child: charts.BarChart(series,animate: true,),
              )
          ],
        ),
      ),
    );
  }

}
class VendaAno{

  final int vendas;
  final String ano;
  final charts.Color barColor;

  VendaAno(this.vendas, this.ano, this.barColor);
}