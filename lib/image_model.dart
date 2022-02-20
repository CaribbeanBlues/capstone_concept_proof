import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

class ImageModel {
  Image previewImage = Image.asset('images/mlkit_logo.png');
  late File imageFile;
  void setPreviewImagePath(String newPath) {
    previewImage = Image.asset(newPath);
  }

  void setPreviewImageFile(File newImageFile) {
    imageFile = newImageFile;
    previewImage = Image.file(newImageFile);
  }
}
