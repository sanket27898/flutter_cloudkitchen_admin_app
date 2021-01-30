import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:ars_progress_dialog/ars_progress_dialog.dart';

import '../services/firebase_service.dart';

import '../screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  final _formKey = GlobalKey<FormState>();

  FirebaseServices _services = FirebaseServices();

  String username;
  String password;

  @override
  Widget build(BuildContext context) {
    ArsProgressDialog progressDialog = ArsProgressDialog(context,
        dismissable: true,
        blur: 2,
        backgroundColor: Color(0xFF84c225),
        animationDuration: Duration(milliseconds: 500));

    Future<void> _login() async {
      print('validate');
      progressDialog.show();
      _services.getAdminCredentials().then((value) {
        value.docs.forEach((doc) async {
          if (doc.get('username') == username) {
            if (doc.get('password') == password) {
              UserCredential userCredential =
                  await FirebaseAuth.instance.signInAnonymously();
              progressDialog.dismiss();

              if (userCredential.user.uid != null) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
                return;
              } else {
                _showMyDialog(
                  title: 'login',
                  message: 'Login Failed!',
                );
              }
            } else {
              progressDialog.dismiss();

              _showMyDialog(
                title: 'Invalid Password',
                message: 'password you entered is incorrect.',
              );
            }
          } else {
            _showMyDialog(
              title: 'Invalid Username',
              message: 'User Name you entered is not valid.',
            );
          }
        });
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Admin DashBoard',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: FutureBuilder(
        // Initialize FlutterFire:
        future: _initialization,
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            return Center(
              child: Text('Connection Failed'),
            );
          }

          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF84c225),
                    Colors.white,
                  ],
                  stops: [1.0, 1.0],
                  begin: Alignment.topCenter,
                  end: Alignment(0.0, 0.0),
                ),
              ),
              child: Center(
                child: Container(
                  width: 300,
                  height: 450,
                  child: Card(
                    shape: Border.all(
                      color: Colors.green,
                      width: 2,
                    ),
                    child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Container(
                                child: Column(
                                  children: [
                                    Image.asset(
                                      'images/logo.png',
                                    ),
                                    Text(
                                      'GROCERY APP ADMIN',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 20),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    TextFormField(
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Enter Username';
                                        }
                                        setState(() {
                                          username = value;
                                        });
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        labelText: 'User Name',
                                        prefixIcon: Icon(Icons.person),
                                        contentPadding: EdgeInsets.only(
                                            left: 20, right: 20),
                                        border: OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color:
                                                Theme.of(context).primaryColor,
                                            width: 2,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    TextFormField(
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Enter Password';
                                        }
                                        if (value.length < 6) {
                                          return 'Minimum 6 characters';
                                        }
                                        setState(() {
                                          password = value;
                                        });
                                        return null;
                                      },
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.vpn_key_sharp),
                                        labelText: 'Password',
                                        helperText: 'Minimum 6 characters',
                                        contentPadding: EdgeInsets.only(
                                            left: 20, right: 20),
                                        border: OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color:
                                                Theme.of(context).primaryColor,
                                            width: 2,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: FlatButton(
                                      onPressed: () {
                                        if (_formKey.currentState.validate()) {
                                          _login();
                                        }
                                      },
                                      color: Theme.of(context).primaryColor,
                                      child: Text(
                                        'Login',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )),
                  ),
                ),
              ),
            );
          }

          // Otherwise, show something whilst waiting for initialization to complete
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Future<void> _showMyDialog({title, message}) async {
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
                Text('Please try again'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
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
