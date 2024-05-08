// ignore_for_file: camel_case_types, prefer_const_constructors, avoid_print, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, unused_import, prefer_final_fields, unused_field

import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:historical_bot_app/AR_Bot/ar_bot.dart';
import 'package:historical_bot_app/Peshawar_place/pesh_places.dart';

class realtime_camera extends StatefulWidget {
  const realtime_camera({super.key});

  @override
  State<realtime_camera> createState() => _realtime_cameraState();
}

class _realtime_cameraState extends State<realtime_camera> {
  late List<CameraDescription> cameras;
  late CameraController cameraController;

  @override
  void initState() {
    startCamera();
    super.initState();
  }

  void startCamera() async {
    cameras = await availableCameras();

    cameraController =
        CameraController(cameras[0], ResolutionPreset.high, enableAudio: true);

    await cameraController.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {}); // To refresh widget
    }).catchError((e) {
      print(e);
    });
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (cameraController.value.isInitialized) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            SizedBox(width: 20), // Adjust spacing between icons

            // Container for the back arrow icon
            Container(
              margin: const EdgeInsets.only(right: 100),
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54,
                    offset: Offset(2, 2),
                    blurRadius: 10,
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 7),
                child: Center(
                  child: IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => pesh_places()),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ),

            // GestureDetector for the history image icon
            Container(
              margin: const EdgeInsets.only(right: 90),
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54,
                    offset: Offset(2, 2),
                    blurRadius: 10,
                  )
                ],
              ),
              child: Center(
                child: IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    "assets/history.png",
                  ),
                ), // History image icon
              ),
            ),

            Container(
              margin: const EdgeInsets.only(right: 20),
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54,
                    offset: Offset(2, 2),
                    blurRadius: 10,
                  )
                ],
              ),
              child: Center(
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.line_weight_sharp,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
              ),
            ),
            // Frosted glass box
            Visibility(
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: 350,
                    width: 250,
                    color: Colors.transparent,
                    child: Stack(
                      children: [
                        BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 5.0,
                            sigmaY: 5.0,
                          ),
                          child: Container(),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.13),
                            ),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.white.withOpacity(0.15),
                                Colors.white.withOpacity(0.05),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Stack(children: [
          CameraPreview(cameraController),
          ARBot(),
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                height: 380,
                width: 250,
                color: Colors.transparent,
                child: Stack(
                  children: [
                    BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 5.0,
                        sigmaY: 5.0,
                      ),
                      child: Container(),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.13),
                        ),
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.white.withOpacity(0.15),
                              Colors.white.withOpacity(0.05),
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),
      );
    } else {
      return const SizedBox();
    }
  }
}
