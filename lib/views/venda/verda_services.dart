import 'package:FurniCommerce/library/camera_controller.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class VendaServices {
  VendaServices() {}

  Widget abrirCamera(bool openCamera){
    var path;

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
              // Store the picture in the temp directory.
              // Find the temp directory using the `path_provider` plugin.
              (await getTemporaryDirectory()).path,
              '${DateTime.now()}.png',
            ),
            (await CameraContr.cam.takePicture(path)),
            print(path)
          }, child: Text("tirar foto"))
        ],
      );
    }

    return Container();
  }
}
