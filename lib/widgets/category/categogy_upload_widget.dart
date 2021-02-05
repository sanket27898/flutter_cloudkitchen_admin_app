import 'dart:html';

import 'package:flutter/material.dart';

import 'package:admin_web_app_flutter/services/firebase_service.dart';
import 'package:firebase/firebase.dart' as fdb;

import 'package:ars_progress_dialog/ars_progress_dialog.dart';

class CaegoryCreateWidget extends StatefulWidget {
  @override
  _CaegoryCreateWidgetState createState() => _CaegoryCreateWidgetState();
}

class _CaegoryCreateWidgetState extends State<CaegoryCreateWidget> {
  FirebaseServices _services = FirebaseServices();
  var _fileNameTextController = TextEditingController();
  var _categogyNameTextController = TextEditingController();
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
                    SizedBox(
                      width: 200,
                      height: 30,
                      child: TextField(
                        controller: _categogyNameTextController,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'No Category name given ',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.only(left: 20),
                        ),
                      ),
                    ),
                    AbsorbPointer(
                      absorbing: true,
                      child: SizedBox(
                        width: 200,
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
                      absorbing: _imageSelected &&
                          _categogyNameTextController.text.isNotEmpty,
                      child: FlatButton(
                        child: Text(
                          'Save New Category',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          if (_categogyNameTextController.text.isEmpty) {
                            return _services.showMyDialog(
                                context: context,
                                title: 'Add New Category',
                                message: 'New Category Name not given');
                          }

                          progressDialog.show();
                          _services
                              .uploadCategoryImageToDb(
                                  _url, _categogyNameTextController.text)
                              .then((downloadUrl) {
                            if (downloadUrl != null) {
                              progressDialog.dismiss();
                              _services.showMyDialog(
                                  context: context,
                                  title: 'New Category',
                                  message: 'Saved New Category Successfully');
                            }
                          });

                          _categogyNameTextController.clear();
                          _fileNameTextController.clear();
                        },
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
                  'Add New Category',
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
    final path = 'Categogyimage/$dataTime';
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
