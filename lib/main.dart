import 'package:FurniCommerce/library/camera_controller.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'views/login/login.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  
  final cameras = await availableCameras();

  final firstCamera = cameras.first;

  runApp(MyApp(
    camera:firstCamera
  ));
}

class MyApp extends StatelessWidget {  

  const MyApp({Key key, this.camera}) : super(key: key);

  final CameraDescription camera;

  @override
  Widget build(BuildContext context) {

    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: MyHomePage(cameraContr: camera,),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.cameraContr}) : super(key: key);
  
  final CameraDescription cameraContr;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.cameraContr,
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    CameraContr.cam = _controller;
    return Login();
  }
}
