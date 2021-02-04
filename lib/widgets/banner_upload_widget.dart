import 'dart:html';

import 'package:flutter/material.dart';

import 'package:firebase/firebase.dart' as fdb;
import 'package:ars_progress_dialog/ars_progress_dialog.dart';

import '../services/firebase_service.dart';

class BannerUploadWidget extends StatefulWidget {
  @override
  _BannerUploadWidgetState createState() => _BannerUploadWidgetState();
}

class _BannerUploadWidgetState extends State<BannerUploadWidget> {
  FirebaseServices _services = FirebaseServices();
  var _fileNameTextController = TextEditingController();
  bool _visible = false;
  bool _imageSelected = true;
  String _url;
  @override
  Widget build(BuildContext context) {
    ArsProgressDialog progressDialog = ArsProgressDialog(context,
        blur: 2,
        backgroundColor: Color(0xFF84c225).withOpacity(.5),
        animationDuration: Duration(milliseconds: 500));

    return Container(
      color: Colors.grey,
      width: MediaQuery.of(context).size.width,
      height: 80,
      child: Padding(
        padding: const EdgeInsets.only(left: 30),
        child: Row(
          children: [
            Visibility(
              visible: _visible,
              child: Container(
                child: Row(
                  children: [
                    AbsorbPointer(
                      absorbing: true,
                      child: SizedBox(
                        width: 300,
                        height: 30,
                        child: TextField(
                          controller: _fileNameTextController,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'No image Selected',
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.only(left: 20),
                          ),
                        ),
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        uploadStorage();
                      },
                      child: Text(
                        'Upload image',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.black54,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    AbsorbPointer(
                      absorbing: _imageSelected,
                      child: FlatButton(
                        onPressed: () {
                          progressDialog.show();
                          _services
                              .uploadBannerImageToDb(_url)
                              .then((downloadUrl) {
                            if (downloadUrl != null) {
                              progressDialog.dismiss();
                              _services.showMyDialog(
                                  context: context,
                                  title: 'New Banner Image',
                                  message: 'Saved Banner Image Successfully');
                            }
                          });
                        },
                        child: Text(
                          'Save Image',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: _imageSelected ? Colors.black12 : Colors.black54,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Visibility(
              visible: _visible ? false : true,
              child: FlatButton(
                color: Colors.black54,
                onPressed: () {
                  setState(() {
                    _visible = true;
                  });
                },
                child: Text(
                  'Add New Banner',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void uploadImage({@required Function(File file) onSelected}) {
    InputElement uploadInput = FileUploadInputElement()
      ..accept = 'image/*'; //it will upload only image
    uploadInput.click();
    uploadInput.onChange.listen((event) {
      final file = uploadInput.files.first;
      final reader = FileReader();
      reader.readAsDataUrl(file);
      reader.onLoadEnd.listen((event) {
        onSelected(file);
      });
    });
    //selected image
  }

  void uploadStorage() {
    //upload selected image to firebase Storage

    final dataTime = DateTime.now();
    final path = 'bannerimage/$dataTime';
    uploadImage(onSelected: (file) {
      if (file != null) {
        setState(() {
          _fileNameTextController.text = file.name;
          _imageSelected = false;
          _url = path; //this path

          print('sanket$_url');
        });

        fdb
            .storage()
            .refFromURL('gs://flutterprojectapp.appspot.com')
            .child(path)
            .put(file);
        print("saketasasssssas");
        print(fdb
            .storage()
            .refFromURL('gs://flutterprojectapp.appspot.com')
            .child(path)
            .put(file));
      }
    });
  }
}
