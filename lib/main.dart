import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:planlarim/pages/detail_page.dart';
import 'package:planlarim/pages/home_page.dart';
import 'package:planlarim/pages/signin_page.dart';
import 'package:planlarim/pages/signup_page.dart';
import 'package:planlarim/services/prefs_service.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {

  Widget _startPage() {
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          Prefs.saveUserId(snapshot.data.uid);
          return Home();
        } else {
          Prefs.removeUserId();
          return SignIn();
        }
      },
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: _startPage(),
      routes: {
        Home.id: (context) => Home(),
        SignIn.id: (context) => SignIn(),
        SignUp.id: (context) => SignUp(),
        Detail.id: (context) => Detail(),
      },
    );
  }
}

