import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapsScreen extends StatefulWidget {
  @override
  _MapsScreenState createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  late GoogleMapController _controller;
  Set<Marker> _markers = {};
  late Position _currentPosition;

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentPosition = position;
      _controller.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(_currentPosition.latitude, _currentPosition.longitude),
        ),
      );
      _markers.add(
        Marker(
          markerId: MarkerId('currentLocation'),
          position: LatLng(_currentPosition.latitude, _currentPosition.longitude),
          infoWindow: InfoWindow(title: 'Current Location'),
        ),
      );
    });
  }

  void _addMarker(LatLng position) {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId(position.toString()),
          position: position,
          infoWindow: InfoWindow(title: 'Custom Marker'),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Maps Screen'),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: LatLng(37.7749, -122.4194),
          zoom: 10,
        ),
        markers: _markers,
        onTap: _addMarker,
      ),
    );
  }
}
