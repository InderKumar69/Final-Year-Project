// ignore_for_file: camel_case_types, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:historical_bot_app/Login/signup_utils.dart';
import 'package:historical_bot_app/Splash_screen/splash_screen1.dart';

class user_forgotpassword extends StatefulWidget {
  const user_forgotpassword({super.key});

  @override
  State<user_forgotpassword> createState() => _user_forgotpasswordState();
}

class _user_forgotpasswordState extends State<user_forgotpassword> {
  final emailController = TextEditingController();
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(mainColor('#384984')),
            Color(mainColor('#384984')),
            Color(mainColor('#BCC8F3')),
            Color(mainColor('#BCC8F3')),
            Color(mainColor('#BCC8F3')),
            Color(mainColor('#BCC8F3')),
            Color(mainColor('#384984')),
            Color(mainColor('#384984')),
          ],
        ),
      ),
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 40), // Adjust the vertical spacing
              Align(
                alignment: Alignment.topLeft, // Position the arrow-back icon
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    top: 30,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 50,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 130,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 40.0,
                  horizontal: 40.0,
                ),
                child: Material(
                  elevation: 8,
                  color: Color(mainColor('#BCC8F3')),
                  borderRadius: BorderRadius.circular(10),
                  child: TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person_outline_outlined),
                      labelText: 'Email',
                      hintText: 'Email',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: 200,
                height: 56,
                child: ElevatedButton(
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(8),
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  onPressed: () {
                    auth
                        .sendPasswordResetEmail(
                            email: emailController.text.toString())
                        .then((value) {
                      Utils().ToastMessage(
                          'We Have sent you a email to recover password Please check you emial');
                    }).onError((error, stackTrace) {
                      Utils().ToastMessage(error.toString());
                    });
                  },
                  child: Text('Forgot Password'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
