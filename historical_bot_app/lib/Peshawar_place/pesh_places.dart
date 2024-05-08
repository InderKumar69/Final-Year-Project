// ignore_for_file: camel_case_types, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:historical_bot_app/Dashboard/dashboard.dart';
import 'package:historical_bot_app/Dashboard/user_account.dart';
import 'package:historical_bot_app/Login/user_login.dart';
//import 'package:historical_bot_app/PeshImage_Recognition/khwanibazar_recongition.dart';
import 'package:historical_bot_app/Pesh_RealTime_Camera/khwanibazar_camera.dart';
//import 'package:historical_bot_app/Pesh_RealTime_Camera/khwanibazar_camera.dart';
import 'package:historical_bot_app/Pesh_RealTime_Camera/sethihouse_camera.dart';
import 'package:historical_bot_app/Pesh_RealTime_Camera/university_camera.dart';
import 'package:historical_bot_app/Splash_screen/splash_screen1.dart';

class pesh_places extends StatefulWidget {
  const pesh_places({super.key});

  @override
  State<pesh_places> createState() => _pesh_placesState();
}

class _pesh_placesState extends State<pesh_places> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 75,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Color(mainColor('#BCC8F3')),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.home,
                    color: Colors.black,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => user_dashboard())));
                  },
                ),
                Text(
                  'Home',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Column(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.person_3,
                    color: Colors.black,
                    size: 30,
                  ),
                  onPressed: () {
                    // Handle the 'Account' button tap
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => user_account()));
                  },
                ),
                Text(
                  'Profile',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Column(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.logout,
                    color: Colors.black,
                    size: 30,
                  ),
                  onPressed: () {
                    // Handle the 'Logout' button tap
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => user_login()));
                  },
                ),
                Text(
                  'Logout',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 235,
              width: 420,
              decoration: BoxDecoration(
                color: Color(mainColor('#BCC8F3')),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(85),
                  bottomRight: Radius.circular(150),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), // Shadow color
                    spreadRadius: 5,
                    blurRadius: 6,
                    offset: Offset(0, 1), // Changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 89,
                  right: 300,
                ),
                child: GestureDetector(
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
                top: 115,
                left: 40,
              ),
              child: Text(
                textAlign: TextAlign.left,
                ' Choose your Place for \n\t\t To get know History \n\t\t\t\t\t\t\t\t\t\t\t\t about it',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 265, left: 20),
              child: Text(
                textAlign: TextAlign.left,
                'Peshawar Historical Places',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.black,
                ),
              ),
            ),
            Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 330,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => khwanibazar_camera()));
                      },
                      child: Container(
                        height: 70,
                        width: 320,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(
                                  mainColor('#BCC8F3'),
                                ),
                                Color(
                                  mainColor('#BCC8F3'),
                                ),
                                Color(
                                  mainColor('#384984'),
                                ),
                              ]),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            'Qissa Khwani Bazar',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => cityuni_camera()));
                      },
                      child: Container(
                        height: 70,
                        width: 320,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(
                                  mainColor('#BCC8F3'),
                                ),
                                Color(
                                  mainColor('#BCC8F3'),
                                ),
                                Color(
                                  mainColor('#384984'),
                                ),
                              ]),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            'Bala Hisar Fort',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => cityuni_camera()));
                      },
                      child: Container(
                        height: 70,
                        width: 320,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(
                                  mainColor('#BCC8F3'),
                                ),
                                Color(
                                  mainColor('#BCC8F3'),
                                ),
                                Color(
                                  mainColor('#384984'),
                                ),
                              ]),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            'City University',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => sethihouse_camera()));
                      },
                      child: Container(
                        height: 70,
                        width: 320,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(
                                  mainColor('#BCC8F3'),
                                ),
                                Color(
                                  mainColor('#BCC8F3'),
                                ),
                                Color(
                                  mainColor('#384984'),
                                ),
                              ]),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            'Sethi House',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
