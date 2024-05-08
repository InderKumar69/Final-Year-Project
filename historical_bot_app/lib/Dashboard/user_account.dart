// ignore_for_file: camel_case_types, prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, unused_import, sort_child_properties_last

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:historical_bot_app/Dashboard/user_components.dart';
import 'package:historical_bot_app/Splash_screen/splash_screen1.dart';

class user_account extends StatefulWidget {
  @override
  State<user_account> createState() => _user_accountState();
}

class _user_accountState extends State<user_account> {
  // Current User Profile Details with Firebase data
  final currentUser = FirebaseAuth.instance.currentUser!;
  // Edit field
  Future<void> editField(String field) async {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 320,
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
            ),
            // alignment of arrow back icon on the screen
            child: Padding(
              padding: const EdgeInsets.only(
                top: 0,
                bottom: 200,
                right: 300,
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
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
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 55),
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/user.png'),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 28, left: 55),
                child: Text(
                  currentUser.email!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 350, left: 30),
            child: Text(
              'My Details',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.black,
              ),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 400, left: 25),
                child: Container(
                  height: 80,
                  width: 350,
                  decoration: BoxDecoration(
                    color: Color(mainColor('#BCC8F3')),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Full Name:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Inder Kumar',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 25),
                child: Container(
                  height: 80,
                  width: 350,
                  decoration: BoxDecoration(
                    color: Color(mainColor('#BCC8F3')),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Change Password:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        '**********',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 25),
                child: Container(
                  height: 80,
                  width: 350,
                  decoration: BoxDecoration(
                    color: Color(mainColor('#BCC8F3')),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Phone No:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        '03499368905',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 700,
              left: 40,
              right: 40,
            ),
            child: ElevatedButton(
              onPressed: () {},
              child: Text(
                'Save',
              ),
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(8),
                backgroundColor: MaterialStateProperty.all(Colors.black),
                foregroundColor: MaterialStateProperty.all(Colors.white),
                minimumSize: MaterialStateProperty.all(
                  Size(double.infinity, 50),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
