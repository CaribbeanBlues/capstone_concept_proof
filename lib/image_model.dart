import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class ImageModel {
  // Variables
  Image _previewImage = Image.asset('images/mlkit_logo.png');
  List<ImageLabel> _labels = [];

  final _imageLabeler = GoogleMlKit.vision.imageLabeler();
  late File _imageFile;

  // List<String> titles = [];
  // String text = '';
  // int index = 0;
  // double confidence = 0.0;

  // Functions
  void setPreviewImagePath(String newPath) {
    _previewImage = Image.asset(newPath);
  }

  void setPreviewImageFile(File newImageFile) {
    _imageFile = newImageFile;
    _previewImage = Image.file(newImageFile);
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
}
