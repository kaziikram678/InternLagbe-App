import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class PolylineTwo extends StatefulWidget {
  const PolylineTwo({Key? key}) : super(key: key);

  @override
  _PolylineTwoState createState() => _PolylineTwoState();
}

class _PolylineTwoState extends State<PolylineTwo> {

  Completer<GoogleMapController> _controller = Completer();
  CameraPosition _cameraPosition =  CameraPosition(
    target: LatLng(22.3333489072997, 91.8253220126988),
    zoom: 14,
  );
  static const LatLng _center = const LatLng(22.3333489072997, 91.8253220126988);
  final Set<Marker> _markers = {};
  final Set<Polyline>_polyline={};

  LatLng _lastMapPosition = _center;

  List<LatLng> latlng = [LatLng(22.3333489072997, 91.8253220126988) , LatLng(22.334505054570876, 91.8331433341791)];

  @override
  void initState() {
    super.initState();
    for(int i = 0 ; i < latlng.length ; i++){
      setState(() {
        _markers.add(Marker(
          markerId: MarkerId(i.toString()),
          position: latlng[i],
          icon: BitmapDescriptor.defaultMarker,

        ));
        _polyline.add(Polyline(
          polylineId: PolylineId(i.toString()),
          visible: true,
          points: latlng,
          color: Colors.red,
        ));
      });

    }

  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
          body:GoogleMap(
            polylines:_polyline,
            markers: _markers,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            myLocationEnabled:true,
            initialCameraPosition: _cameraPosition,
            mapType: MapType.normal,
          )),
    );
  }

}