import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../widgets/category/subcategory_widget.dart';

class CategoryCardWidget extends StatelessWidget {
  final DocumentSnapshot document;
  CategoryCardWidget({this.document});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(4),
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return SubCategoryWidget(
                categoryName: document['name'],
              );
            });
      },
      child: SizedBox(
        height: 120,
        width: 120,
        child: Card(
          color: Colors.grey[100],
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                    height: 70,
                    width: double.infinity,
                    child: Image.network(
                      document['image'],
                      fit: BoxFit.fill,
                    )),
                FittedBox(
                  fit: BoxFit.fill,
                  child: Text(
                    document['name'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
