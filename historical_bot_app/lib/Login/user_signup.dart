// ignore_for_file: camel_case_types, prefer_const_constructors, avoid_unnecessary_containers, unused_local_variable, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, unused_field, prefer_final_fields, unused_import, avoid_print, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:historical_bot_app/Dashboard/dashboard.dart';
import 'package:historical_bot_app/Dashboard/user_account.dart';
import 'package:historical_bot_app/Login/signup_utils.dart';
import 'package:historical_bot_app/Login/user_login.dart';
import 'package:historical_bot_app/Splash_screen/splash_screen1.dart';

class user_signup extends StatefulWidget {
  const user_signup({super.key});

  @override
  State<user_signup> createState() => _user_signupState();
}

class _user_signupState extends State<user_signup> {
// Firebase Authentication instance to interact with Firebase authentication services.
final FirebaseAuth _auth = FirebaseAuth.instance;

// Controllers for handling user input in various text fields.
final TextEditingController _fullnameController = TextEditingController();
final TextEditingController _phoneController = TextEditingController();
final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();

// Getter method to access the phone number controller externally.
get phoneNoController => _phoneController;

  Future<void> _signUp() async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      print("User signed up: ${userCredential.user!.uid}");

      // Show toast message upon successful sign-up
      Fluttertoast.showToast(
        msg: 'Account created Successfully. Please go back to login.',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.white,
        textColor: Colors.black,
      );

      // Add navigation logic to go back to the login page
      // For example, you can use Navigator to pop the current screen
      Navigator.of(context).pop();
    } catch (e) {
      print("Error during sign up: $e");
      // Handle errors if needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(mainColor('#BCC8F3')),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 40,
              color: Colors.black,
            )),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 0.1,
            ),
            child: Padding(
              padding: const EdgeInsets.all(33.0),
              child: Form(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 0.0,
                        ),
                        child: Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/profile.png'),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
                          right: 150,
                        ),
                        child: Text(
                          textAlign: TextAlign.left,
                          'Register as a User',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Material(
                        elevation: 8,
                        borderRadius: BorderRadius.circular(10),
                        child: TextFormField(
                          controller: _fullnameController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person_outline_outlined),
                            labelText: 'Full Name',
                            hintText: 'Full Name',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Material(
                        elevation: 8,
                        borderRadius: BorderRadius.circular(10),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.email_outlined),
                            labelText: 'Email',
                            hintText: 'Email',
                            border: InputBorder.none,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Email';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Material(
                        elevation: 8,
                        borderRadius: BorderRadius.circular(10),
                        child: TextFormField(
                          controller: phoneNoController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.phone_sharp),
                            labelText: 'Phone No',
                            hintText: 'Phone No',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Material(
                        elevation: 8,
                        borderRadius: BorderRadius.circular(10),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          controller: _passwordController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.password_outlined),
                            labelText: 'Password',
                            hintText: 'Password',
                            border: InputBorder.none,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Password';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(8),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                          minimumSize: MaterialStateProperty.all(
                            Size(double.infinity, 50), // Set button size
                          ),
                        ),
                        onPressed: _signUp,
                        child: Text(
                          'Sign Up',
                        ),
                      ),
                      SizedBox(
                        height: 11,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Already have an account ? ',
                            style: TextStyle(color: Colors.black),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: ((context) => user_login()),
                                ),
                              );
                            },
                            child: Text(
                              'Goto Login',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Color(
                                  mainColor('#384984'),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
