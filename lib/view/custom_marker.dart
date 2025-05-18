import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class CustomMarker extends StatefulWidget {
  const CustomMarker({Key? key}) : super(key: key);

  @override
  _CustomMarkerState createState() => _CustomMarkerState();
}

class _CustomMarkerState extends State<CustomMarker> {

  final Completer<GoogleMapController> _controller = Completer();

  List<String> images = [ 'assets/images/bus.png' ,'assets/images/car.png', 'assets/images/cycle-rickshaw.png' , 'assets/images/cycling.png', 'assets/images/delivery-bike.png' , 'assets/images/truck.png' ,];

  Uint8List? markerImage;
  final List<Marker> _markers =  <Marker>[];
  final List<LatLng> _latLang =  <LatLng>[
    LatLng(22.3333489072997, 91.8253220126988), LatLng(22.332465663875208, 91.82771990757534) ,LatLng(22.332296953818048, 91.83135161857507),
    LatLng(22.334505054570876, 91.8331433341791), LatLng(22.337273814679392, 91.83085809212902), LatLng(22.336504720154995, 91.8324405954368)];

  static const CameraPosition _cameraPosition =  CameraPosition(
    target: LatLng(22.3333489072997, 91.8253220126988),
    zoom: 15,
  );


  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData()async{

    for(int i = 0 ; i < images.length ; i++){

      final Uint8List markerIcon = await getBytesFromAsset(images[i].toString(), 30);
      _markers.add(Marker(
          markerId: MarkerId(i.toString()),
          position: _latLang[i],
          icon: BitmapDescriptor.bytes(markerIcon),
          infoWindow: InfoWindow(
              title: 'The title of the marker'
          )
      ));
      setState(() {

      });
    }



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Customer Marker'),
      ),
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _cameraPosition,
          mapType: MapType.normal,
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          markers: Set<Marker>.of(_markers),
          onMapCreated: (GoogleMapController controller){
            _controller.complete(controller);
          },
        ),

      ),
    );
  }
}