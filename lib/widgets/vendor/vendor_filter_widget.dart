import 'package:flutter/material.dart';

class VendorFilterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ActionChip(
              elevation: 3,
              backgroundColor: Colors.black54,
              onPressed: () {},
              label: Text(
                'All Vendors',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ActionChip(
              elevation: 3,
              backgroundColor: Colors.black54,
              onPressed: () {},
              label: Text(
                'Active',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ActionChip(
              elevation: 3,
              backgroundColor: Colors.black54,
              onPressed: () {},
              label: Text(
                'Inactive',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ActionChip(
              elevation: 3,
              backgroundColor: Colors.black54,
              onPressed: () {},
              label: Text(
                'TopPicked',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ActionChip(
              elevation: 3,
              backgroundColor: Colors.black54,
              onPressed: () {},
              label: Text(
                'Top Rated',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
