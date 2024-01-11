import 'dart:io';

import 'package:path_provider/path_provider.dart';

class PhotoStorage {
    static const String _photoFileName = 'user_photo.jpg';

  static Future<File> getUserPhotoFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/user_photo.jpg');
  }

  static Future<File> getUserPhoto() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String photoPath = "${appDocDir.path}/$_photoFileName";
    return File(photoPath);
  }

  static Future<void> deleteUserPhoto() async {
    try {
      File photo = await getUserPhoto();
      if (await photo.exists()) {
        await photo.delete();
      }
    } catch (e) {
      print('Error deleting user photo: $e');
    }
  }

  static Future<void> saveUserPhoto(File photo) async {
    try {
      final cacheFile = await getUserPhotoFile();
      await cacheFile.writeAsBytes(await photo.readAsBytes());

      print('User photo saved successfully');
    } catch (e) {
      print('Error saving user photo: $e');
    }
  }

  static Future<File?> loadUserPhoto() async {
    try {
      final cacheFile = await getUserPhotoFile();
      if (await cacheFile.exists()) {
        return cacheFile;
      }
    } catch (e) {
      print('Error loading user photo: $e');
    }
    return null;
  }
}

class UserNameCache {
  static Future<File> getUserNameFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/user_name.txt');
  }

  static Future<void> saveUserName(String userName) async {
    try {
      final cacheFile = await getUserNameFile();
      await cacheFile.writeAsString(userName);

      print('User name saved successfully');
    } catch (e) {
      print('Error saving user name: $e');
    }
  }

  static Future<String?> loadUserName() async {
    try {
      final cacheFile = await getUserNameFile();
      if (await cacheFile.exists()) {
        return await cacheFile.readAsString();
      }
    } catch (e) {
      print('Error loading user name: $e');
    }
    return null;
  }
}

class UserPhotoCache {
  Future<File?> loadUserPhoto() async {
    return await PhotoStorage.loadUserPhoto();
  }

  Future<void> saveUserPhoto(File photoFile) async {
    await PhotoStorage.saveUserPhoto(photoFile);
  }

  Future<String?> loadUserName() async {
    return await UserNameCache.loadUserName();
  }

  Future<void> saveUserName(String userName) async {
    await UserNameCache.saveUserName(userName);
  }
}