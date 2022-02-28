import 'dart:io';
import 'package:camera/camera.dart';
import 'package:capstone_concept_proof/image_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

import 'main.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ImagePicker _picker = ImagePicker();
  ImageModel imageModel = ImageModel();

  bool isWorking = false;
  String result = '';
  CameraController? cameraController;
  CameraImage? imgCamera;

  loadModel() async {
    await Tflite.loadModel(
        model: 'assets/mobilenet_v1_1.0_224.tflite',
        labels: 'assets/labels.txt');
  }

  initCamera() {
    cameraController = CameraController(cameras[0], ResolutionPreset.medium);
    cameraController!.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {
        cameraController!.startImageStream((imageFromStream) => {
              if (!isWorking)
                {
                  isWorking = true,
                  imgCamera = imageFromStream,
                  runModelOnStreamFrames(),
                }
            });
      });
    });
  }

  runModelOnStreamFrames() async {
    if (imgCamera != null) {
      var recognitions = await Tflite.runModelOnFrame(
        bytesList: imgCamera!.planes.map((plane) {
          return plane.bytes;
        }).toList(),
        imageHeight: imgCamera!.height,
        imageWidth: imgCamera!.width,
        imageMean: 127.5,
        imageStd: 127.5,
        rotation: 90,
        numResults: 2,
        threshold: 0.1,
        asynch: true,
      );

      result = '';

      recognitions?.forEach((response) {
        result += response['label'] +
            ' ' +
            (response['confidence'] as double).toStringAsFixed(2) +
            '\n\n';
      });

      setState(() {
        result;
      });

      isWorking = false;
    }
  }

  @override
  void initState() {
    super.initState();

    loadModel();
  }

  @override
  dispose() async {
    super.dispose();

    await Tflite.close();
    cameraController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Text(
              'Une fruite rouge',
              textAlign: TextAlign.center,
              style: const TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              margin: EdgeInsets.only(top: 55.0),
              child: SingleChildScrollView(
                child: Text(
                  result,
                  style: TextStyle(
                    backgroundColor: Colors.black87,
                    fontSize: 30.0,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: imgCamera == null
                  ? FloatingActionButton(
                      child: Platform.isIOS | Platform.isMacOS
                          ? const Icon(CupertinoIcons.camera_fill)
                          : const Icon((Icons.camera)),
                      onPressed: () {
                        initCamera();
                      },
                    )
                  : AspectRatio(
                      aspectRatio: cameraController!.value.aspectRatio,
                      child: CameraPreview(cameraController!),
                    ),
            ),
          )
        ],
      ),
    );
  }
}
