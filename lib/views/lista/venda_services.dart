import 'package:FurniCommerce/views/lista/vendaDTO.dart';
import 'package:http/http.dart';

class VendaServices{

    Future <List<VendaDTO>> ObterVendas() async{
    
      String url = "https://furnicommerce.herokuapp.com/vendas";

      Map<String, String> headers = {"Content-type": "application/json"};

      Response response = await get(url,headers:headers);

      List<VendaDTO> vendasResponse = VendaDTO().parseVenda(response.body);
      
      return vendasResponse;
    }

    Future <List<VendaDTO>> obterVendaPorId(int id) async{
      String url = "https://furnicommerce.herokuapp.com/vendaId";

      Map<String, String> headers = {"Content-type": "application/json"};

      String json = '{"venda_id":"${id}"}';

      Response response = await post(url,headers:headers,body:json);

      List<VendaDTO> vendasResponse = VendaDTO().parseVenda(response.body);
      
      return vendasResponse;

    }
    Future <List<VendaDTO>> comprarMovel(int id,int uid) async{

      String url = "https://furnicommerce.herokuapp.com/comprarMovel";

      Map<String, String> headers = {"Content-type": "application/json"};

      String json = '{"venda_id":"${id}" , "uid":"${uid}"}';

      Response response = await post(url,headers:headers,body:json);

      List<VendaDTO> vendasResponse = VendaDTO().parseVenda(response.body);
      
      return vendasResponse;

    }
    Future <List<VendaDTO>> comprasDoUsuario(int uid) async{

      String url = "https://furnicommerce.herokuapp.com/vendaUsuario";

      Map<String, String> headers = {"Content-type": "application/json"};

      String json = '{"uid":"${uid}"}';

      Response response = await post(url,headers:headers,body:json);

      List<VendaDTO> vendasResponse = VendaDTO().parseVenda(response.body);
      
      return vendasResponse;

    }
    Future <List<VendaDTO>> entregar(int vendaId) async{

      String url = "https://furnicommerce.herokuapp.com/entregar";

      Map<String, String> headers = {"Content-type": "application/json"};

      String json = '{"venda_id":"${vendaId}"}';

      Response response = await post(url,headers:headers,body:json);

      List<VendaDTO> vendasResponse = VendaDTO().parseVenda(response.body);
      
      return vendasResponse;

    }
}