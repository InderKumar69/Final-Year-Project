// ignore_for_file: camel_case_types, prefer_const_constructors, no_leading_underscores_for_local_identifiers, unused_local_variable, unused_import, unused_element, avoid_print, avoid_function_literals_in_foreach_calls, non_constant_identifier_names

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
import 'package:http/http.dart' as http;
import 'dart:convert';

class lahore_map extends StatefulWidget {
  const lahore_map({super.key});

  @override
  State<lahore_map> createState() => _lahore_mapState();
}

class _lahore_mapState extends State<lahore_map> {
  late GoogleMapController _controller;
  final TextEditingController _searchController = TextEditingController();
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};
  LatLng _currentLocation = LatLng(34.0151, 71.5249); // Default location
  final String _googleApiKey =
      'YOUR_GOOGLE_API_KEY'; // Replace with your API key

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print("Location services are not enabled.");
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print("Location permissions denied.");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print("Location permissions are denied forever.");
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
      _markers.add(
        Marker(
          markerId: const MarkerId("current_location"),
          position: _currentLocation,
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueRed,
          ),
        ),
      );

      // Move the map's camera to the current location
      _controller.animateCamera(
        CameraUpdate.newLatLngZoom(_currentLocation, 14),
      );
    });
  }

  Future<void> _searchLocation() async {
    String address = _searchController.text;
    if (address.isEmpty) {
      print("Please enter a destination.");
      return;
    }

    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        LatLng targetLocation = LatLng(
          locations.first.latitude,
          locations.first.longitude,
        );

        setState(() {
          _markers.add(
            Marker(
              markerId: const MarkerId("searched_location"),
              position: targetLocation,
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueViolet,
              ),
            ),
          );

          // Move the map's camera to the new target location
          _controller.animateCamera(
            CameraUpdate.newLatLngZoom(targetLocation, 14),
          );

          _drawRoute(_currentLocation, targetLocation);
        });
      }
    } catch (e) {
      print("Error searching location: $e");
    }
  }

  Future<void> _drawRoute(LatLng start, LatLng end) async {
    final String url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${start.latitude},${start.longitude}&destination=${end.latitude},${end.longitude}&key=$_googleApiKey';

    final http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);

      if (data['routes'].isNotEmpty) {
        final String polylinePoints =
            data['routes'][0]['overview_polyline']['points'];

        final List<LatLng> polylineCoordinates =
            _decodePolyline(polylinePoints);

        setState(() {
          _polylines.clear(); // Clear previous polylines to avoid stacking
          _polylines.add(
            Polyline(
              polylineId: const PolylineId("route"),
              points: polylineCoordinates,
              color: Colors.blue,
              width: 5,
            ),
          );
        });
      }
    } else {
      print("Failed to get route information.");
    }
  }

  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> points = [];
    int index = 0;
    int lat = 0;
    int lon = 0;

    while (index < encoded.length) {
      int shift = 0;
      int result = 0;
      int b = 0;

      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);

      int dlat = ((result & 1) == 1 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;

      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);

      int dlon = ((result & 1) == 1 ? ~(result >> 1) : (result >> 1));
      lon += dlon;

      points.add(LatLng(lat / 1e5, lon / 1e5));
    }

    return points;
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
              _controller = controller;
            },
            initialCameraPosition: CameraPosition(
              target: _currentLocation,
              zoom: 12.0,
            ),
            markers: _markers,
            polylines: _polylines, // Add polylines to the map
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
