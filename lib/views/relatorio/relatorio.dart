import 'package:FurniCommerce/views/lista/vendaDTO.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Relatorio extends StatelessWidget{
  List<VendaDTO> vendas;

  Relatorio({Key key, this.vendas}) : super(key: key);
    
  @override
  Widget build(BuildContext context) {
    return RelatorioView(vendas:vendas);
  }

}
class RelatorioView extends StatefulWidget{

  RelatorioView({Key key, this.vendas}) : super(key: key);
  List<VendaDTO> vendas;


  @override
  _RelatorioView createState () => _RelatorioView();
}
class _RelatorioView extends State<RelatorioView>{
  List<charts.Series> seriesList;

    String Mes(String data) {
      String mes = data.substring(5, 7);
      return mes;
    }
    String Ano(String data) {
      String ano = data.substring(0, 4);
      return ano;
    }
    Map<String,String> DeParaData = {
      '1':'Jan',
      '2':'Fev',
      '3':'Mar',
      '4':'Abr',
      '5':'Mai',
      '6':'Jun',
      '7':'Jul',
      '8':'Ago',
      '9':'Set',
      '10':'Out',
      '11':'Nov',
      '12':'Dez'
    };

  @override
  Widget build(BuildContext context) {

    Map<String,int> vendas = new Map<String,int>();

    for (var venda in widget.vendas) {
      if(vendas.containsKey(Ano(venda.data_venda))){
        vendas[Ano(venda.data_venda)] = vendas[Ano(venda.data_venda)] + 1;
      }else{
        vendas[Ano(venda.data_venda)] = 0;
      }
    }
    List<VendaAno> vendasAno =[];

    vendas.forEach((key, value) { 

      vendasAno.add(VendaAno(value,key,charts.ColorUtil.fromDartColor(Colors.green),''));

    });

    vendas = new Map<String,int>();

    for (var venda in widget.vendas) {
      if(vendas.containsKey(Mes(venda.data_venda))){
        vendas[Mes(venda.data_venda)] = vendas[Mes(venda.data_venda)] + 1;
      }else{
        vendas[Mes(venda.data_venda)] = 0;
      }
    }
    List<VendaAno> vendasMes =[];
    
    vendas.forEach((key, value) { 

      vendasMes.add(VendaAno(value,'',charts.ColorUtil.fromDartColor(Colors.purple),DeParaData[key]));

    });
    
    List<charts.Series<VendaAno,String>> series=[
      charts.Series(
        id:"Vendas",
        data: vendasAno,
        domainFn: (VendaAno series,_) => series.ano,
        measureFn: (VendaAno series,_)=>series.vendas,
        colorFn: (VendaAno series,_)=> series.barColor,
        
      )
    ];

    List<charts.Series<VendaAno,String>> seriesMes=[
      charts.Series(
        id:"Vendas2",
        data: vendasMes,
        domainFn: (VendaAno seriesMes,_) => seriesMes.mes,
        measureFn: (VendaAno seriesMes,_)=>seriesMes.vendas,
        colorFn: (VendaAno seriesMes,_)=> seriesMes.barColor,
        labelAccessorFn: (VendaAno seriesMes,_)=> '${seriesMes.mes} : ${seriesMes.vendas}'
      )
    ];
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(child:Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
              Center(child: Text('Vendas por Ano',style: TextStyle(fontSize: 30),)),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.5,
                child: charts.BarChart(series,animate: true,),
              ),
              Center(child: Text('Vendas por Mês',style: TextStyle(fontSize: 30))),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.5,
                child: charts.PieChart(seriesMes,animate: true,),
              ),              
          ],
        )),
      ),
    );
  }

}
class VendaAno{

  final int vendas;
  final String ano;
  final String mes;
  final charts.Color barColor;

  VendaAno(this.vendas, this.ano, this.barColor, this.mes);
}