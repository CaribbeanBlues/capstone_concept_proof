import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class ImageModel {
  // Variables
  Image _previewImage = Image.asset('assets/images/mlkit_logo.png');
  List<ImageLabel> _labels = [];
  String bestGuest = '';
  String bestGuestConf = '0.00';
  String guessTwo = '';
  String guessTwoConf = '0.00';
  String guessThree = '';
  String guessThreeConf = '0.00';

  final _imageLabeler = GoogleMlKit.vision.imageLabeler();
  final ImagePicker _picker = ImagePicker();

  late File _imageFile;

  // List<String> titles = [];
  // String text = '';
  // int index = 0;
  // double confidence = 0.0;

  // Functions
  void setPreviewImagePath(String newPath) {
    _previewImage = Image.asset(newPath);
  }

  void _setPreviewImageFile() {
    _previewImage = Image.file(_imageFile);
  }

  Image getPreviewImage() {
    return _previewImage;
  }

  Future<void> readImage() async {
    final inputImage = InputImage.fromFile(_imageFile);
    _labels = await _imageLabeler.processImage(inputImage);
    // TODO Use the for loop below to extract and use the data
    // titles.clear();
    for (ImageLabel label in _labels) {
      // titles.add(label.label);
      final text = label.label;
      final index = label.index;
      final confidence = label.confidence;
      print("Text is: $text \n Index is: $index \n Confidence is: $confidence");
    }
    _imageLabeler.close();
  }

  List<ImageLabel> getImageLabels() {
    return _labels;
  }

  Future<void> pickImage(ImageSourceType sourceType) async {
    switch (sourceType) {
      case ImageSourceType.camera:
        _imageFile =
            File((await _picker.pickImage(source: ImageSource.camera))!.path);
        break;
      case ImageSourceType.gallery:
        _imageFile =
            File((await _picker.pickImage(source: ImageSource.gallery))!.path);
        break;
    }
    Future loadModel() async {
      Tflite.close();
      String? res;
      res = await Tflite.loadModel(
        model: "assets/models/mobilenet_v1_1.0_224_quant.tflite",
        labels: "assets/models/labels_mobilenet_quant_v1_224.txt",
      );
      print(res);
    }

    await loadModel();
    Future imageClassification(File image) async {
      // Run tensorflowlite image classification model on the image
      final List? results = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 6,
        threshold: 0.05,
        imageMean: 127.5,
        imageStd: 127.5,
      );
      print(results);
    }

    await imageClassification(_imageFile);
    await Tflite.close();
    // readImage();
    // _setPreviewImageFile();
  }

  void updateGuesses() {
    bestGuest = _labels[0].label;
    bestGuestConf = _labels[0].confidence.toStringAsFixed(2);
    guessTwo = _labels[1].label;
    guessTwoConf = _labels[1].confidence.toStringAsFixed(2);
    guessThree = _labels[2].label;
    guessThreeConf = _labels[2].confidence.toStringAsFixed(2);
  }
}

enum ImageSourceType {
  camera,
  gallery,
}
