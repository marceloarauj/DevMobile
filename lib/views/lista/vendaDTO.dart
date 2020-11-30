import 'dart:convert';

class VendaDTO{

  VendaDTO({this.valor, this.usuario_vendedor, this.observacao, this.imagem, this.venda_id, this.movel, this.status_venda, this.data_venda});
  
  final int movel;
  final int status_venda;
  final String data_venda;
  final int venda_id;
  final double valor;
  final String usuario_vendedor;
  final String observacao;
  final String imagem;

  factory VendaDTO.fromJson(Map<String,dynamic> json){

    return VendaDTO(
      movel:json['movel'],
      status_venda:json['status_venda'],
      data_venda:json['data_venda'],
      venda_id: json['venda_id'],
      valor:double.parse(json['valor']),
      usuario_vendedor: json['usuario'],
      observacao: json['observacao'],
      imagem: json['imagem']
    );

  }
  List<VendaDTO> parseVenda(String responseBody){
    final data = jsonDecode(responseBody);

    return data.map<VendaDTO>((json) => VendaDTO.fromJson(json)).toList(); 
  }
}