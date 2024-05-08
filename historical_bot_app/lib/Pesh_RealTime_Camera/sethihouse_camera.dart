// ignore_for_file: camel_case_types, avoid_print, prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:historical_bot_app/AR_Bot/ar_bot.dart';
import 'package:historical_bot_app/Peshawar_place/pesh_places.dart';

class sethihouse_camera extends StatefulWidget {
  const sethihouse_camera({super.key});

  @override
  State<sethihouse_camera> createState() => _sethihouse_cameraState();
}

class _sethihouse_cameraState extends State<sethihouse_camera> {
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
        CameraController(cameras[0], ResolutionPreset.high, enableAudio: false);

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
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          // Add your bottom sheet content here
                          height: 250,
                          child: Center(
                            child: SingleChildScrollView(
                                child: Text( '',
                            )),
                          ),
                        );
                      },
                    );
                  },
                  icon: Image.asset(
                    "assets/history.png",
                  ),
                ), // History image icon
              ),
            ),

            // Container for the line weight sharp icon
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
                  onPressed: () {
                    Navigator.pop(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => pesh_places()),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.line_weight_sharp,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Stack(
          children: [
            CameraPreview(cameraController),
            ARBot(),
          ],
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}
