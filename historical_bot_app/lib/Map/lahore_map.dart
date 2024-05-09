// ignore_for_file: camel_case_types, prefer_const_constructors, no_leading_underscores_for_local_identifiers, unused_local_variable, unused_import, unused_element, avoid_print, avoid_function_literals_in_foreach_calls, non_constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:historical_bot_app/Dashboard/dashboard.dart';
import 'package:historical_bot_app/Dashboard/user_account.dart';
import 'package:historical_bot_app/Lahore_place/lahore_places.dart';
import 'package:historical_bot_app/Login/user_login.dart';
import 'package:historical_bot_app/Peshawar_place/pesh_places.dart';
import 'package:historical_bot_app/Splash_screen/splash_screen1.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';

class lahore_map extends StatefulWidget {
  const lahore_map({super.key});

  @override
  State<lahore_map> createState() => _lahore_mapState();
}

class _lahore_mapState extends State<lahore_map> {
  late GoogleMapController _mapController;
  final TextEditingController _searchController = TextEditingController();
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};
  LatLng _currentLocation = LatLng(34.0151, 71.5249); // Default location
  String googleApiKey = "";

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);

        _markers.add(Marker(
          markerId: MarkerId("current_location"),
          position: _currentLocation,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ));
      });

      _mapController
          .animateCamera(CameraUpdate.newLatLngZoom(_currentLocation, 14));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Failed to get current location"),
      ));
    }
  }

  Future<void> _searchLocation() async {
    final address = _searchController.text.trim();
    if (address.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please enter a destination."),
      ));
      return;
    }

    try {
      final locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        final searchedLocation = LatLng(
          locations.first.latitude,
          locations.first.longitude,
        );

        setState(() {
          _markers.add(Marker(
            markerId: MarkerId("searched_location"),
            position: searchedLocation,
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueViolet),
          ));

          _mapController
              .animateCamera(CameraUpdate.newLatLngZoom(searchedLocation, 14));

          // Draw Polyline
          _drawPolyline(_currentLocation, searchedLocation);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Error finding location."),
      ));
    }
  }

  Future<void> _drawPolyline(LatLng start, LatLng end) async {
    try {
      print("Start Location: ${start.latitude}, ${start.longitude}");
      print("End Location: ${end.latitude}, ${end.longitude}");

      PolylinePoints polylinePoints = PolylinePoints();

      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleApiKey,
        PointLatLng(start.latitude, start.longitude),
        PointLatLng(end.latitude, end.longitude),
        travelMode: TravelMode.driving,
      );

      if (result.points.isNotEmpty) {
        List<LatLng> polylineCoordinates = result.points
            .map((point) => LatLng(point.latitude, point.longitude))
            .toList();

        setState(() {
          _polylines.add(
            Polyline(
              polylineId: PolylineId("route"),
              color: Colors.blue,
              width: 6,
              points: polylineCoordinates,
            ),
          );
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to get route")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error drawing route: ${e.toString()}")),
      );
    }
  }

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
          GoogleMap(
            onMapCreated: (GoogleMapController controller) {
              _mapController = controller;
            },
            initialCameraPosition: CameraPosition(
              target: _currentLocation,
              zoom: 12,
            ),
            markers: _markers,
            polylines: _polylines,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 45,
              left: 30,
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
          Padding(
            padding: const EdgeInsets.only(top: 52, left: 320),
            child: GestureDetector(
              onTap: () {
                // Handle tap on new page image
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => pesh_places())));
              },
              child: Image.asset(
                'assets/new_page.png',
                width: 50, // Adjust the size as needed
                height: 50, // Adjust the size as needed
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 120, left: 55),
            child: Container(
              height: 180,
              width: 280,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), // Shadow color
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // Changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 15,
                    ),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        prefixIcon:
                            Icon(Icons.location_on, color: Colors.black),
                        hintText: 'Enter your Destination',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 28,
                    ),
                    child: ElevatedButton(
                      onPressed: _searchLocation,
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(8),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        minimumSize: MaterialStateProperty.all(
                          Size(30, 55), // Set button size
                        ),
                      ),
                      child: Text('Show Route'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
