import 'dart:io';
import 'package:camera/camera.dart';
import 'package:capstone_concept_proof/image_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
                  child: imageModel.getPreviewImage(),
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                child: Platform.isIOS | Platform.isMacOS
                    ? const Icon(CupertinoIcons.camera_fill)
                    : const Icon((Icons.camera)),
                onPressed: () {},
              ),
            ),
          )
        ],
      ),
    );
  }
}
