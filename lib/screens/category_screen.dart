import 'package:admin_web_app_flutter/widgets/category/category_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

import '../services/sidebar.dart';
import '../widgets/category/categogy_upload_widget.dart';

class CategoryScreen extends StatelessWidget {
  static const String routeName = '/catgory_screen';

  @override
  Widget build(BuildContext context) {
    SideBarWidget _sidebar = SideBarWidget();
    return AdminScaffold(
      backgroundColor: Colors.grey[50],
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
      sideBar: _sidebar.sideBarMenus(context, CategoryScreen.routeName),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Categories screen',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 36,
                ),
              ),
              Text('Add New Categories and Sub Categories'),
              Divider(
                thickness: 5,
              ),
              CaegoryCreateWidget(),
              Divider(
                thickness: 5,
              ),
              CategoryListWidget(),
              Divider(
                thickness: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
