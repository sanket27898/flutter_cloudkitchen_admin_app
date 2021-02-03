import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:ars_progress_dialog/ars_progress_dialog.dart';

import '../services/firebase_service.dart';

import '../screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  final _formKey = GlobalKey<FormState>();

  FirebaseServices _services = FirebaseServices();
  var _usernameTextController = TextEditingController();
  var _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ArsProgressDialog progressDialog = ArsProgressDialog(context,
        blur: 2,
        backgroundColor: Color(0xFF84c225).withOpacity(.5),
        animationDuration: Duration(milliseconds: 500));

    _login({String username, String password}) async {
      progressDialog.show();
      _services.getAdminCredentials(username).then((value) async {
        if (value.exists) {
          if (value.data()['username'] == username) {
            if (value.data()['password'] == password) {
              // if both is correct, will login
              try {
                UserCredential userCredential =
                    await FirebaseAuth.instance.signInAnonymously();

                if (userCredential != null) {
                  // if signin Sucess, will navigate to HomeScreen
                  progressDialog.dismiss();
                  Navigator.pushReplacementNamed(context, HomeScreen.routeName);
                }
              } catch (e) {
                //if signing failed
                progressDialog.dismiss();
                _services.showMyDialog(
                    context: context,
                    title: 'Login ',
                    message: '${e.toString()}');
              }
              return;
            }
            //if password incorrect
            progressDialog.dismiss();
            _services.showMyDialog(
              context: context,
              title: 'Invalid Password',
              message: 'Password you have entered is invalid , try again',
            );
            return;
          }
          // if username is incorrect
          progressDialog.dismiss();
          _services.showMyDialog(
            context: context,
            title: 'Invalid Username',
            message: 'Username you have entered is incorrect , try again',
          );
        }
        progressDialog.dismiss();
        _services.showMyDialog(
          context: context,
          title: 'Invalid Username',
          message: 'Username you have entered is incorrect , try again',
        );
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
                                      controller: _usernameTextController,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Enter Username';
                                        }

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
                                      controller: _passwordTextController,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Enter Password';
                                        }
                                        if (value.length < 6) {
                                          return 'Minimum 6 characters';
                                        }

                                        return null;
                                      },
                                      obscureText: false,
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
                                          _login(
                                            username:
                                                _usernameTextController.text,
                                            password:
                                                _passwordTextController.text,
                                          );
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
}
