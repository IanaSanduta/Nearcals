import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:nearcals/shared/userLang.dart';

class Maps extends StatefulWidget {
  const Maps({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Maps> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(40.7802238, -111.876325);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _requestPermission() async {
    Location location = Location();

    Future<bool> _serviceEnabled;
    Future<PermissionStatus> _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = location.serviceEnabled();
    if (_serviceEnabled == false) {
      _serviceEnabled = location.requestService();
      if (_serviceEnabled == false) {
        return;
      }
    }

    _permissionGranted = location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
  }

  @override
  Widget build(BuildContext context) {
    _requestPermission();

    return Scaffold(
      appBar: AppBar(
        title: Text(text('Foodie Map')),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 11.0,
        ),
      ),
    );
  }
}
