// ignore_for_file: camel_case_types, prefer_const_constructors, avoid_print, unused_import, unused_local_variable

import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:camera/camera.dart';

class qissakhwani_recognition extends StatefulWidget {
  const qissakhwani_recognition({super.key});

  @override
  State<qissakhwani_recognition> createState() =>
      _qissakhwani_recognitionState();
}

class _qissakhwani_recognitionState extends State<qissakhwani_recognition> {
  Interpreter? _interpreter;
  List<String>? _labels;
  late CameraController _cameraController;
  late List<CameraDescription> _cameras;
  bool _cameraInitialized = false;

  final _modelPath = 'assets/model_unquantt.tflite';
  final _labelPath = 'assets/labels.txt';

  @override
  void initState() {
    super.initState();
    _loadModel();
    _loadLabels();
    _initializeCamera();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  Future<void> _loadModel() async {
    final interpreterOptions = InterpreterOptions();

    if (Platform.isAndroid) {
      interpreterOptions.addDelegate(XNNPackDelegate());
    } else if (Platform.isIOS) {
      interpreterOptions.addDelegate(GpuDelegate());
    }

    _interpreter =
        await Interpreter.fromAsset(_modelPath, options: interpreterOptions);
  }

  Future<void> _loadLabels() async {
    final labelsRaw = await rootBundle.loadString(_labelPath);
    _labels = labelsRaw.split('\n');
  }

  void _initializeCamera() async {
    _cameras = await availableCameras();
    _cameraController = CameraController(
      _cameras[0], // Use the back camera
      ResolutionPreset.medium,
      enableAudio: false,
    );

    await _cameraController.initialize();
    setState(() {
      _cameraInitialized = true;
    });

    _cameraController.startImageStream((CameraImage cameraImage) {
      // Process cameraImage asynchronously
      _processCameraImage(cameraImage);
    });
  }

  Future<void> _processCameraImage(CameraImage cameraImage) async {
    if (_interpreter == null || _labels == null) {
      return;
    }

    final imageMatrix = _convertCameraImageToMatrix(cameraImage);
    final output = _runInference(imageMatrix);

    final locationsRaw = output.first.first as List<List<double>>;
    final locations = locationsRaw.map((list) {
      return list.map((value) => (value * 300).toInt()).toList();
    }).toList();

    final classesRaw = output.elementAt(1).first as List<double>;
    final classes = classesRaw.map((value) => value.toInt()).toList();

    final scores = output.elementAt(2).first as List<double>;

    final numberOfDetectionsRaw = output.last.first as double;
    final numberOfDetections = numberOfDetectionsRaw.toInt();

    // Process results and display bounding boxes or other relevant information
    // You can use a custom widget to draw on the preview or display results
    // based on your requirements.
  }

  List<List<List<num>>> _convertCameraImageToMatrix(CameraImage cameraImage) {
    final imageMatrix = List.generate(
      300,
      (y) => List.generate(
        300,
        (x) => [0, 0, 0], // Default RGB values
      ),
    );

    // Additional code to convert CameraImage to 300x300 RGB matrix may be required
    // This code might need additional conversion logic based on the image format
    // You might need to refer to CameraImage conversion code

    return imageMatrix;
  }

  List<List<Object>> _runInference(List<List<List<num>>> imageMatrix) {
    final input = [imageMatrix];
    final output = {
      0: [List<List<num>>.filled(10, List<num>.filled(4, 0))],
      1: [List<num>.filled(10, 0)],
      2: [List<num>.filled(10, 0)],
      3: [0.0],
    };

    _interpreter!.runForMultipleInputs([input], output);
    return output.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Object Detection')),
      body: _cameraInitialized
          ? CameraPreview(_cameraController)
          : Center(child: CircularProgressIndicator()),
    );
  }
}
