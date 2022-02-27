import 'dart:io';
import 'package:capstone_concept_proof/image_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  String questionText = 'Une fruite rouge';
  String bestGuest = '';
  double bestGuestConf = 0.00;
  String guessTwo = '';
  double guessTwoConf = 0.00;
  String guessThree = '';
  double guessThreeConf = 0.00;

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
              questionText,
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
                            text: ' Best Guess: ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: ' \n $bestGuest ',
                            style: TextStyle(fontStyle: FontStyle.italic)),
                        TextSpan(
                            text: ' \n $bestGuestConf ',
                            style: TextStyle(fontStyle: FontStyle.italic)),
                        TextSpan(
                            text: '\n Guess 2: ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: ' \n $guessTwo ',
                            style: TextStyle(fontStyle: FontStyle.italic)),
                        TextSpan(
                            text: ' \n $guessTwoConf ',
                            style: TextStyle(fontStyle: FontStyle.italic)),
                        TextSpan(
                            text: '\n Guess 3: ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: ' \n $guessThree: ',
                            style: TextStyle(fontStyle: FontStyle.italic)),
                        TextSpan(
                            text: ' \n $guessThreeConf: ',
                            style: TextStyle(fontStyle: FontStyle.italic)),
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
                    onPress: () async {
                      final _image =
                          await _picker.pickImage(source: ImageSource.camera);
                      setState(() {
                        imageModel.setPreviewImageFile(File(_image!.path));
                      });
                      // imageModel.readImage();
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
                    onPress: () async {
                      final _image =
                          await _picker.pickImage(source: ImageSource.gallery);
                      setState(() {
                        imageModel.setPreviewImageFile(File(_image!.path));
                      });
                      // imageModel.readImage();
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
