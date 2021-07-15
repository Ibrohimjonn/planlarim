import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:planlarim/pages/signin_page.dart';
import 'package:planlarim/services/auth_service.dart';
import 'package:planlarim/services/prefs_service.dart';
import 'package:planlarim/services/utils_service.dart';

import 'home_page.dart';

class SignUp extends StatefulWidget {

  static final String id = 'signup';

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var isLoading = false;
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  _doSignUp(){
    String name = nameController.text.toString().trim();
    String email = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();
    if(name.isEmpty || email.isEmpty || password.isEmpty) return;

    setState(() {
      isLoading = true;
    });
    AuthService.signUpUser(context, name, email, password).then((firebaseUser) => {
      _getFirebaseUser(firebaseUser)
    });

  }

  _getFirebaseUser(FirebaseUser firebaseUser) async{
    setState(() {
      isLoading = false;
    });
    if(firebaseUser != null){
      await Prefs.saveUserId(firebaseUser.uid);
      Navigator.pushReplacementNamed(context, Home.id);
    }else{
      Utils.fireToast("Check your information");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(28.0),
                    ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepOrange,width: 1.5),
                      ),
                      hintText: "Full name"
                  ),
                ),
                SizedBox(height: 20,),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(28.0),
                    ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepOrange,width: 1.5),
                      ),
                      hintText: "Email"
                  ),
                ),
                SizedBox(height: 20,),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(28.0),
                    ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepOrange,width: 1.5),
                      ),
                      hintText: "Password",
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    margin: EdgeInsets.only(left: 40,right: 40),
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(22),topRight: Radius.circular(22)),
                      color: Colors.deepOrange,
                    ),
                    child: FlatButton(
                      onPressed: _doSignUp,
                      child: Text('Sign Up',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                    ),
                  ),
                SizedBox(height: 25,),

                Text('Already Have an Account',style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),),
                SizedBox(height: 12,),
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, SignIn.id);
                  },
                    child: Text('Sign In',style: TextStyle(color: Colors.deepOrange,fontSize: 24,fontWeight: FontWeight.bold),)),
              ],
            ),
          ),
          isLoading ?
          Center(
            child: CircularProgressIndicator(),
          ): SizedBox.shrink(),
        ],
      ),
    );
  }
}
