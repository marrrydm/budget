import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_task/data/user_photo_cache.dart';
import 'package:flutter_task/data/user_data_provider.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController costController = TextEditingController();
  TextEditingController daysController = TextEditingController();
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();
  int selectedDays = 0;
  String resultText = '\$ 0';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: HomeScreenBody(
          costController: costController,
          daysController: daysController,
          fromDate: fromDate,
          toDate: toDate,
          selectedDays: selectedDays,
          resultText: resultText,
          onCalculate: _handleCalculate,
          onDatePick: _handleDatePick,
        ),
      ),
    );
  }

  void _handleCalculate() {
    double cost = double.tryParse(costController.text) ?? 0;
    int days = int.tryParse(daysController.text) ?? 0;
    double result = 8 * days * cost;

    setState(() {
      resultText = '\$ ${result.toStringAsFixed(0)}';
    });

    print('Result: $result');
  }

  void _handleDatePick() async {
    DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        fromDate = picked.start;
        toDate = picked.end;
        selectedDays = (toDate.difference(fromDate).inDays) + 1;
        daysController.text = selectedDays.toString();
      });
    }
  }
}

class HomeScreenBody extends StatelessWidget {
  final TextEditingController costController;
  final TextEditingController daysController;
  final DateTime fromDate;
  final DateTime toDate;
  final int selectedDays;
  final String resultText;
  final VoidCallback onCalculate;
  final VoidCallback onDatePick;

  HomeScreenBody({
    required this.costController,
    required this.daysController,
    required this.fromDate,
    required this.toDate,
    required this.selectedDays,
    required this.resultText,
    required this.onCalculate,
    required this.onDatePick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/bg.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserInfoWidget(),
            SizedBox(height: 20),
            ContainerWidget(
              costController: costController,
              daysController: daysController,
              fromDate: fromDate,
              toDate: toDate,
              selectedDays: selectedDays,
              resultText: resultText,
              onCalculate: onCalculate,
              onDatePick: onDatePick,
            ),
          ],
        ),
      ),
    );
  }
}

class UserInfoWidget extends StatelessWidget {
  final UserDataProvider _userDataProvider = UserDataProvider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [UserInfoDetailsWidget(_userDataProvider)],
      ),
    );
  }
}

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

class UserInfoDetailsWidget extends StatefulWidget {
  final UserDataProvider userDataProvider;
  UserInfoDetailsWidget(this.userDataProvider);

  @override
  _UserInfoDetailsWidgetState createState() => _UserInfoDetailsWidgetState();
}

class _UserInfoDetailsWidgetState extends State<UserInfoDetailsWidget> {
  final ImagePickerHandler _imagePickerHandler = ImagePickerHandler();
  final UserDataProvider _userDataProvider = UserDataProvider();

  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _initData() async {
    await _userDataProvider.loadUserData();
  }

  @override
  void didChangeDependencies() {
    _userDataProvider.loadUserData();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final userDataProvider = UserDataProvider();
    userDataProvider.loadUserData();

    return ChangeNotifierProvider(
      create: (context) => userDataProvider,
      child: Consumer<UserDataProvider>(
        builder: (context, userDataProvider, _) {
          return UserInfoDetailsWidgetContent(
              userDataProvider, _imagePickerHandler);
        },
      ),
    );
  }
}

class UserInfoDetailsWidgetContent extends StatelessWidget {
  final UserDataProvider userDataProvider;
  final ImagePickerHandler imagePickerHandler;

  UserInfoDetailsWidgetContent(this.userDataProvider, this.imagePickerHandler);

  @override
Widget build(BuildContext context) {
  final userData = userDataProvider.userData;

  return FutureBuilder<String?>(
    future: UserNameCache.loadUserName(),
    builder: (context, snapshot) {
      final loadedName = snapshot.data;

      return Row(
        children: [
          Container(
            margin: EdgeInsets.only(left: 15),
            child: GestureDetector(
              onTap: () => _showImagePickerDialog(context),
              child: CircleAvatar(
                radius: 25,
                backgroundImage: userData.userPhoto != null
                    ? FileImage(userData.userPhoto!)
                    : null,
                child: userData.userPhoto == null
                    ? Icon(Icons.camera_alt)
                    : null,
              ),
            ),
          ),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                child: Text(
                  'Hi, ${loadedName ?? 'Name'}!',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontFamily: 'SrbijaSans',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: 7),
              SizedBox(
                child: Text(
                  'hjkdjbdhdhjsk@gmail.com',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.7),
                    fontSize: 16,
                    fontFamily: 'SrbijaSans',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}


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
}

class ContainerWidget extends StatelessWidget {
  final TextEditingController costController;
  final TextEditingController daysController;
  final DateTime fromDate;
  final DateTime toDate;
  final int selectedDays;
  final String resultText;
  final VoidCallback onCalculate;
  final VoidCallback onDatePick;

  ContainerWidget({
    required this.costController,
    required this.daysController,
    required this.fromDate,
    required this.toDate,
    required this.selectedDays,
    required this.resultText,
    required this.onCalculate,
    required this.onDatePick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15),
      height: 342,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 7),
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: Colors.white.withOpacity(0.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ),
          Positioned(
            left: 73,
            bottom: 15,
            height: 50,
            child: GestureDetector(
              onTap: onCalculate,
              child: CalculateButton(),
            ),
          ),
          Positioned(
            left: 15,
            top: 15,
            right: 15,
            child: CostPerHourTextField(costController: costController),
          ),
          Positioned(
            left: 15,
            top: 99,
            right: 15,
            height: 64,
            child: GestureDetector(
              onTap: onDatePick,
              child: DateRangePickerField(
                selectedDays: selectedDays,
                daysController: daysController,
              ),
            ),
          ),
          Positioned(
            left: 15,
            top: 203,
            child: ResultText(resultText: resultText),
          ),
        ],
      ),
    );
  }
}

class CalculateButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 16),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Calculate',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'Srbija Sans',
              fontWeight: FontWeight.w700,
              letterSpacing: -0.30,
            ),
          ),
        ],
      ),
    );
  }
}

class CostPerHourTextField extends StatelessWidget {
  final TextEditingController costController;

  CostPerHourTextField({required this.costController});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.only(left: 15),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1),
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: TextField(
              controller: costController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
              ],
              style: TextStyle(
                color: Colors.black.withOpacity(0.7),
                fontSize: 14,
                fontFamily: 'SrbijaSans',
                fontWeight: FontWeight.w300,
              ),
              decoration: InputDecoration(
                hintText: 'Cost per hour',
                hintStyle: TextStyle(
                  color: Colors.black.withOpacity(0.7),
                  fontSize: 14,
                  fontFamily: 'SrbijaSans',
                  fontWeight: FontWeight.w300,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DateRangePickerField extends StatelessWidget {
  final int selectedDays;
  final TextEditingController daysController;

  DateRangePickerField({
    required this.selectedDays,
    required this.daysController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 7, left: 15, right: 7, bottom: 7),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1),
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              selectedDays != 0 ? selectedDays.toString() : 'Days worked',
              style: TextStyle(
                color: Colors.black.withOpacity(0.7),
                fontSize: 14,
                fontFamily: 'SrbijaSans',
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          Container(
              width: 50,
              height: 50,
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              child: Image.asset('assets/botton.png')),
        ],
      ),
    );
  }
}

class ResultText extends StatelessWidget {
  final String resultText;

  ResultText({required this.resultText});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 315,
      child: Text(
        resultText,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontSize: 32,
          fontFamily: 'Srbija Sans',
          fontWeight: FontWeight.w700,
          height: 0.24,
        ),
      ),
    );
  }
}
