import 'package:flutter/material.dart';
import 'package:planlarim/services/auth_service.dart';

class Home extends StatefulWidget {

  static final String id = 'home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),
      body: Center(
        child: FlatButton(
          onPressed: (){
            AuthService.signOutUser(context);
          },
          color: Colors.deepOrange,
          child: Text('Logout',style: TextStyle(color: Colors.white),),
        ),
      ),
    );
  }
}
