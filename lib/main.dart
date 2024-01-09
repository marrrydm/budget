import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_task/onb/provider.dart';
import 'tabs.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PhotoInfoProvider()),
      ],
      child: MaterialApp(
      home: MyTabs(),
    ),
    );
  }
}