import 'package:flutter/material.dart';
import 'package:flutter_task/home/home.dart';
import 'package:flutter_task/budget/budget_screen.dart';
import 'package:flutter_task/onb/photo_screen.dart';
import 'package:flutter_task/settings/settings_screen.dart';
import 'package:flutter_task/user_data_provider.dart';

class MyTabs extends StatefulWidget {
  @override
  _MyTabsState createState() => _MyTabsState();
}

class _MyTabsState extends State<MyTabs> {
  int _currentIndex = 0;

  final List<String> _tabTitles = ['Home', 'Budget', 'Advices', 'Settings'];
  final List<String> _tabImages = [
    'assets/tab1.png',
    'assets/tab2.png',
    'assets/tab3.png',
    'assets/tab4.png'
  ];
  final String _backgroundImage = 'assets/bg.jpg';
  final UserDataProvider userDataProvider = UserDataProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: buildTabItem(_currentIndex),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  Widget buildBottomNavigationBar() {
    return Container(
      height: 76,
      margin: EdgeInsets.only(bottom: 35, left: 15, right: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(35),
          bottom: Radius.circular(35),
        ),
        color: Colors.black,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(
          _tabTitles.length,
          (index) => buildTabItemContainer(index),
        ),
      ),
    );
  }

  Widget buildTabItemContainer(int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _currentIndex = index;
          });
        },
        child: Container(
          width: 104,
          height: 62,
          margin: EdgeInsets.only(left: 7, right: 7),
          padding: const EdgeInsets.symmetric(horizontal: 2),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: _currentIndex == index ? Colors.white : Colors.black,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _currentIndex == index
                    ? Text(
                        _tabTitles[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: _currentIndex == index
                              ? Colors.black
                              : Colors.white,
                          fontSize: 16,
                          fontFamily: 'SrbijaSans',
                          fontWeight: FontWeight.w400,
                          height: 1.2,
                          letterSpacing: -0.30,
                        ),
                      )
                    : Image.asset(
                        _tabImages[index],
                        width: 24,
                        height: 24,
                        color: _currentIndex == index
                            ? Colors.black
                            : Colors.white,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTabItem(int index) {
    switch (index) {
      case 0:
        return HomeScreen();
      case 1:
        return BudgetScreen();
      case 2:
        return ThreePhotosScreen();
      case 3:
        return SettingsScreen(userDataProvider);
      default:
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(_backgroundImage),
              fit: BoxFit.cover,
            ),
          ),
        );
    }
  }
}
