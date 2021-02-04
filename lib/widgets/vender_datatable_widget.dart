import 'package:admin_web_app_flutter/services/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class VendorsDataTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseServices _services = FirebaseServices();
    return StreamBuilder(
      stream:
          _services.vendors.orderBy('shopName', descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Something went worng');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            showBottomBorder: true,
            dataRowHeight: 60,
            headingRowColor: MaterialStateProperty.all(Colors.grey[200]),
            //table headers
            columns: <DataColumn>[
              DataColumn(label: Text('Active/ Inactive')),
              DataColumn(label: Text('Top Picked')),
              DataColumn(label: Text('Shop Name')),
              DataColumn(label: Text('Rating')),
              DataColumn(label: Text('Total Sales')),
              DataColumn(label: Text('Mobile')),
              DataColumn(label: Text('Email')),
              DataColumn(label: Text('View details')),
            ],
            // details
            rows: _vendorDetailsRows(snapshot.data, _services),
          ),
        );
      },
    );
  }

  List<DataRow> _vendorDetailsRows(
      QuerySnapshot snapshot, FirebaseServices services) {
    List<DataRow> newList = snapshot.docs.map((DocumentSnapshot document) {
      return DataRow(cells: [
        DataCell(
          IconButton(
            onPressed: () {
              services.updateVendorStatus(
                id: document.data()['uid'],
                status: document.data()['accVerified'],
              );
            },
            icon: document.data()['accVerified']
                ? Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  )
                : Icon(
                    Icons.remove_circle,
                    color: Colors.red,
                  ),
          ),
        ),
        DataCell(
          IconButton(
            icon: document.data()['isTopPicked']
                ? Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  )
                : Icon(null),
            onPressed: () {
              services.updateTopPickedVendor(
                id: document.data()['uid'],
                status: document.data()['isTopPicked'],
              );
            },
          ),
        ),
        DataCell(Text(document.data()['shopName'])),
        DataCell(Row(
          children: [
            Icon(
              Icons.star,
              color: Colors.grey,
            ),
            Text('3.5'),
          ],
        )),
        DataCell(Text('20,000')),
        DataCell(Text(document.data()['mobile'])),
        DataCell(Text(document.data()['email'])),
        DataCell(IconButton(
          icon: Icon(Icons.remove_red_eye_outlined),
          onPressed: () {},
        )),
      ]);
    }).toList();
    return newList;
  }
}
