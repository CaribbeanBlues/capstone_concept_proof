import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class ImageModel {
  Image previewImage = Image.asset('images/mlkit_logo.png');
  void setPreviewImagePath(String newPath) {
    previewImage = Image.asset(newPath);
  }

  void setPreviewImageFile(Image newImageFile) {
    previewImage = newImageFile;
  }
}
