import 'package:flutter/material.dart';
import 'package:planlarim/pages/home_page.dart';
import 'package:planlarim/pages/signin_page.dart';
import 'package:planlarim/pages/signup_page.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
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
      home: SignIn(),
      routes: {
        Home.id: (context) => Home(),
        SignIn.id: (context) => SignIn(),
        SignUp.id: (context) => SignUp(),
      },
    );
  }
}

