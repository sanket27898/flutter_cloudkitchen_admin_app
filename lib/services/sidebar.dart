import 'package:admin_web_app_flutter/screens/vendor_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

import '../screens/home_screen.dart';
import '../screens/admin_user_screen.dart';
import '../screens/category_screen.dart';
import '../screens/login_screen.dart';
import '../screens/manage_banners.dart';
import '../screens/notification_screen.dart';
import '../screens/order_screen.dart';
import '../screens/settings_screen.dart';

class SideBarWidget {
  sideBarMenus(context, selectedRoute) {
    return SideBar(
      activeBackgroundColor: Colors.black54,
      activeIconColor: Colors.white,
      activeTextStyle: TextStyle(color: Colors.white),
      items: const [
        MenuItem(
          title: 'Dashboard',
          route: HomeScreen.routeName,
          icon: Icons.dashboard,
        ),
        MenuItem(
          title: 'Banners',
          route: BannerScreen.routeName,
          icon: CupertinoIcons.photo,
        ),
        MenuItem(
          title: 'Vendor',
          route: VendorScreen.routeName,
          icon: CupertinoIcons.group_solid,
        ),
        MenuItem(
          title: 'Categories',
          route: CategoryScreen.routeName,
          icon: Icons.category,
        ),
        MenuItem(
          title: 'Orders',
          route: OrderScreen.routeName,
          icon: CupertinoIcons.cart_fill,
        ),
        MenuItem(
          title: 'Send Notification',
          route: NotificationScreen.routeName,
          icon: Icons.notifications,
        ),
        MenuItem(title: 'Product', icon: Icons.admin_panel_settings, children: [
          MenuItem(
            title: 'Product List',
            route: AdminUserScreen.routeName,
            icon: Icons.notifications,
          ),
        ]),
        MenuItem(
          title: 'Settings',
          route: SettingsScreen.routeName,
          icon: Icons.settings,
        ),
        MenuItem(
          title: 'Exit',
          route: LoginScreen.routeName,
          icon: Icons.exit_to_app,
        ),
      ],
      selectedRoute: selectedRoute,
      onSelected: (item) {
        Navigator.of(context).pushNamed(item.route);
      },
      header: Container(
        height: 50,
        width: double.infinity,
        color: Colors.black26,
        child: Center(
          child: Text(
            'MENU',
            style: TextStyle(
                letterSpacing: 2,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      footer: Container(
        height: 50,
        width: double.infinity,
        color: Colors.black26,
        child: Center(
          child: Image.asset(
            'images/logo.png',
            height: 30,
          ),
        ),
      ),
    );
  }
}
