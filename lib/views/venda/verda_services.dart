import 'package:FurniCommerce/library/camera_controller.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class VendaServices{

  VendaServices(){

  }

  Widget abrirCamera (bool openCamera)  {
    
    if(openCamera){
      return Container(
        width: 300,
        height: 300,
        child:CameraPreview(CameraContr.cam) ,
      );
    }

    return Container();
  }  
}