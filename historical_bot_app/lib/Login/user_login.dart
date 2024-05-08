// ignore_for_file: camel_case_types, prefer_const_constructors, avoid_unnecessary_containers, unnecessary_new, unused_field, prefer_final_fields, avoid_print, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:historical_bot_app/Dashboard/dashboard.dart';
import 'package:historical_bot_app/Login/user_forgotpassword.dart';
import 'package:historical_bot_app/Login/user_signup.dart';
import 'package:historical_bot_app/Splash_screen/splash_screen1.dart';

class user_login extends StatefulWidget {
  const user_login({super.key});

  @override
  State<user_login> createState() => _user_loginState();
}

class _user_loginState extends State<user_login> {
// This global key is used to uniquely identify and manage the state of a Form widget.
  final _formKey = GlobalKey<FormState>();

// Controllers for handling user input in text fields.
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

// Firebase Authentication instance to interact with Firebase authentication services.
  final FirebaseAuth _auth = FirebaseAuth.instance;

//t provides an opportunity to clean up or release any resources that the State object might be holding,
//such as controllers, listeners, or other objects that require manual cleanup.
  @override
  void dispose() {
    // Call the superclass's dispose method to ensure proper disposal of resources.
    super.dispose();

    // Dispose of the TextEditingController for the email field to free up resources.
    emailController.dispose();

    // Dispose of the TextEditingController for the password field to free up resources.
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Container for the box We develop the Login Screen in Dribble design
            Container(
              height: 350,
              width: 390,
              decoration: BoxDecoration(
                color: Color(mainColor('#BCC8F3')),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(100),
                  bottomRight: Radius.circular(100),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(mainColor('#BCC8F3')),
                    spreadRadius: 6,
                    blurRadius: 0.5,
                  ),
                ],
                // shown image on the dribble box
                image: DecorationImage(
                  image: AssetImage('assets/login.png'),
                  scale: 1.9,
                  alignment: Alignment(0.2, 0.7),
                ),
              ),
              // alignment of arrow back icon on the screen
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 0,
                  bottom: 200,
                  right: 300,
                ),
                child: GestureDetector(
                  // navigation for going back from the login screen to splash screen
                  // For text and icon we use Gesture detector for press and navigation
                  onTap: () {
                    Navigator.pop(
                      context,
                    );
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 50,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                right: 150,
              ),
              child: Text(
                textAlign: TextAlign.left,
                'Login as a User',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.black,
                ),
              ),
            ),
            Form(
              key: _formKey,
              child: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 40.0, horizontal: 40.0),
                child: Column(
                  children: [
                    Material(
                      elevation: 8,
                      borderRadius: BorderRadius.circular(10),
                      // Textfields For Email
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person_outline_outlined),
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
                      // Textfield For Password
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: passwordController,
                        obscureText: true,
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
                      height: 15,
                    ),
                    GestureDetector(
                      // forgot password it navigate to forgot password screen
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => user_forgotpassword()),
                          ),
                        );
                      },
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Forgot Paswword ?',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Color(
                              mainColor('#384984'),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                      width: double.infinity,
                    ),
                    // Login Button
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          try {
                            UserCredential userCredential =
                                await _auth.signInWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                            print(
                                'User signed in: ${userCredential.user!.uid}');

                            // Show toast message upon successful login
                            Fluttertoast.showToast(
                              msg: 'Login Successfully',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 2,
                              backgroundColor: Colors.white,
                              textColor: Colors.black,
                            );

                            // Move navigation here, inside the try block
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => user_dashboard(),
                              ),
                            );
                          } on FirebaseAuthException catch (e) {
                            // Handle login errors, if any
                            print('Error during login: $e');
                            Fluttertoast.showToast(
                              msg:
                                  'Login failed. Check your email and password.',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.white,
                              textColor: Colors.black,
                            );
                          }
                        }
                      },
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(8),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        minimumSize: MaterialStateProperty.all(
                          Size(double.infinity, 50),
                        ),
                      ),
                      child: Text('Login'),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // Dont have an account to navigate to singup screen
                        Text('Dont have an account ? '),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: ((context) => user_signup()),
                              ),
                            );
                          },
                          child: Text(
                            'Sign up Here',
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
          ],
        ),
      ),
    );
  }
}
