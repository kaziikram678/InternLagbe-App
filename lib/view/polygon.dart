import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class PolygoneScreen extends StatefulWidget {
  const PolygoneScreen({Key? key}) : super(key: key);

  @override
  _PolygoneScreenState createState() => _PolygoneScreenState();
}

class _PolygoneScreenState extends State<PolygoneScreen> {

  Completer<GoogleMapController> _controller = Completer();


  CameraPosition _cameraPosition =  CameraPosition(
    target: LatLng(22.3333489072997, 91.8253220126988),
    zoom: 14,
  );
  final Set<Marker> _markers = {};
  Set<Polygon> _polygone = HashSet<Polygon>() ;

  List<LatLng> points = [
    LatLng(22.3333489072997, 91.8253220126988),
    LatLng(22.334505054570876, 91.8331433341791),

    LatLng(22.332465663875208, 91.82771990757534),
    LatLng(22.337273814679392, 91.83085809212902),
    LatLng(22.332296953818048, 91.83135161857507),
    LatLng(22.336504720154995, 91.8324405954368),


    LatLng(22.3333489072997, 91.8253220126988),

  ] ;


  void _setPolygone(){
    _polygone.add(
        Polygon(polygonId: PolygonId('1') ,
            points: points ,
            strokeColor: Colors.deepOrange,
            strokeWidth: 5 ,
            fillColor: Colors.deepOrange.withOpacity(0.1),
            geodesic: true
        )
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setPolygone() ;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('Polygone'),),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _cameraPosition,
        myLocationButtonEnabled: true,
        myLocationEnabled: false,
        markers:_markers ,
        polygons: _polygone,

        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}