// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names, unused_local_variable, unused_import,

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:historical_bot_app/Splash_screen/splash_screen1.dart';
import 'package:historical_bot_app/firebase_options.dart';
import 'package:historical_bot_app/test.dart';

void main() async {
  // For Flutter binding with Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      // It will navigate to our First App Screen We Will start the development from the splash screen1 instead of main.dart file
      initialRoute: 'splash_screen1',
      routes: {
        'splash_screen1': (context) => const splash_screen1(),
      },
      //home: HistoricalPlacesScreen(),
    ),
  );
}
