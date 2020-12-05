import 'dart:convert';
import 'dart:io' as IO;
import 'dart:typed_data';

import 'package:FurniCommerce/library/camera_controller.dart';
import 'package:FurniCommerce/views/venda/NovaVendaDTO.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class VendaServices {
  VendaServices() {}
  String imageB64 = '';

  Widget fromB64(String b64) {
    Uint8List bytes = Base64Decoder().convert(b64);
    return Image.memory(bytes);
  }

  Widget abrirCamera(bool openCamera,Function state) {
    var path;
    var bytes;

    if (imageB64 != '') {
      return Container(width: 300, height: 300, child: fromB64(imageB64));
    }

    if (openCamera) {
      return Column(
        children: <Widget>[
          Container(
            width: 300,
            height: 300,
            child: CameraPreview(CameraContr.cam),
          ),
          RaisedButton(
              onPressed: () async => {
                    path = join(
                      (await getTemporaryDirectory()).path,
                      '${DateTime.now()}.png',
                    ),
                    (await CameraContr.cam.takePicture(path)),
                    bytes = await IO.File(path).readAsBytes(),
                    imageB64 = base64.encode(bytes),
                    state(()=>{})
                  },
              child: Text("tirar foto"))
        ],
      );
    }

    return Container();
  }

  Future<List<NovaVendaDTO>> NovaVendaRequest(int uid, String imagem,
      int movelId, double valor, String observacao) async {
    String url = "https://furnicommerce.herokuapp.com/venda";

    Map<String, String> headers = {"Content-type": "application/json"};

    String json =
        '{"uid": "${uid}", "imagem": "${imagem}","movelId":"${movelId}","valor":"${valor}","observacao":"${observacao}"}';

    Response response = await post(url, headers: headers, body: json);

    List<NovaVendaDTO> novaVendaResponse =
        NovaVendaDTO().parseNovaVenda(response.body);

    return novaVendaResponse;
  }
}
