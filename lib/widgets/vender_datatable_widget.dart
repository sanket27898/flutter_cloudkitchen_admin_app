import 'package:admin_web_app_flutter/services/firebase_service.dart';
import 'package:admin_web_app_flutter/widgets/vendor_details_box.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class VendorsDataTable extends StatefulWidget {
  @override
  _VendorsDataTableState createState() => _VendorsDataTableState();
}

class _VendorsDataTableState extends State<VendorsDataTable> {
  FirebaseServices _services = FirebaseServices();

  int tag = 0;
  List<String> options = [
    'All Vendors',
    'Active Vendors',
    'Inactive Vendors',
    'Top Picked',
    'Top Rated',
  ];

  bool topPicked;
  bool active;

  filter(val) {
    if (val == 0) {
      setState(() {
        topPicked = null;
        active = null;
      });
    }
    if (val == 1) {
      setState(() {
        active = true;
        topPicked = null;
      });
    }
    if (val == 2) {
      setState(() {
        active = false;
        topPicked = null;
      });
    }
    if (val == 3) {
      setState(() {
        topPicked = true;
        active = null;
      });
    }
    if (val == 4) {
      setState(() {
        topPicked = null;
        active = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ChipsChoice<int>.single(
          value: tag,
          onChanged: (val) => setState(() {
            tag = val;
            print(val);
            filter(val);
          }),
          choiceItems: C2Choice.listFrom<int, String>(
            activeStyle: (i, v) {
              return C2ChoiceStyle(
                brightness: Brightness.dark,
                color: Colors.black54,
              );
            },
            source: options,
            value: (i, v) => i,
            label: (i, v) => v,
          ),
        ),
        Divider(
          thickness: 5,
        ),
        StreamBuilder(
          stream: _services.vendors
              .where(
                'accVerified',
                isEqualTo: active,
              )
              .where('isTopPicked', isEqualTo: topPicked)
              .snapshots(),
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
        ),
      ],
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
          icon: Icon(Icons.info_outlined),
          onPressed: () {
            // will popup vendor details screen
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return VendorDetailssBox(
                    uid: document.data()['uid'],
                  );
                });
          },
        )),
      ]);
    }).toList();
    return newList;
  }
}
