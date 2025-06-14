import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolylineScreen extends StatefulWidget {
  final List<LatLng> decodedPolyline;
  final double? Distance;

  const PolylineScreen({
    Key? key,
    required this.decodedPolyline,
    required this.Distance,
  }) : super(key: key);

  @override
  _PolylineScreenState createState() => _PolylineScreenState();
}

class _PolylineScreenState extends State<PolylineScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> _markers = {};
  final Set<Polyline> _polyline = {};

  @override
  void initState() {
    super.initState();

    if (widget.decodedPolyline.isNotEmpty) {
      _markers.add(
        Marker(
          markerId: const MarkerId('start'),
          position: widget.decodedPolyline.first,
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueGreen,
          ),
        ),
      );

      _markers.add(
        Marker(
          markerId: const MarkerId('end'),
          position: widget.decodedPolyline.last,
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueRed,
          ),
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
        title: const Center(
          child: Text(
            "Job Direction",
            style: TextStyle(
              fontSize: 25,
              fontFamily: "Cabinet Medium",
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Stack(
  children: [
    // Google Map full screen
    GoogleMap(
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

    // Distance box overlay
    Positioned(
      top: 650,
      left: 20,
      right: 20,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            'Distance: ${widget.Distance?.toStringAsFixed(2) ?? 'N/A'} km',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    ),
  ],
),

    );
  }
}
