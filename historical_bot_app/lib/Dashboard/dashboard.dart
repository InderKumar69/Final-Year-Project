// ignore_for_file: camel_case_types, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, non_constant_identifier_names, unnecessary_string_interpolations, prefer_typing_uninitialized_variables, prefer_final_fields, avoid_unnecessary_containers, unnecessary_null_comparison, use_key_in_widget_constructors, sized_box_for_whitespace

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:historical_bot_app/Dashboard/user_account.dart';
import 'package:historical_bot_app/Login/user_login.dart';
import 'package:historical_bot_app/Map/lahore_map.dart';
import 'package:historical_bot_app/Map/peshawar_map.dart';
import 'package:historical_bot_app/Splash_screen/splash_screen1.dart';

class user_dashboard extends StatefulWidget {
  const user_dashboard({super.key});

  @override
  State<user_dashboard> createState() => _user_dashboardState();
}

class _user_dashboardState extends State<user_dashboard> {
  int _currentIndex = 0;
  final myitems = [
    Image.asset('assets/babe_khyber.png'),
    Image.asset('assets/minare_pakistan.png'),
  ];
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
      body: Stack(
        children: <Widget>[
          Container(
            height: 235,
            width: 390,
            decoration: BoxDecoration(
              color: Color(mainColor('#BCC8F3')),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(90),
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
                bottom: 75,
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
              top: 120,
              left: 25,
            ),
            child: Text(
              textAlign: TextAlign.left,
              '\t\t\t\t Welcome to \n\t\t\t\t Guide Bot App',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 280, left: 30),
            child: Text(
              textAlign: TextAlign.left,
              'Select Your City',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 350,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      autoPlay: false,
                      height: 280,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 1000),
                      autoPlayInterval: const Duration(seconds: 5),
                      enlargeCenterPage: true,
                      aspectRatio: 2.0,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                    ),
                    items: myitems.asMap().entries.map((entry) {
                      int index = entry.key;
                      Widget image = entry.value;

                      return GestureDetector(
                        onTap: () {
                          // Navigate to respective maps
                          if (index == 0) {
                            // Navigate to Peshawar map
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => peshawar_map()),
                            );
                          } else if (index == 1) {
                            // Navigate to Lahore map
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => lahore_map()),
                            );
                          }
                        },
                        child: Column(
                          children: [
                            Container(
                              width: 300,
                              height: 180,
                              margin: EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: BoxDecoration(
                                color: Color(mainColor('#BCC8F3')),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: image,
                            ),
                            SizedBox(height: 10),
                            Text(
                              index == 0 ? 'Peshawar City' : 'Lahore City',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                buildDot(0),
                                SizedBox(width: 9),
                                buildDot(1),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDot(int index) {
    return Container(
      height: 10,
      width: _currentIndex == index ? 25 : 15,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: _currentIndex == index ? Colors.black : Colors.grey,
      ),
    );
  }
}
