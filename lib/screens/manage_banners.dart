import 'package:flutter/material.dart';

import 'package:flutter_admin_scaffold/admin_scaffold.dart';

import '../services/sidebar.dart';

import '../widgets/banner/banner_upload_widget.dart';
import '../widgets/banner/banner_widget.dart';

class BannerScreen extends StatelessWidget {
  static const String routeName = '/banner_screen';

  @override
  Widget build(BuildContext context) {
    SideBarWidget _sidebar = SideBarWidget();
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          'Admin App Dashboard',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      sideBar: _sidebar.sideBarMenus(context, BannerScreen.routeName),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Banner Screen',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 36,
                ),
              ),
              Text('Add / Delete Home Screen Banner Images'),
              Divider(
                thickness: 5,
              ),
              // Banner
              BannerWidget(),
              Divider(
                thickness: 5,
              ),
              BannerUploadWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
