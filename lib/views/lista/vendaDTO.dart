import 'dart:convert';

class VendaDTO{

  VendaDTO({this.movel, this.status_venda, this.data_venda});
  
  final int movel;
  final int status_venda;
  final String data_venda;

  factory VendaDTO.fromJson(Map<String,dynamic> json){

    return VendaDTO(
      movel:json['movel'],
      status_venda:json['status_venda'],
      data_venda:json['data_venda']
    );

  }
  List<VendaDTO> parseVenda(String responseBody){
    final data = jsonDecode(responseBody);

    return data.map<VendaDTO>((json) => VendaDTO.fromJson(json)).toList(); 
  }
}