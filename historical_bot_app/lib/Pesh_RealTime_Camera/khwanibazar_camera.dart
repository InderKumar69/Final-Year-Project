// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, avoid_print, camel_case_types, use_key_in_widget_constructors, unused_import, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:historical_bot_app/AR_Bot/ar_bot.dart';
import 'package:historical_bot_app/Peshawar_place/pesh_places.dart';
import 'package:flutter_tts/flutter_tts.dart';

class khwanibazar_camera extends StatefulWidget {
  const khwanibazar_camera({Key? key});

  @override
  State<khwanibazar_camera> createState() => _khwanibazar_cameraState();
}

class _khwanibazar_cameraState extends State<khwanibazar_camera> {
  late List<CameraDescription> cameras;
  late CameraController cameraController;
  bool isPlaying = false; // State variable to track button state
  FlutterTts flutterTts = FlutterTts();
  bool _sidebarVisible = false;
  bool isEnglish = true; // To track selected language
  ARBot arBot = ARBot(); // ARBot ka instance

  @override
  void initState() {
    super.initState();
    startCamera();
    _initializeTTS(); // Initialize TTS with selected language
  }

  void startCamera() async {
    cameras = await availableCameras();

    cameraController = CameraController(
      cameras[0],
      ResolutionPreset.max,
      enableAudio: true,
    );

    await cameraController.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {}); // To refresh widget
    }).catchError((e) {
      print(e);
    });
  }

  void _initializeTTS() async {
    flutterTts.setLanguage(isEnglish ? 'en-US' : 'ur-PK'); // Set the language
    flutterTts.setSpeechRate(1.5); // Faster speech rate
    flutterTts.setPitch(1.0); // Normal pitch
  }

  void togglePlay() {
    if (isPlaying) {
      flutterTts.stop(); // Stop if playing
    } else {
      String message = isEnglish
          ? "Qissa Khawani is the place where caravans from Central Asia and India used to stay..."
          : "قصہ خوانی وہ جگہ ہے جہاں وسطی ایشیا اور ہندوستان سے قافلے کاروباری مقاصد کے لیے سفر کرتے تھے...";
      flutterTts.speak(message); // Speak in the selected language
    }

    setState(() {
      isPlaying = !isPlaying; // Toggle state
    });
  }

  @override
  void dispose() {
    flutterTts.stop(); // Stop TTS when disposing
    cameraController.dispose();
    super.dispose();
  }

  // Initialize Text-to-Speech with a male robotic voice
  void initTextToSpeech() async {
    await flutterTts.setLanguage('en-US'); // Set language
    await flutterTts.setSpeechRate(0.5); // Set speech rate
    await flutterTts.setPitch(1.0); // Set pitch

    // Retrieve the list of available voices
    var voices = await flutterTts.getVoices;

    // Find a voice that resembles a male robot
    var robotLikeVoice = voices.firstWhere(
      (voice) =>
          voice.name.toLowerCase().contains('robot') && voice.gender == 'male',
      orElse: () => voices.firstWhere(
        (voice) => voice.gender == 'male',
        orElse: () => voices.first,
      ),
    );

    await flutterTts.setVoice({
      'name': robotLikeVoice.name,
      'locale': robotLikeVoice.locale,
    });
  }

  void toggleTTS() {
    // Renamed from 'togglePlay' to avoid conflict
    if (isPlaying) {
      flutterTts.stop(); // If speaking, stop
    } else {
      String message = isEnglish
          ? "Qissa Khawani is the place where caravans from Central Asia and India used to stay..."
          : "قصہ خوانی وہ جگہ ہے جہاں وسطی ایشیا اور ہندوستان سے قافلے کاروباری مقاصد کے لیے سفر کرتے تھے...";
      flutterTts.speak(message); // Speak the text
    }

    setState(() {
      isPlaying = !isPlaying; // Toggle state
    });
  }

  void navigateToPlace(String placeName) {
    switch (placeName) {
      case "Chowk Yadgar":
        moveRobot(34.0113, 71.5805);
        break;
      case "Ghanta Ghar":
        moveRobot(34.0097, 71.5839);
        break;
      case "Tehsil Gor Gathri":
        moveRobot(34.0116, 71.5786);
        break;
      case "Muhabbat Khan Mosque":
        moveRobot(34.0077, 71.5834);
        break;
      case "Sethi House":
        moveRobot(34.0115, 71.5795);
        break;
    }
  }

  void moveRobot(double lat, double lon) {
    // ARBot ka moveToCoordinates call karna
    arBot.arbotKey.currentState?.moveToCoordinates(lat, lon);
  }

  Widget _buildLanguageToggle() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                isEnglish = true; // English selected
              });
            },
            child: _buildLanguageCircle("EN", isEnglish),
          ),
          SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              setState(() {
                isEnglish = false; // Urdu selected
              });
            },
            child: _buildLanguageCircle("UR", !isEnglish),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageCircle(String label, bool isActive) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
        color: isActive ? Colors.white : Colors.transparent,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.black : Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildSidebar() {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 300),
      left: _sidebarVisible ? 0 : -200,
      top: 0,
      bottom: 0,
      child: Container(
        width: 200,
        color: Colors.black,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLanguageToggle(), // Language toggle
            Divider(color: Colors.grey), // Optional divider
            _buildSidebarContent(), // Sidebar content
          ],
        ),
      ),
    );
  }

  Widget _buildSidebarContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSidebarBox("Chowk Yadgar"),
        _buildSidebarBox("Ghanta Ghar"),
        _buildSidebarBox("Tehsil Gor Gathri"),
        _buildSidebarBox("Muhabbat Khan Mosque"),
        _buildSidebarBox("Sethi House"),
      ],
    );
  }

  Widget _buildSidebarBox(String name) {
    return GestureDetector(
      onTap: () {
        // Add any navigation or function logic here
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.all(10),
        color: Colors.white,
        child: Text(
          name,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (cameraController.value.isInitialized) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            // Sized box with consistent spacing between icons
            SizedBox(width: 10), // Consistent spacing

            // Container for the back arrow icon
            Container(
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
                  ),
                ],
              ),
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

            // Consistent spacing
            SizedBox(width: 20),

            // Container for the play/pause button
            Container(
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
                  ),
                ],
              ),
              child: IconButton(
                onPressed: togglePlay, // Function to handle start/stop/resume
                icon: Icon(
                  isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.black,
                  size: 30,
                ),
              ),
            ),

            // Consistent spacing
            SizedBox(width: 20),

            // Container for the history image icon
            Container(
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
                  ),
                ],
              ),
              child: IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        height: 250,
                        child: Center(
                          child: SingleChildScrollView(
                            child: Text(
                                'Qissa Khawani is the place where caravans from Central Asia and India used to stay '
                                'as they traveled for business purposes. This is the oldest and most famous bazaar in Peshawar. '
                                'It is just inside the old Kabuli Gate. The storytellers used to tell stories to their guests '
                                'after dinner in numerous sarais of Qissa Khawani.'),
                          ),
                        ),
                      );
                    },
                  );
                },
                icon: Image.asset(
                  "assets/history.png",
                ),
              ),
            ),

            // Consistent spacing
            SizedBox(width: 20),

            // Container for the line weight sharp icon
            Container(
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
                  ),
                ],
              ),
              child: IconButton(
                onPressed: () {
                  setState(() {
                    _sidebarVisible = !_sidebarVisible;
                  });
                },
                icon: Icon(
                  Icons.line_weight_sharp,
                  color: Colors.black,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
        body: Stack(
          children: [
            CameraPreview(cameraController),
            if (_sidebarVisible) _buildSidebar(),
            ARBot(),
            // qissakhwani_recognition(),
          ],
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}
