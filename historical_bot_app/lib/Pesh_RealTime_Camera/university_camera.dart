// ignore_for_file: camel_case_types, avoid_print, prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, unused_field, depend_on_referenced_packages, await_only_futures, unused_import, unused_local_variable, avoid_unnecessary_containers, unused_element, non_constant_identifier_names, prefer_typing_uninitialized_variables, prefer_final_fields

import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:historical_bot_app/AR_Bot/ar_bot.dart';
import 'package:historical_bot_app/Peshawar_place/pesh_places.dart';
import 'package:camera/camera.dart';

class cityuni_camera extends StatefulWidget {
  const cityuni_camera({super.key});

  @override
  State<cityuni_camera> createState() => _cityuni_cameraState();
}

class _cityuni_cameraState extends State<cityuni_camera> {
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
                                child: Text(
                              'City University of Science and Information Technology (CUSIT)'
                              'Peshawar, is one of the first private sector Universities,'
                              'Chartered by the Government of Khyber Pakhtunkhwa,'
                              'recognized by HEC and accredited by Pakistan Engineering Council,'
                              'National Computing Education Accreditation Council (NCEAC),'
                              'National Accreditation Council for Teacher Education (NACTE) etc.'
                              'for various programs. The University is an extension of'
                              'Peshawar Model Educational Institutions (PMEIs), founded in 1979'
                              'to impart quality education at an affordable cost. In recognition'
                              'of the extra ordinary educational services of PMEIs, the Government'
                              ' of Khyber Pakhtunkhwa (Then N-W.F.P), granted the Charter of'
                              'City University of Science and IT on August 30th, 2001,'
                              'to establish a premier institute of higher education in the'
                              'private sector of KP. The then Governor KPK, Lt. Gen (R)'
                              'Syed Iftikhar Hussain inaugurated the University on Oct 06, 2001'
                              'in the presence of renowned nuclear scientist Dr. Abdul Qadeer Khan.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
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
                  onPressed: () {},
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
