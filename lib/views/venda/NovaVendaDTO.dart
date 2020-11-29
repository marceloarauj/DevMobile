import 'dart:convert';

class NovaVendaDTO{

  NovaVendaDTO({this.message});

  final String message;

  factory NovaVendaDTO.fromJson(Map<String,dynamic> json){

    return NovaVendaDTO(
      message: json['message']
    );
  }
    List<NovaVendaDTO> parseNovaVenda(String responseBody){
    final data = jsonDecode(responseBody);

    return data.map<NovaVendaDTO>((json) => NovaVendaDTO.fromJson(json)).toList(); 
  }
}