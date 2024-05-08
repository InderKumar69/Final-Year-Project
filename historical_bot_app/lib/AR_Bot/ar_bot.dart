// ignore_for_file: unused_import, sized_box_for_whitespace, prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class ARBot extends StatefulWidget {
  const ARBot({Key? key}) : super(key: key);

  get arbotKey => null;

  @override
  State<ARBot> createState() => _ARBotState();
}

class _ARBotState extends State<ARBot> {
  void moveToCoordinates(double latitude, double longitude) {
    // Robot ko coordinates par move karne ka logic
    print("Moving robot to coordinates: $latitude, $longitude");
    // Is implementation mein, aapke AR environment mein 3D model ko update karna hai
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 140, left: 65),
      child: Container(
        height: 250,
        width: 250,
        child: ModelViewer(
          src: "assets/images/latest_bot.glb",
        ),
      ),
    );
  }
}
