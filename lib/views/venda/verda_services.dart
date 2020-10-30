import 'dart:convert';
import 'dart:io' as IO;

import 'package:FurniCommerce/library/camera_controller.dart';
import 'package:FurniCommerce/library/image_services.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class VendaServices {
  VendaServices() {}
  String imageB64= '';

  Widget abrirCamera(bool openCamera){
    var path;
    var bytes;

    if (openCamera) {
      return Column(
        children: <Widget>[
          Container(
            width: 300,
            height: 300,
            child: CameraPreview(CameraContr.cam),
          ),
          RaisedButton(onPressed: () async => {
            path = join(
              (await getTemporaryDirectory()).path,
              '${DateTime.now()}.png',
            ),
            (await CameraContr.cam.takePicture(path)),
            bytes = await IO.File(path).readAsBytes(),
            imageB64 = base64.encode(bytes),
            print(imageB64)
          }, child: Text("tirar foto"))
        ],
      );
    }

    return Container();
  }
}
