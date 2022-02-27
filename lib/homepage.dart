import 'dart:io';
import 'package:capstone_concept_proof/image_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';

import 'package:image_picker/image_picker.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List? _listResult;
  PickedFile? _imageFile;
  bool _loading = false;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loading = true;
    _loadModel();
  }

  void _loadModel() async {
    await Tflite.loadModel(
      model: "assets/mobilenet_v1_1.0_224_quant.tflite",
      labels: "assets/labels_mobilenet_quant_v1_224.txt",
    ).then((value) {
      setState(() {
        _loading = false;
      });
    });
  }

  void _imageSelection() async {
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _loading = true;
      _imageFile = PickedFile(image!.path);
    });
    _imageClasification(PickedFile(image!.path));
  }

  void _imageClasification(PickedFile image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _loading = false;
      _listResult = output;
      print('Your results are: ${_listResult.toString()}');
    });
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  // String label1 = '';
  // String label2 = '';
  // String label3 = '';

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
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: _imageFile == null
                      ? Image.asset('assets/images/mlkit_logo.png')
                      : Image.file(File(_imageFile!.path)),
                ),
                Expanded(
                  flex: 1,
                  child: Text.rich(
                    TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: ' Guess 1:',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: '\n Guess 2:',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: '\n Guess 3:',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: PhotoButton(
                    iconImage: Platform.isIOS | Platform.isMacOS
                        ? const Icon(CupertinoIcons.camera_fill)
                        : const Icon((Icons.camera)),
                    onPress: () {
                      // openCamera();
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: PhotoButton(
                    iconImage: Platform.isIOS || Platform.isMacOS
                        ? const Icon(
                            CupertinoIcons.photo_fill_on_rectangle_fill)
                        : const Icon(Icons.collections),
                    onPress: () {
                      _imageSelection();
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class PhotoButton extends StatelessWidget {
  final Icon iconImage;
  final VoidCallback onPress;

  const PhotoButton({
    required this.iconImage,
    required this.onPress,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: const ShapeDecoration(
        color: Colors.blue,
        shape: CircleBorder(),
      ),
      child: IconButton(
        onPressed: onPress,
        icon: iconImage,
        color: Colors.white,
      ),
    );
  }
}
