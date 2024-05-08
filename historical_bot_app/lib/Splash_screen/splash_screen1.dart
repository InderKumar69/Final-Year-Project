// ignore_for_file: camel_case_types, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings, non_constant_identifier_names, override_on_non_overriding_member, annotate_overrides, avoid_unnecessary_containers, unnecessary_import

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:historical_bot_app/Splash_screen/splash_screen2.dart';

class splash_screen1 extends StatefulWidget {
  const splash_screen1({super.key});

  @override
  State<splash_screen1> createState() => _splash_screen1State();
}

class _splash_screen1State extends State<splash_screen1>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    // Our First Splash Screen 1 which show our Bot Logo for How much time it will show in the Screen
    Future.delayed(Duration(seconds: 5), () {
      // After the 3 seconds time it will navigate to our 2nd Splash Screen Which will give our users little information about Guide Bot App
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => splash_screen2()));
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          //  Background color of our splash screen
          backgroundColor: Color(
            mainColor('#BCC8F3'),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            // Linear Gradient Design for 2 colors shown in the screen
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(
                    mainColor('#384984'),
                  ),
                  Color(
                    mainColor('#BCC8F3'),
                  ),
                  Color(
                    mainColor('#BCC8F3'),
                  ),
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
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // AR Bot Image which is the main logo of this App shown to users
                Image.asset(
                  'assets/robot1.png',
                  scale: 1.1,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// this is main Function of color for this App we dont need to add this function in every dart file
//instead Just need the Package of this file where we need to add the primary color
int mainColor(String i) {
  String source_color = '0xff' + i;
  source_color = source_color.replaceAll('#', '');
  int destination_color = int.parse(source_color);
  return destination_color;
}
