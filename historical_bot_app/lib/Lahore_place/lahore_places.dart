// ignore_for_file: camel_case_types, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:historical_bot_app/Dashboard/dashboard.dart';
import 'package:historical_bot_app/Dashboard/user_account.dart';
import 'package:historical_bot_app/Login/user_login.dart';
import 'package:historical_bot_app/Splash_screen/splash_screen1.dart';

class lahore_places extends StatefulWidget {
  const lahore_places({super.key});

  @override
  State<lahore_places> createState() => _lahore_placesState();
}

class _lahore_placesState extends State<lahore_places> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 80,
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
      body: Stack(
        children: [
          Container(
            height: 255,
            width: 420,
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
              left: 25,
            ),
            child: Text(
              textAlign: TextAlign.left,
              ' Choose your Place for \n\t\t To get know History \n\t\t\t\t\t\t\t\t\t\t\t\t about it',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 290, left: 20),
            child: Text(
              textAlign: TextAlign.left,
              'Lahore Historical Places',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
