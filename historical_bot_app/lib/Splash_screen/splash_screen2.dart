// ignore_for_file: camel_case_types, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings, non_constant_identifier_names, sized_box_for_whitespace, sort_child_properties_last, avoid_unnecessary_containers, annotate_overrides

import 'package:flutter/material.dart';
import 'package:historical_bot_app/Login/user_login.dart';
import 'package:historical_bot_app/Splash_screen/splash_contents.dart';

class splash_screen2 extends StatefulWidget {
  const splash_screen2({super.key});

  @override
  State<splash_screen2> createState() => _splash_screen2State();
}

class _splash_screen2State extends State<splash_screen2> {
  // Integer Datatype and currentindex Variable
  int currentindex = 0;
  late PageController _controller;
  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(mainColor('#BCC8F3')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 80,
              left: 290, // Adjust left value to position the "Skip" button
            ),
            // For Navigate to another page through text Gesture Detector will use
            child: GestureDetector(
              onTap: () {
                // If user dont want to see this Splash Screen
                // The Skip Text will Navigate to users direct to the user login
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => user_login()),
                );
              },
              child: Text(
                'Skip',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'Times New Roman',
                ),
              ),
            ),
          ),
          Expanded(
            // Page View shows that how many pages we need,
            //We Just need 3 Splash screen so we initilize index variable
            child: PageView.builder(
              controller: _controller,
              itemCount: contents.length,
              onPageChanged: (int index) {
                setState(() {
                  currentindex = index;
                });
              },
              // We need 3 images for 3 Splash Screen so
              //instead of initialize every image singly so this
              // Array function automatically initialize every image aacording to the page where we declare i variable
              itemBuilder: (_, i) {
                return Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 5,
                          ),
                          child: Image.asset(
                            contents[i].image,
                            height: 250, // Set a fixed height for the images
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        // same as dont write title for every page we just created the array for splash contents overthere
                        // just need of i Vraible for declare the title
                        contents[i].title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Times New Roman',
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        // same as dont write Description for every page we just created the array for splash contents overthere
                        // just need of i Varaible for declare the description
                        contents[i].description,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Times New Roman',
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // List Generate how much we declare list in the splash contents should start shown in the screen
              children: List.generate(
                contents.length,
                (index) => buildDot(index, context),
              ),
            ),
          ),
          Container(
            height: 40,
            margin: EdgeInsets.all(30),
            width: 130,
            // if you dont want to skip then form the next button you will see every splash screen
            child: ElevatedButton(
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(5),
                backgroundColor: MaterialStateProperty.all(Colors.black),
                foregroundColor: MaterialStateProperty.all(Colors.white),
                minimumSize: MaterialStateProperty.all(
                  Size(20, 30), // Set button size
                ),
              ),
              child: Text(
                // we hvae 3 splash screen so on first 2 splash screen it will show next on the button
                //and on the last Splash screen it will show continue on the button
                currentindex == contents.length - 1 ? "Continue" : "Next",
              ),
              onPressed: () {
                // Thats why we call this function in a if else statment if we press next so it will go to next screen
                // on last splash screen it will show continue on the button for that
                //if we click on continue it will also navigate to user to user login
                if (currentindex == contents.length - 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => user_login()),
                  );
                } else {
                  // this else function will show how much time it will take to go on the next screen
                  _controller.nextPage(
                    duration: Duration(milliseconds: 100),
                    curve: Curves.bounceIn,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  // This Function for showing dots in the screen and dots will also animate when we click on next button or slide the screen
  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: currentindex == index ? 30 : 10,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.black,
      ),
    );
  }
}

int mainColor(String i) {
  String source_color = '0xff' + i;
  source_color = source_color.replaceAll('#', '');
  int destination_color = int.parse(source_color);
  return destination_color;
}
