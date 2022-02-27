import 'dart:io';
import 'package:capstone_concept_proof/image_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ImageModel imageModel = ImageModel();
  String questionText = 'Une fruite rouge';

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
                            text: ' \n ${imageModel.bestGuest}',
                            style: TextStyle(fontStyle: FontStyle.italic)),
                        TextSpan(
                            text: ' \n ${imageModel.bestGuestConf} ',
                            style: TextStyle(fontStyle: FontStyle.italic)),
                        TextSpan(
                            text: '\n Guess 2: ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: ' \n ${imageModel.guessTwo}',
                            style: TextStyle(fontStyle: FontStyle.italic)),
                        TextSpan(
                            text: ' \n ${imageModel.guessTwoConf}',
                            style: TextStyle(fontStyle: FontStyle.italic)),
                        TextSpan(
                            text: '\n Guess 3: ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: ' \n ${imageModel.guessThree}',
                            style: TextStyle(fontStyle: FontStyle.italic)),
                        TextSpan(
                            text: ' \n ${imageModel.guessThreeConf}: ',
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
                    onPress: () {
                      setState(() {
                        imageModel.pickImage(ImageSourceType.camera);
                        imageModel.updateGuesses();
                      });
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
                      imageModel.pickImage(ImageSourceType.gallery);
                      setState(() {
                        imageModel.updateGuesses();
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
