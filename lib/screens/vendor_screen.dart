import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

import '../services/sidebar.dart';

import '../widgets/vendor/vender_datatable_widget.dart';

class VendorScreen extends StatefulWidget {
  static const String routeName = '/vendor_screen';
  @override
  _VendorScreenState createState() => _VendorScreenState();
}

class _VendorScreenState extends State<VendorScreen> {
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
      sideBar: _sidebar.sideBarMenus(context, VendorScreen.routeName),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Manage Vendors',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 36,
                ),
              ),
              Text('Manage all the Vendors Activites'),
              Divider(
                thickness: 5,
              ),
              VendorsDataTable(),
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
