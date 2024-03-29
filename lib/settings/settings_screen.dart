import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_task/data/user_photo_cache.dart';
import 'package:flutter_task/data/user_data_provider.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ImagePickerHandler {
  final ImagePicker _picker = ImagePicker();
  bool _isPicking = false;

  Future<void> pickUserPhoto(
      UserDataProvider userDataProvider, ImageSource source) async {
    if (_isPicking) {
      return;
    }

    try {
      _isPicking = true;

      XFile? pickedFile;
      if (source == ImageSource.camera) {
        pickedFile = await _picker.pickImage(
          source: source,
          maxHeight: 800,
          maxWidth: 800,
        );
      } else {
        pickedFile = await _picker.pickImage(source: source);
      }

      if (pickedFile != null) {
        final pickedImage = File(pickedFile.path);
        await userDataProvider.updateUserPhoto(pickedImage);
      }
    } catch (e, stackTrace) {
      print('Error picking image: $e\n$stackTrace');
    } finally {
      _isPicking = false;
    }
  }
}

class SettingsScreen extends StatefulWidget {
  final UserDataProvider userDataProvider;
  SettingsScreen(this.userDataProvider);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  TextEditingController _nameController = TextEditingController();
  final UserDataProvider _userDataProvider = UserDataProvider();
  final ImagePickerHandler _imagePickerHandler = ImagePickerHandler();

  Future<void> _initData() async {
    await _userDataProvider.loadUserData();
    final loadedName = await UserNameCache.loadUserName();
    if (loadedName != null) {
      _nameController.text = loadedName;
    }
  }

  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  void dispose() {
    final userNameToSave = _nameController.text;
    UserNameCache.saveUserName(userNameToSave);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _userDataProvider.loadUserData();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _userDataProvider,
      child: Consumer<UserDataProvider>(
        builder: (context, userDataProvider, _) {
          return SettingsScreenContent(
              _nameController, userDataProvider, _imagePickerHandler);
        },
      ),
    );
  }
}

class SettingsScreenContent extends StatelessWidget {
  final TextEditingController _nameController;
  final UserDataProvider userDataProvider;
  final ImagePickerHandler imagePickerHandler;

  SettingsScreenContent(
      this._nameController, this.userDataProvider, this.imagePickerHandler);

  Future<void> _showImagePickerDialog(BuildContext context) async {
    imageCache?.clear();
    
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Choose'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Gallery'),
                onTap: () async {
                  Navigator.of(context).pop();
                  imagePickerHandler.pickUserPhoto(
                      userDataProvider, ImageSource.gallery);
                },
              ),
              ListTile(
                title: Text('Camera'),
                onTap: () async {
                  Navigator.of(context).pop();
                  imagePickerHandler.pickUserPhoto(
                      userDataProvider, ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _openWebView(BuildContext context, String url) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => InAppWebViewPage(url: url),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/bg.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              double screenWidth = constraints.maxWidth;
              return Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 65),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () => _showImagePickerDialog(context),
                              child: CircleAvatar(
                                key: UniqueKey(), 
                                radius: 40,
                                backgroundImage: userDataProvider
                                            .userData.userPhoto !=
                                        null
                                    ? FileImage(
                                        userDataProvider.userData.userPhoto!)
                                    : null,
                                child:
                                    userDataProvider.userData.userPhoto == null
                                        ? Icon(Icons.camera_alt)
                                        : null,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              width: screenWidth * 0.4,
                              child: TextField(
                                controller: _nameController,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: screenWidth * 0.04,
                                  fontFamily: 'SrbijaSans',
                                  fontWeight: FontWeight.w400,
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Name',
                                  hintStyle: TextStyle(
                                    color: Colors.black.withOpacity(0.5),
                                    fontSize: 20,
                                    fontFamily: 'SrbijaSans',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: screenWidth * 0.04,
                    top: 65,
                    child: GestureDetector(
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      child: Text(
                        'Edit',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'SrbijaSans',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: screenWidth * 0.04,
                    right: screenWidth * 0.04,
                    top: 210,
                    child: Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildRow('Privacy Policy', 'i1.png', screenWidth,
                              'https://www.google.com'),
                          const SizedBox(height: 10),
                          _buildDivider(screenWidth),
                          const SizedBox(height: 10),
                          _buildRow('Terms of Use', 'i2.png', screenWidth,
                              'https://www.google.com'),
                          const SizedBox(height: 10),
                          _buildDivider(screenWidth),
                          const SizedBox(height: 10),
                          _buildRow('Notification', 'i3.png', screenWidth,
                              'https://www.google.com'),
                          const SizedBox(height: 10),
                          _buildDivider(screenWidth),
                          const SizedBox(height: 10),
                          _buildRow('Share App', 'i4.png', screenWidth,
                              'https://www.google.com'),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildRow(
      String text, String imageName, double screenWidth, String url) {
    return Builder(
      builder: (context) => GestureDetector(
        onTap: () {
          if (text == 'Privacy Policy' || text == 'Terms of Use') {
            _openWebView(context, url);
          }
        },
        child: Container(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: screenWidth * 0.05,
                      height: screenWidth * 0.05,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/$imageName'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 7),
                    Text(
                      text,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'SrbijaSans',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: 24,
                    height: 24,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/ArrowRight.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDivider(double screenWidth) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 0.7,
            strokeAlign: BorderSide.strokeAlignCenter,
            color: Color(0xFF474747),
          ),
        ),
      ),
    );
  }
}

class InAppWebViewPage extends StatelessWidget {
  final String url;

  InAppWebViewPage({required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: InAppWebView(
          initialUrlRequest: URLRequest(url: Uri.parse(url)),
          initialOptions: InAppWebViewGroupOptions(
            crossPlatform: InAppWebViewOptions(),
          ),
          onWebViewCreated: (InAppWebViewController controller) {
            print("WebView created");
          },
          onLoadStart: (controller, url) {
            print("WebView loading started: $url");
          },
          onLoadStop: (controller, url) {
            print("WebView loading finished: $url");
          },
          onProgressChanged: (controller, progress) {
            print("WebView progress: $progress");
            if (progress == 100) {
              print("WebView loaded successfully!");
            }
          }),
    );
  }
}
