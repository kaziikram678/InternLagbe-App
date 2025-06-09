import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolylineScreen extends StatefulWidget {
  final List<LatLng> decodedPolyline;

  const PolylineScreen({Key? key, required this.decodedPolyline})
    : super(key: key);

  @override
  _PolylineScreenState createState() => _PolylineScreenState();
}

class _PolylineScreenState extends State<PolylineScreen> {
  Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> _markers = {};
  final Set<Polyline> _polyline = {};

  @override
  void initState() {
    super.initState();

    if (widget.decodedPolyline.isNotEmpty) {
      _markers.add(
        Marker(
          markerId: MarkerId('start'),
          position: widget.decodedPolyline.first,
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueGreen,
          ),
        ),
      );

      _markers.add(
        Marker(
          markerId: MarkerId('end'),
          position: widget.decodedPolyline.last,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
      );

      _polyline.add(
        Polyline(
          polylineId: const PolylineId("route"),
          visible: true,
          points: widget.decodedPolyline,
          color: Colors.blue,
          width: 5,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Job Direction",style: TextStyle(fontSize: 25, fontFamily: "Cabinet Medium", fontWeight: FontWeight.bold, color: Colors.white),)),
        backgroundColor: Colors.blue,
      ),
      body: GoogleMap(
        polylines: _polyline,
        markers: _markers,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        myLocationEnabled: true,
        initialCameraPosition: CameraPosition(
          target: widget.decodedPolyline.first,
          zoom: 14,
        ),
      ),
    );
  }
}
