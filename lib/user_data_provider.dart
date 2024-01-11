import 'package:flutter/material.dart';
import 'package:flutter_task/home/user_photo_cache.dart';
import 'dart:io';

class UserData {
  String? userName;
  File? userPhoto;

  UserData({this.userName, this.userPhoto});
}

class UserDataProvider extends ChangeNotifier {
  UserData _userData = UserData();

  UserData get userData => _userData;

  Future<void> loadUserData() async {
    final loadedPhoto = await PhotoStorage.loadUserPhoto();
    final loadedName = await UserNameCache.loadUserName() ?? '';

    _userData = UserData(userName: loadedName, userPhoto: loadedPhoto);
    notifyListeners();
  }

  Future<void> updateUserPhoto(File newPhoto) async {
    try {
      await PhotoStorage.deleteUserPhoto();
      await PhotoStorage.saveUserPhoto(newPhoto);

      _userData = UserData(userPhoto: newPhoto);
      notifyListeners();
    } catch (e) {
      print('Error updating user photo: $e');
    }
  }

  Future<void> saveChanges({String? newUserName, File? newPhoto}) async {
    try {
      final userNameToSave = newUserName ?? '';
      await UserNameCache.saveUserName(userNameToSave);

      final userPhotoToSave = newPhoto ?? File('assets/per2.png');

      await PhotoStorage.deleteUserPhoto();
      await PhotoStorage.saveUserPhoto(userPhotoToSave);

      _userData =
          UserData(userName: userNameToSave, userPhoto: userPhotoToSave);
      notifyListeners();
    } catch (e) {
      print('Error saving user data: $e');
    }
  }
}
