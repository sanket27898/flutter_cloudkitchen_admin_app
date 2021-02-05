import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FirebaseServices {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference banners = FirebaseFirestore.instance.collection('slider');
  CollectionReference vendors =
      FirebaseFirestore.instance.collection('vendors');
  CollectionReference category =
      FirebaseFirestore.instance.collection('category');

  FirebaseStorage storage = FirebaseStorage.instance;

  Future<DocumentSnapshot> getAdminCredentials(id) {
    var result = FirebaseFirestore.instance.collection('Admin').doc(id).get();
    return result;
  }

//!Banner
  Future<String> uploadBannerImageToDb(url) async {
    print("sanket upload qrl adsdd $url");
    String downloadUrl = await storage.ref(url).getDownloadURL();
    if (downloadUrl != null) {
      firestore.collection('slider').add({
        'image': downloadUrl,
      });
    }
    print("sanket download qrl adsdd $downloadUrl");
    return downloadUrl;
  }

  deleteBannerImagefromdb(id) async {
    firestore.collection('slider').doc(id).delete();
  }

//! vendor
  updateVendorStatus({id, status}) async {
    vendors.doc(id).update({
      'accVerified': status ? false : true,
    });
  }

  updateTopPickedVendor({id, status}) async {
    vendors.doc(id).update({
      'isTopPicked': status ? false : true,
    });
  }

//! category

  Future<String> uploadCategoryImageToDb(url, catName) async {
    print("sanket upload qrl adsdd $url");
    String downloadUrl = await storage.ref(url).getDownloadURL();
    if (downloadUrl != null) {
      category.doc(catName).set({
        'image': downloadUrl,
        'name': catName,
      });
    }
    print("sanket download qrl adsdd $downloadUrl");
    return downloadUrl;
  }

  Future<void> confirmDeleteDialog({title, message, context, id}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                deleteBannerImagefromdb(id);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> showMyDialog({title, message, context}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
