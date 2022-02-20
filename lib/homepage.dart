import 'dart:io';
import 'package:capstone_concept_proof/image_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ImagePicker _picker = ImagePicker();
  ImageModel imageModel = ImageModel();

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
                  child: imageModel.previewImage,
                ),
                Expanded(
                  flex: 1,
                  child: Text.rich(
                    TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: ' Label: ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                          text: ('null'),
                        ),
                        TextSpan(
                            text: '\n Index: ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                          text: ('0'),
                        ),
                        TextSpan(
                            text: '\n Confidence: ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                          text: ('0'),
                        ),
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
                    iconImage: Icon(Icons.camera),
                    onPress: () async {
                      final _image =
                          await _picker.pickImage(source: ImageSource.camera);
                      setState(() {
                        imageModel.setPreviewImageFile(File(_image!.path));
                      });
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: PhotoButton(
                    iconImage: Icon(Icons.collections),
                    onPress: () async {
                      final _image =
                          await _picker.pickImage(source: ImageSource.gallery);
                      setState(() {
                        imageModel.setPreviewImageFile(File(_image!.path));
                      });
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
