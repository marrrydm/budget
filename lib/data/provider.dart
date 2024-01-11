import 'package:flutter/material.dart';
import 'package:flutter_task/data/photo_Info.dart';

class PhotoInfoProvider extends ChangeNotifier {
  PhotoInfo? _currentPhotoInfo;

  PhotoInfo? get currentPhotoInfo => _currentPhotoInfo;

  void setPhotoInfo(PhotoInfo photoInfo) {
    _currentPhotoInfo = photoInfo;
    notifyListeners();
  }
}
