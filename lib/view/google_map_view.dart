import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapView extends StatefulWidget {
  const GoogleMapView({super.key});

  @override
  State<GoogleMapView> createState() => _GoogleMapViewState();
}

class _GoogleMapViewState extends State<GoogleMapView> {

  late GoogleMapController _controller;

  static final CameraPosition _cameraPosition = const CameraPosition(
    target: LatLng(22.329009785254826, 91.82689845073311),
    zoom: 14,
  );

  final List<Marker> _markers = [];
  final List<Marker> _list = const [
    Marker(
    markerId: MarkerId('1'),
    position: LatLng(22.329009785254826, 91.82689845073311),
    infoWindow: InfoWindow(
      title: 'My Home',
    ),
  )
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _markers.addAll(_list);
  }

  void _onMapCreated(GoogleMapController controller)
  {
    _controller = controller;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          onMapCreated: _onMapCreated,
          markers: Set.of(_markers),
          compassEnabled: true,
          initialCameraPosition: _cameraPosition,
          
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.location_disabled_outlined),
        onPressed: ()async{
          _controller.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(52.520008, 13.404954),
              zoom: 14,
            )
          ));
          setState(() {
            
          });
        }
      ),
    );
  }
}