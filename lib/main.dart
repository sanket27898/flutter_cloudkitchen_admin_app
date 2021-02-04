import 'package:admin_web_app_flutter/screens/vendor_screen.dart';
import 'package:flutter/material.dart';

import './screens/splash_screen.dart';
import './screens/admin_user_screen.dart';
import './screens/category_screen.dart';
import './screens/home_screen.dart';
import './screens/login_screen.dart';
import './screens/manage_banners.dart';
import './screens/notification_screen.dart';
import './screens/order_screen.dart';
import './screens/settings_screen.dart';

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
      routes: {
        HomeScreen.routeName: (ctx) => HomeScreen(),
        SplashScreen.routeName: (ctx) => SplashScreen(),
        LoginScreen.routeName: (ctx) => LoginScreen(),
        BannerScreen.routeName: (ctx) => BannerScreen(),
        CategoryScreen.routeName: (ctx) => CategoryScreen(),
        OrderScreen.routeName: (ctx) => OrderScreen(),
        NotificationScreen.routeName: (ctx) => NotificationScreen(),
        AdminUserScreen.routeName: (ctx) => AdminUserScreen(),
        SettingsScreen.routeName: (ctx) => SettingsScreen(),
        VendorScreen.routeName: (ctx) => VendorScreen(),
      },
    );
  }
}
