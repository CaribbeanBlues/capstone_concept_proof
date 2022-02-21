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
    // for (ImageLabel label in labels) {
    //   final String text = label.label;
    //   final int index = label.index;
    //   final double confidence = label.confidence;
    // }
    _imageLabeler.close();
  }

  List<ImageLabel> getImageLabels() {
    return _labels;
  }
}
