
import 'dart:convert';
import 'dart:io' as IO;
import 'dart:io';

import 'package:flutter/material.dart';

class ImageService{

  File convertBase64ToImage(String image,String path){
    final decodedBytes = base64Decode(image);

    var file = IO.File(path);
    file.writeAsBytesSync(decodedBytes);

    return file;
  }

  // String convertImageToBase64(ImageProvider imgProvider){

  // }
}