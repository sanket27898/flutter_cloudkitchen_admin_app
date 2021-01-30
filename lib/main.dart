import 'package:flutter/material.dart';

import './screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin DashBoard',
      theme: ThemeData(
        primaryColor: Color(0xFF84c225),
      ),
      home: SplashScreen(),
    );
  }
}
